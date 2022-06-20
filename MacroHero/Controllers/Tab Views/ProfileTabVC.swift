//
//  ProfileTabVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/10/22.
//
import Foundation
import UIKit

class ProfileTabVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var userData = UserData()
    var statsData = [TwoLabelCellModel]()
    var proteinData = [TwoLabelCellModel]()
   
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDummyUserData()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: MainLabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(title: "PROFILE", type: .tabView))
        
        return label
    }()
    
    lazy var myStatsLabel: UILabel = {
        var label = UILabel()
        label.text = "My Stats"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    lazy var myStatsTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LabelTextFieldCell.self, forCellReuseIdentifier: "statsCell")
        tableView.register(LabelTextFieldCell.self, forCellReuseIdentifier: "proteinCell")
        
        tableView.backgroundColor = Color.bgColor
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    lazy var proteinMacros: UILabel = {
        var label = UILabel()
        label.text = "Protein Shake Macros"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    // MARK: - FETCH METHODS
    func fetchDummyUserData() {
        userData = UserData(age: "25", heightCm: "160", weightKg: "68",
                            sex: Sex.female, activityLevel: Activity.moderateExercise,
                            goal: Goal.lose,
                            mealPlan: [
                                MealInfo(mealOrder: 0, type: "Protein Shake",
                                         macros: Macros(calories: "130", carbs: "16",
                                                        protein: "22", fat: "16"))
                            ])
        
        guard let goal = userData.goal, let age = userData.age,
              let height = userData.heightCm,
              let weight = userData.weightKg,
              let activity = userData.activityLevel else { return }
        
        statsData = [
            TwoLabelCellModel(title: "Goal", value: goal.rawValue),
            TwoLabelCellModel(title: "Age", value: age),
            TwoLabelCellModel(title: "Height", value: height),
            TwoLabelCellModel(title: "Weight", value: weight),
            TwoLabelCellModel(title: "Activity Level", value: activity.rawValue)
        ]
        
        guard let proteinInfo = userData.mealPlan?.last,
              proteinInfo.type == "Protein Shake" else { return }
        
        proteinData = [
            TwoLabelCellModel(title: "Calories", value: "130"),
            TwoLabelCellModel(title: "Carbs (g)", value: "16"),
            TwoLabelCellModel(title: "Protein (g)", value: "22"),
            TwoLabelCellModel(title: "Fat (g)", value: "16")
        ]
    }
}

extension ProfileTabVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if proteinData.isEmpty {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        if section == 0 {
            label.text = "My Stats"
        } else {
            label.text = "Protein Shake Macros"
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 5 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell") as! LabelTextFieldCell
            
            let cellData = statsData[indexPath.row]
            cell.configure(with: TwoLabelCellModel(title: cellData.title,
                                                value: cellData.value))
            cell.backgroundColor = Color.customYellow
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "proteinCell") as! LabelTextFieldCell
        
        let cellData = proteinData[indexPath.row]
        cell.configure(with: TwoLabelCellModel(title: cellData.title,
                                            value: cellData.value))
        
        cell.backgroundColor = Color.customYellow
        
        return cell
    }
}

extension ProfileTabVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        autoLayoutViews()
        constrainViews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(myStatsTableView)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        myStatsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myStatsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myStatsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            myStatsTableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.01),
            myStatsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// Add in allergies
// Food intolerances + food preferences
// Groceries tab - add to groceries, buy from instacart?
