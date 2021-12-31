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
    var calValue = ""
    var carbsValue = ""
    var proteinValue = ""
    var fatValue = ""

    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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
        let VStack = createMacroVStack(calValue: calValue, carbsValue: carbsValue,
                                       proteinValue: proteinValue, fatValue: fatValue)
        
        return VStack
    }()
    
    lazy var calLabel: UITextField = {
        let textField = createValueField(value: calValue)
    
        return textField
    }()
    
    lazy var calTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "proteinTextArea",
                                         width: screenWidth * 0.6,
                                         height: screenHeight * 0.03)
        
        return image
    }()
    
    lazy var carbsLabel: UITextField = {
        let textField = createValueField(value: carbsValue, inGrams: true)
    
        return textField
    }()
    
    lazy var carbsTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "proteinTextArea",
                                         width: screenWidth * 0.6,
                                         height: screenHeight * 0.03)
        
        return image
    }()
    
    lazy var proteinLabel: UITextField = {
        let textField = createValueField(value: proteinValue, inGrams: true)
    
        return textField
    }()
    
    lazy var proteinTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "proteinTextArea",
                                         width: screenWidth * 0.6,
                                         height: screenHeight * 0.03)
        
        return image
    }()
    
    lazy var fatLabel: UITextField = {
        let textField = createValueField(value: fatValue, inGrams: true)
    
        return textField
    }()
    
    lazy var fatTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "proteinTextArea",
                                         width: screenWidth * 0.6,
                                         height: screenHeight * 0.03)
        
        return image
    }()
    
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNextButton() {
        let mealPlanVC = MealPlanViewController()
        navigationController?.pushViewController(mealPlanVC, animated: true)
    }
    
    
    // MARK: - FUNCTIONS
    func createMacroVStack(calValue: String, carbsValue: String, proteinValue: String, fatValue: String) -> UIStackView {
        let cal = createMacroHStack(macro: "Calories", textArea: calTextArea)
        let carbs = createMacroHStack(macro: "Carbs", textArea: carbsTextArea)
        let protein = createMacroHStack(macro: "Protein", textArea: proteinTextArea)
        let fat = createMacroHStack(macro: "Fat", textArea: fatTextArea)
        
        let macroVStack = createVStack(subviews: [cal, carbs, protein, fat],
                                       spacing: screenHeight * 0.02)
        
        return macroVStack
    }
    
    func createMacroHStack(macro: String, textArea: UIImageView) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = UIColor.customBlue
        macroLabel.font = UIFont(name: "KGHAPPYSolid", size: 15)
        macroLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, textArea])
        macroHStack.axis = .horizontal
        macroHStack.width(screenWidth * 0.65)
        
        return macroHStack
    }
    
    func createValueField(value: String, inGrams: Bool? = nil) -> UITextField {
        let textField = UITextField()
        textField.textColor = UIColor.customOrange
        textField.font = UIFont(name: "KGHAPPYSolid", size: 15)
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numberPad
        
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


//func createMacroVStack(calG: String, carbsG: String, proteinG: String, fatG: String) -> UIStackView {
//    let cal = createMacroHStack(macro: "Calories", value: calG)
//    let carbs = createMacroHStack(macro: "Carbs", value: carbsG)
//    let protein = createMacroHStack(macro: "Protein", value: proteinG)
//    let fat = createMacroHStack(macro: "Fat", value: fatG)
//
//    let macroVStack = createVStack(subviews: [cal, carbs, protein, fat],
//                                   spacing: screenHeight * 0.02)
//
//    return macroVStack
//}
//
//func createMacroHStack(macro: String, value: String) -> UIStackView {
//    let macroLabel = UILabel()
//    macroLabel.text = macro
////        let valueLabel = UILabel()
////        valueLabel.text = value
//
////        let calTextArea = createAspectFitImage(imageName: "proteinTextArea",
////                                               width: screenWidth * 0.6,
////                                               height: screenHeight * 0.03)
//
//    let macroHStack = UIStackView(arrangedSubviews: [macroLabel, calTextArea])
//    macroHStack.axis = .horizontal
//
//    return macroHStack
//}
