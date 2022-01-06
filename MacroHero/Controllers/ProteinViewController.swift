//
//  ProteinViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import UIKit
import Foundation
import Gifu

class ProteinViewController: UIViewController {
    
    // MARK: - VARIABLES
    var proteinData = MealData(image: "defaultMealImage",
                               type: "Protein Shake",
                               macros: MacroBreakdown(calories: "", carbs: "",
                                                      protein: "", fat: ""))

    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupDelegates()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        let label = createMainTitle(text: """
            What's the scoop on
            your protein shake?
            """,
            width: screenWidth * 0.9,
            noOfLines: 2
        )
        
        return label
    }()
    
    lazy var proteinShakeGif: GIFImageView = {
        let gifImageView = GIFImageView()
        gifImageView.animate(withGIFNamed: "proteinShakeGif")
        gifImageView.contentMode = .scaleAspectFit
        
        return gifImageView
    }()
    
    lazy var macroVStack: UIStackView = {
        let VStack = createMacroVStack()
        
        return VStack
    }()
    
    lazy var calTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros.calories)
        
        return textField
    }()
    
    lazy var carbsTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros.carbs, inGrams: true)
        
        return textField
    }()
    
    lazy var proteinTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros.protein, inGrams: true)
        
        return textField
    }()

    lazy var fatTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros.fat, inGrams: true)
        
        return textField
    }()
    
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNextButton() {
        if nextButton.isEnabled {
            let mealPlanVC = MealPlanViewController()
            navigationController?.pushViewController(mealPlanVC, animated: true)
        }
    }

    // MARK: - FUNCTIONS
    func createMacroVStack() -> UIStackView {
        let cal = createMacroHStack(macro: "Calories", textField: calTextField)
        let carbs = createMacroHStack(macro: "Carbs", textField: carbsTextField)
        let protein = createMacroHStack(macro: "Protein", textField: proteinTextField)
        let fat = createMacroHStack(macro: "Fat", textField: fatTextField)
        
        let macroVStack = createVStack(subviews: [cal, carbs, protein, fat],
                                       spacing: screenHeight * 0.02)
        
        return macroVStack
    }
    
    func createMacroHStack(macro: String, textField: UITextField) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = UIColor.customBlue
        macroLabel.font = UIFont(name: "KGHAPPYSolid", size: 15)
        macroLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, textField])
        macroHStack.axis = .horizontal
        macroHStack.width(screenWidth * 0.65)
        
        return macroHStack
    }
    
    func createValueField(value: String, inGrams: Bool? = nil) -> UITextField {
        let textField = UITextField()
        textField.textColor = UIColor.customOrange
        
        textField.background = UIImage(named: "proteinTextArea")
        textField.textAlignment = .center
        textField.font = UIFont(name: "KGHAPPYSolid", size: 15)
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numberPad
        
        textField.width(screenWidth * 0.16)
        textField.height(screenHeight * 0.03)
        
        if inGrams != nil {
            if value.isEmpty {
                textField.text = "    g"
            } else {
                textField.text = "\(value)g"
            }
        }
        
        return textField
    }
}

