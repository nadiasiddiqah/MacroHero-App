//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit
import PKHUD
import Inject

class MealPlanTabVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var mealPlan = [MealInfo]()
    var userData: UserData
    
    // MARK: - INITIALIZERS
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMealPlan()
        setupView()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "TODAY'S MEAL PLAN",
            type: .tabView
        ))
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MealCell.self, forCellReuseIdentifier: "mealCell")
        
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - FETCH DATA
    func fetchMealPlan() {
        guard let mealReqs = userData.mealReqs else { return }
        
        MealPlanManager.fetchMealPlan(mealReqs: mealReqs) { results in
            DispatchQueue.main.async {
                HUD.dimsBackground = true
                HUD.show(.progress)
            }
            
            self.mealPlan = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
                HUD.hide(animated: true) { _ in
                    HUD.dimsBackground = false
                }
            }
        }
    }
    
    func fetchNewMeal(type: String, req: MealReq?) {
        guard let req = req else { return }
        
        MealPlanManager.fetchMealBasedOn(req) { result in
            DispatchQueue.main.async {
                HUD.dimsBackground = true
                HUD.show(.progress)
            }
            
            var newMeal = result
            
            MealPlanManager.loadImageURL(for: newMeal) { image in
                newMeal.image = image
                self.mealPlan.removeAll(where: { $0.type == type })
                self.mealPlan.append(newMeal)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    HUD.hide(animated: true) { _ in
                        HUD.dimsBackground = false
                    }
                }
             }
        }
    }
}

extension MealPlanTabVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlan.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealCell

        // sort meal plan data
        mealPlan = mealPlan.sorted { $0.mealOrder < $1.mealOrder }
        let mealInfo = mealPlan[indexPath.row]
        print("\(indexPath.row) \(mealInfo.name) \(mealInfo.type)")

        // populate cell with sorted data
        cell.configure(with: MealCellModel(mealInfo: mealInfo, refreshAction: {
            print("clicked refresh \(mealInfo.type)")
            if let type = mealInfo.type, let mealReqs = self.userData.mealReqs {
                self.fetchNewMeal(type: type, req: mealReqs.first(where: { $0.type == type }))
            }
        }, starButtonAction: {
            print("starred")
        }))

        // update cell UI
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = mealPlan[indexPath.row]

        let nextVC = Inject.ViewControllerHost(MealDetailsVC(mealInfo: selectedMeal))
        navigationController?.navigationBar.tintColor = Color.customNavy
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MealPlanTabVC {
    func setupView() {
        view.backgroundColor = Color.bgColor
        // TODO: Investigate why HUD isn't showing
        HUD.show(.progress)
        HUD.dimsBackground = true
        addSubviews()
        autoLayoutViews()
        constrainSubviews()
    }
    
    func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(tableView)
    }
    
    func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            tableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.02),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
