//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit
import PKHUD
import AlamofireImage
import Inject

class MealPlanTabVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var mealPlan = [MealInfo]()
    
    // TODO: Generate in the app before this screen, pass it to this screen
    var breakfastReq = MealReq(type: MealType.breakfast.rawValue,
                               macros: Macros(calories: "100+", carbs: "20+",
                                                 protein: "15+", fat: "10+"),
                               random: true,
                               macroPriority: MacroPriority(macro1: "calories",
                                                            macro2: "protein"))
    var lunchReq = MealReq(type: MealType.lunch.rawValue,
                           macros: Macros(calories: "100+", carbs: "20+",
                                             protein: "15+", fat: "10+"),
                           random: true,
                           macroPriority: MacroPriority(macro1: "calories",
                                                        macro2: "protein"))
    var dinnerReq = MealReq(type: MealType.dinner.rawValue,
                            macros: Macros(calories: "100+", carbs: "20+",
                                              protein: "15+", fat: "10+"),
                            random: true,
                            macroPriority: MacroPriority(macro1: "calories",
                                                         macro2: "protein"))
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchDummyMealPlan()
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
    func fetchDummyMealPlan() {
        mealPlan = [
            MealInfo(mealOrder: 0, imageURL: "", type: MealType.breakfast.rawValue, name: "Poached Egg & Avocado Toast with Sliced Cherry Tomatoes", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: ""),
            MealInfo(mealOrder: 1, imageURL: "", type: MealType.lunch.rawValue, name: "Poached Egg & Avocado Toast", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: ""),
            MealInfo(mealOrder: 2, imageURL: "", type: MealType.dinner.rawValue, name: "Poached Egg & Avocado Toast with Sliced Cherry Tomatoes", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: "")
        ]
    }
    
    func fetchMealPlan() {
        MealPlanManager.fetchMealPlan(mealReqs: [breakfastReq, lunchReq, dinnerReq]) { results in
            self.mealPlan = results
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
        var removeAt = Int()

        if type == MealType.breakfast.rawValue {
            req = breakfastReq
            removeAt = 0
        } else if type == MealType.lunch.rawValue {
            req = lunchReq
            removeAt = 1
        } else if type == MealType.dinner.rawValue {
            req = dinnerReq
            removeAt = 2
        }

        if let req = req {
            MealPlanManager.fetchMealBasedOn(req) { newMeal in
                self.mealPlan.remove(at: removeAt)
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

        // populate cell with sorted data
        
        cell.configure(with: MealCellModel(mealInfo: mealInfo, refreshAction: {
            print("refresh \(String(describing: mealInfo.type))")
//            self.fetchNewMeal(type: type)
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
