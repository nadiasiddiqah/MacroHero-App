//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit

class MealPlanViewController: UIViewController {
    
    var breakfast = "Poached Egg & Avocado Toast"
    var breakfastMacros = MacroBreakdown(calories: "393", carbs: "60g", protein: "23 g", fat: "20 g")
    
    var lunch = "Poached Egg & Avocado Toast"
    var lunchMacros = MacroBreakdown(calories: "393", carbs: "60g", protein: "23 g", fat: "20 g")
    
    var dinner = "Poached Egg & Avocado Toast"
    var dinnerMacros = MacroBreakdown(calories: "393", carbs: "60g", protein: "23 g", fat: "20 g")
    
    var proteinShake = "Protein Shake"
    var proteinShakeMacros = MacroBreakdown(calories: "393", carbs: "60g", protein: "23 g", fat: "20 g")

    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        let label = createMainTitle(text: "TODAY'S MEAL PLAN",
                                    width: screenWidth * 0.8,
                                    textColor: UIColor.customNavy,
                                    noOfLines: 1)
        
        return label
    }()
    
    func createTitleVStack(title: String, mealName: String) -> UIStackView {
        let gridWidth = screenWidth * 0.9
        
        let label1 = UILabel()
        label1.text = title
        label1.font = UIFont(name: "KGHAPPYSolid", size: 30)
        label1.textColor = UIColor.customOrange
        label1.width(gridWidth)
        label1.adjustsFontSizeToFitWidth = true
        
        let label2 = UILabel()
        label2.text = mealName
        label2.font = UIFont(name: "KGHAPPYSolid", size: 20)
        label2.textColor = UIColor.customNavy
        label2.width(gridWidth)
        label2.adjustsFontSizeToFitWidth = true
        
        let labelVStack = createVStack(subviews: [label1, label2],
                                       spacing: screenHeight * 0.001)
        
        return labelVStack
    }
    
    lazy var breakfastTitle: UIStackView = {
        let title = createTitleVStack(title: "Breakfast", mealName: breakfast)
        
        return title
    }()
    
    lazy var breakfastImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "defaultMealImage"))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var breakfastMacro: UIStackView = {
        let macroView = createMacroVStack(macros: breakfastMacros)
        
        return macroView
    }()
    
    lazy var refreshBreakfast: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapRefreshBreakfast), for: .touchUpInside)
        button.tintColor = UIColor.customOrange
        button.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.07, height: screenHeight * 0.03)
        
        return button
    }()
    
    @objc func didTapRefreshBreakfast() {
        print("refresh")
    }
    
    func createMacroHStack(macro: String, value: String) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = UIColor.customBlue
        macroLabel.font = UIFont(name: "KGHAPPYSolid", size: 15)
        macroLabel.adjustsFontSizeToFitWidth = true

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = UIColor.customBlue
        valueLabel.font = UIFont(name: "KGHAPPYSolid", size: 15)
        valueLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, valueLabel])
        macroHStack.axis = .horizontal
        
        return macroHStack
    }
    
    func createMacroVStack(macros: MacroBreakdown) -> UIStackView {
        let cal = createMacroHStack(macro: "Calories", value: macros.calories)
        let carbs = createMacroHStack(macro: "Carbs", value: macros.carbs)
        let protein = createMacroHStack(macro: "Protein", value: macros.protein)
        let fat = createMacroHStack(macro: "Fat", value: macros.fat)
        
        let macroVStack = createVStack(subviews: [cal, carbs, protein, fat])
        macroVStack.width(screenWidth * 0.3)
        macroVStack.spacing = screenHeight * 0.006
        
        return macroVStack
    }
}
