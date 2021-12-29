//
//  RankViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/27/21.
//

import Foundation
import TinyConstraints
import Gifu
import DropDown

class RankViewController: UIViewController {
    
    let calories = "Calories (1890)"
    let carbs = "Carbs (215g)"
    let protein = "Protein (145g)"
    let fat = "Fat (55g)"
    var collapsedFirstGoal: Constraint?
    var expandedFirstGoal: Constraint?
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        let label = createMainTitle(text: """
            Rank top two macro
            goals:
            """,
            width: screenWidth * 0.9,
            noOfLines: 2
        )
        
        return label
    }()
    
    // MARK: - FIRST GOAL
    lazy var firstGoal: UILabel = {
        let label = UILabel()
        label.text = "#1"
        label.font = UIFont(name: "KGHAPPYSolid", size: 20)
        label.textColor = UIColor(named: "orange")
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    lazy var firstGoalButton: UIButton = {
        let button = UIButton()
        
        button.width(screenWidth * 0.57)
        button.setBackgroundImage(UIImage(named: "rankTextArea"), for: .normal)
        button.addTarget(self, action: #selector(didTapFirstGoal), for: .touchUpInside)
        
        return button
    }()
    
    
    #warning("add functionality to customize dropdown + revert back to collapsedFirstGoal when dropdown isn't present")
    @objc func didTapFirstGoal() {
        let firstGoalDropDown = DropDown()
        let goalData = ["\(calories)", "\(carbs)", "\(protein)", "\(fat)"]
        
        collapsedFirstGoal?.isActive = false
        UIView.animate(withDuration: 0.3) {
            self.expandedFirstGoal?.isActive = true
            self.secondGoalHStack.layoutIfNeeded()
        }
        
        createDropDown(dropDown: firstGoalDropDown, dataSource: goalData,
                       anchorView: firstGoalButton)
        firstGoalDropDown.bottomOffset = CGPoint(x: 0, y: firstGoalButton.frame.size.height + screenHeight * 0.01)
        firstGoalDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.firstGoalLabel.text = item
        }
    }
    
    lazy var firstGoalLabel: UILabel = {
        let label = UILabel()
        label.text = calories
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = UIColor.black
        label.width(screenWidth * 0.42)

        return label
    }()
    
    
    lazy var firstGoalHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [firstGoal, firstGoalButton])
        HStack.axis = .horizontal
        HStack.spacing = screenWidth * 0.03
        
        return HStack
    }()
    
    // MARK: - SECOND GOAL
    lazy var secondGoal: UILabel = {
        let label = UILabel()
        label.text = "#2"
        label.font = UIFont(name: "KGHAPPYSolid", size: 20)
        label.textColor = UIColor(named: "orange")
        label.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.09, height: screenHeight * 0.03)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    lazy var secondGoalButton: UIButton = {
        let button = UIButton()
        
        button.width(screenWidth * 0.57)
        button.setBackgroundImage(UIImage(named: "rankTextArea"), for: .normal)
        button.addTarget(self, action: #selector(didTapSecondGoal), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapSecondGoal() {
        let secondGoalDropDown = DropDown()
        let goalData = ["\(calories)", "\(carbs)", "\(protein)", "\(fat)"]
        
        createDropDown(dropDown: secondGoalDropDown, dataSource: goalData,
                       anchorView: secondGoalButton)
        secondGoalDropDown.bottomOffset = CGPoint(x: 0, y: secondGoalButton.frame.size.height)
        secondGoalDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.secondGoalLabel.text = item
        }
    }
    
    lazy var secondGoalLabel: UILabel = {
        let label = UILabel()
        label.text = protein
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = UIColor.black
        label.width(screenWidth * 0.42)

        return label
    }()
    
    lazy var secondGoalHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [secondGoal, secondGoalButton])
        HStack.axis = .horizontal
        HStack.spacing = screenWidth * 0.03
        
        return HStack
    }()
  
    // MARK: - TAP METHODS
    
    
    // MARK: - FUNCTIONS
}
