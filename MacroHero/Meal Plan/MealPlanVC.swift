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
    private var viewModel: MealPlanVM
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    struct Cells {
        static let mealCell = "MealCell"
    }
    
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
        HUD.show(.progress)
        HUD.dimsBackground = true
        viewModel.fetchAllMealData(mealReqs: AllMealReqs(breakfast: viewModel.breakfastReq,
                                                         lunch: viewModel.lunchReq,
                                                         dinner: viewModel.dinnerReq)) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                HUD.hide(animated: true) { _ in
                    HUD.dimsBackground = false
                }
            }
        }
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
        tableView.rowHeight = 300
        tableView.register(MealCell.self, forCellReuseIdentifier: Cells.mealCell)
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    func setupView() {
        view.backgroundColor = Color.bgColor
        
        Utils.setNavigationBar(navController: navigationController, navItem: navigationItem)
        
        addSubviews()
        constrainSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(tableView)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.04, usingSafeArea: true)
        
        tableView.centerXToSuperview()
        tableView.width(screenWidth * 0.9)
        tableView.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        tableView.bottomToSuperview()
    }
}


extension MealPlanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mealCell) as! MealCell
        
        let orderedMealPlan = viewModel.mealPlan.sorted {
            $0.mealOrder < $1.mealOrder
        }
        let meal = orderedMealPlan[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        
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
        }
        
        return cell
    }
   
}
