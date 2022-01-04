//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit

class MealPlanViewController: UIViewController {
    
    var breakfast = "Poached Egg & Avocado Toast"
    var breakfastMacros = MacroBreakdown(calories: "393", carbs: "60 g", protein: "23 g", fat: "20 g")
    
    var lunch = "Poached Egg & Avocado Toast"
    var lunchMacros = MacroBreakdown(calories: "393", carbs: "60 g", protein: "23 g", fat: "20 g")
    
    var dinner = "Poached Egg & Avocado Toast"
    var dinnerMacros = MacroBreakdown(calories: "393", carbs: "60 g", protein: "23 g", fat: "20 g")
    
    var proteinShake = "Protein Shake"
    var proteinShakeMacros = MacroBreakdown(calories: "393", carbs: "60 g", protein: "23 g", fat: "20 g")

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
    
    lazy var refreshButton1: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        button.tintColor = UIColor.customOrange
        button.width(screenWidth * 0.07)
        
        return button
    }()
    
    lazy var mealGrid: UIStackView = {
        let breakfast = mealGrid(type: "Breakfast", title: breakfast,
                                 imageName: "defaultMealImage",
                                 macros: breakfastMacros,
                                 refreshButton: refreshButton1)
        
        return breakfast
    }()
    
    @objc func didTapRefresh() {
        print("refresh")
    }
    
    func mealGrid(type: String, title: String, imageName: String,
                  macros: MacroBreakdown, refreshButton: UIButton) -> UIStackView {
        let width = screenWidth * 0.9
        
        let label1 = UILabel()
        label1.text = type
        label1.font = UIFont(name: "KGHAPPYSolid", size: 30)
        label1.textColor = UIColor.customOrange
        label1.width(width)
        label1.adjustsFontSizeToFitWidth = true
        
        let label2 = UILabel()
        label2.text = title
        label2.font = UIFont(name: "KGHAPPYSolid", size: 20)
        label2.textColor = UIColor.customNavy
        label2.width(width)
        label2.adjustsFontSizeToFitWidth = true
        
        let imageView = createAspectFitImage(imageName: imageName,
                                             width: screenWidth * 0.4,
                                             height: screenHeight * 0.11)
        let macroView = createMacroVStack(macros: macros)
        
        let imageMacroHStack = UIStackView(arrangedSubviews: [imageView, macroView])
        imageMacroHStack.axis = .horizontal
        imageMacroHStack.spacing = screenWidth * 0.02
        
        let fullHStack = UIStackView(arrangedSubviews: [imageMacroHStack, refreshButton])
        fullHStack.axis = .horizontal
        fullHStack.spacing = screenWidth * 0.07
        
        let labelVStack = UIStackView(arrangedSubviews: [label1, label2])
        labelVStack.axis = .vertical
        labelVStack.spacing = screenHeight * 0.01
        
        let fullVStack = UIStackView(arrangedSubviews: [labelVStack, fullHStack])
        fullVStack.axis = .vertical
        fullVStack.spacing = screenHeight * 0.005
        
        return fullVStack
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
        macroHStack.width(screenWidth * 0.27)
        
        return macroHStack
    }
    
    func createMacroVStack(macros: MacroBreakdown) -> UIStackView {
        let cal = createMacroHStack(macro: "Calories", value: macros.calories)
        let carbs = createMacroHStack(macro: "Carbs", value: macros.carbs)
        let protein = createMacroHStack(macro: "Protein", value: macros.protein)
        let fat = createMacroHStack(macro: "Fat", value: macros.fat)
        
        let macroVStack = createVStack(subviews: [cal, carbs, protein, fat],
                                       spacing: screenHeight * 0.02)
        macroVStack.width(screenWidth * 0.3)
        macroVStack.height()
        
        return macroVStack
    }
}
