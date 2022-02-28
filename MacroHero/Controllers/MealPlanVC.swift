//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit
import Combine
import PKHUD
import AlamofireImage

class MealPlanVC: UIViewController {
    
    // MARK: - PROPERTIES
    var viewModel: MealPlanVM
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    // MARK: - Initializers
    init(viewModel: MealPlanVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        setupView()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        let label = Utils.createMainTitle(text: "TODAY'S MEAL PLAN",
                                          width: screenWidth * 0.8,
                                          textColor: Color.customNavy,
                                          noOfLines: 1)

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
    
    // MARK: - SETUP FUNCTIONS
    func setupView() {
        view.backgroundColor = Color.bgColor
        
        Utils.setNavigationBar(navController: navigationController, navItem: navigationItem)
        
        HUD.show(.progress)
        HUD.dimsBackground = true
        addSubviews()
        constrainSubviews()
        fetchData()
    }
    
    func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(tableView)
    }
    
    func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.04, usingSafeArea: true)
        
        tableView.centerXToSuperview()
        tableView.width(screenWidth * 0.9)
        tableView.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        tableView.bottomToSuperview()
    }
    
    func fetchData() {
        MealPlanAPI.fetchMealPlan(mealReqs: AllMealReqs(breakfast: viewModel.breakfastReq,
                                                        lunch: viewModel.lunchReq,
                                                        dinner: viewModel.dinnerReq)) { mealPlan in
            self.viewModel.mealPlan = mealPlan
            DispatchQueue.main.async {
                self.tableView.reloadData()
                HUD.hide(animated: true) { _ in
                    HUD.dimsBackground = false
                }
            }
        }
    }
    
    func fetchNewMeal(type: String) {
        HUD.show(.progress)
        HUD.dimsBackground = true
        
        var req: MealReq?
        var removeAt = 0
        
        if type == MealType.breakfast.rawValue {
            req = viewModel.breakfastReq
            removeAt = 0
        } else if type == MealType.lunch.rawValue {
            req = viewModel.lunchReq
            removeAt = 1
        } else if type == MealType.dinner.rawValue {
            req = viewModel.dinnerReq
            removeAt = 2
        }
        
        if let req = req {
            MealPlanAPI.fetchMealBasedOn(req: req) { newMeal in
                if let newMeal = newMeal {
                    self.viewModel.mealPlan.remove(at: removeAt)
                    self.viewModel.mealPlan.append(newMeal)
                    
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
}

extension MealPlanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealPlan.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = viewModel.mealPlan[indexPath.row]
        
        let nextVC = MealDetailsVC(viewModel: .init(mealInfo: meal))
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealCell
        
        // sort meal plan data
        viewModel.mealPlan = viewModel.mealPlan.sorted { $0.mealOrder < $1.mealOrder }
        let meal = viewModel.mealPlan[indexPath.row]

        // populate meal plan cells with sorted data
        if let name = meal.name, let type = meal.type, let image = meal.image, let macros = meal.macros {
            cell.nameLabel.text = name
            cell.typeLabel.text = type.capitalized
            
            if type == "Protein" {
                cell.refreshButton.isHidden = true
            } else {
                cell.refreshButton.isHidden = false
            }
            
            if let url = URL(string: image), image != "defaultMealImage" {
                let filter = AspectScaledToFillSizeFilter(size: cell.imageIV.frame.size)
                cell.imageIV.af.setImage(withURL: url, filter: filter)
            } else {
                cell.imageIV.image = Image.defaultMealImage
            }
            
            cell.calLabel.text = macros.calories
            cell.carbLabel.text = "\(macros.carbs)g"
            cell.proteinLabel.text = "\(macros.protein)g"
            cell.fatLabel.text = "\(macros.fat)g"
            
            cell.buttonAction = {
                print("refresh \(type)")
                self.fetchNewMeal(type: type)
            }
        }
        
        // update cell UI
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
}
