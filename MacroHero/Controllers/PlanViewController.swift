//
//  PlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 11/23/21.
//

import Foundation
import TinyConstraints
import Gifu

class PlanViewController: UIViewController {
    var calAmt = "1890"
    
    var carbsInGrams = "215g"
    var carbsPercentage = "45%"
    
    var proteinInGrams = "145g"
    var proteinPercentage = "30%"
    
    var fatInGrams = "55g"
    var fatPercentage = "25%"
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setNavigationBar()
    }
    
    // MARK: - TITLE
    lazy var mainTitle: UIImageView = {
        let image = createAspectFitImage(imageName: "planTitle",
                                         width: screenWidth * 0.85,
                                         height: screenHeight * 0.05)
        
        return image
    }()
    
    // MARK: - PIE CHART IMAGE
    lazy var pieChart: UIImageView = {
        let image = createAspectFitImage(imageName: "piechart",
                                         width: screenWidth * 0.71,
                                         height: screenHeight * 0.25)
        
        return image
    }()
    
    // MARK: - MACRO BREAKDOWN
    lazy var macroVStack: UIStackView = {
        let VStack = UIStackView(arrangedSubviews: [calHStack, carbHStack, proteinHStack, fatHStack])
        VStack.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.75, height: screenHeight * 0.18)
        VStack.axis = .vertical
        VStack.spacing = screenHeight * 0.01
        
        return VStack
    }()
    
    lazy var calHStack: UIStackView = {
        var HStack = createMacroHStack(macro: "Calories  ", value: calAmt)
        
        return HStack
    }()

    lazy var carbHStack: UIStackView = {
        var HStack = createMacroHStack(macro: "Carbs  ", grams: carbsInGrams, value: carbsPercentage)

        return HStack
    }()

    lazy var proteinHStack: UIStackView = {
        var HStack = createMacroHStack(macro: "Protein  ", grams: proteinInGrams, value: proteinPercentage)

        return HStack
    }()

    lazy var fatHStack: UIStackView = {
        var HStack = createMacroHStack(macro: "Fat  ", grams: fatInGrams, value: fatPercentage)

        return HStack
    }()
    
    // MARK: - FUNCTIONS
    
    func createMacroHStack(macro: String, grams: String? = nil, value: String) -> UIStackView {
        let macroLabel = UILabel()
        let attributedLabel = NSMutableAttributedString()
        attributedLabel.append(NSAttributedString(string: macro,
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlue ?? ""]))
        if let grams = grams {
            attributedLabel.append(NSAttributedString(string: grams,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray ?? ""]))
        }
        
        macroLabel.attributedText = attributedLabel
        macroLabel.textAlignment = .left
        macroLabel.font = UIFont(name: "KGHAPPYSolid", size: 20)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = UIColor(named: "orange")
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "KGHAPPYSolid", size: 20)
        
        let HStack = UIStackView(arrangedSubviews: [macroLabel, valueLabel])
        HStack.axis = .horizontal
        
        return HStack
    }
}
