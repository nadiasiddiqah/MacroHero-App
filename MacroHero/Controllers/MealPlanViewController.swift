//
//  MealPlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/30/21.
//

import UIKit

class MealPlanViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: screenWidth,
                                      height: screenHeight + screenHeight * 0.11)
    
    
    var breakfastData = MealData(image: "defaultMealImage",
                                 type: "Breakfast",
                                 name: "Poached Egg & Avocado Toast",
                                 macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                        protein: "23g", fat: "20g"))
    
    var lunchData = MealData(image: "defaultMealImage",
                             type: "Lunch",
                             name: "Poached Egg & Avocado Toast",
                             macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                    protein: "23g", fat: "20g"))
    
    var dinnerData = MealData(image: "defaultMealImage",
                              type: "Dinner",
                              name: "Poached Egg & Avocado Toast",
                              macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                     protein: "23g", fat: "20g"))
    
    var proteinShakeData = MealData(image: "defaultMealImage",
                                    type: "Protein Shake",
                                    macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                           protein: "23g", fat: "20g"))

    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        
        return view
    }()
    
    lazy var mainTitle: UILabel = {
        let label = createMainTitle(text: "TODAY'S MEAL PLAN",
                                    width: screenWidth * 0.8,
                                    textColor: UIColor.customNavy,
                                    noOfLines: 1)
        
        return label
    }()
    
    lazy var breakfastTitle: UIStackView = {
        let title = createTitleVStack(mealType: breakfastData.type,
                                      mealName: breakfastData.name ?? "")
        
        return title
    }()
    
    lazy var breakfastImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: breakfastData.image))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var breakfastMacro: UIStackView = {
        let macroView = createMacroVStack(macros: breakfastData.macros)
        
        return macroView
    }()
    
    lazy var refreshBreakfast: UIButton = {
        let button = createRefreshButton(action: #selector(didTapRefreshBreakfast))
        
        return button
    }()
    
    lazy var lunchTitle: UIStackView = {
        let title = createTitleVStack(mealType: lunchData.type,
                                      mealName: lunchData.name ?? "")
        
        return title
    }()
    
    lazy var lunchImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: lunchData.image))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var lunchMacro: UIStackView = {
        let macroView = createMacroVStack(macros: lunchData.macros)
        
        return macroView
    }()
    
    lazy var refreshLunch: UIButton = {
        let button = createRefreshButton(action: #selector(didTapRefreshLunch))
        
        return button
    }()
    
    lazy var dinnerTitle: UIStackView = {
        let title = createTitleVStack(mealType: dinnerData.type,
                                      mealName: dinnerData.name ?? "")
        
        return title
    }()
    
    lazy var dinnerImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: dinnerData.image))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var dinnerMacro: UIStackView = {
        let macroView = createMacroVStack(macros: dinnerData.macros)
        
        return macroView
    }()
    
    lazy var refreshDinner: UIButton = {
        let button = createRefreshButton(action: #selector(didTapRefreshDinner))
        
        return button
    }()
    
    lazy var proteinShakeTitle: UILabel = {
        let label = UILabel()
        label.text = proteinShakeData.type
        label.font = UIFont(name: "KGHAPPYSolid", size: 30)
        label.textColor = UIColor.customOrange
        label.width(screenWidth * 0.9)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var proteinShakeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: lunchData.image))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var proteinShakeMacro: UIStackView = {
        let macroView = createMacroVStack(macros: proteinShakeData.macros)
        
        return macroView
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapRefreshBreakfast() {
        print("refresh")
    }
    
    @objc func didTapRefreshLunch() {
        print("refresh")
    }
    
    @objc func didTapRefreshDinner() {
        print("refresh")
    }
    
    // MARK: - FUNCTIONS
    func createRefreshButton(action: Selector) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.tintColor = UIColor.customOrange
        
        return button
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
    
    func createTitleVStack(mealType: String, mealName: String) -> UIStackView {
        let gridWidth = screenWidth * 0.9
        
        let label1 = UILabel()
        label1.text = mealType
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
    
    func addConstraintsForMeal(title: UIView, topToBottomOf: UIView,
                               image: UIView, macro: UIView,
                               refreshButton: UIView? = nil) {
        title.leftToSuperview(offset: screenWidth * 0.05)
        title.topToBottom(of: topToBottomOf, offset: screenHeight * 0.03)
        
        image.leftToSuperview(offset: screenWidth * 0.05)
        image.topToBottom(of: title, offset: screenHeight * 0.01)
        image.width(screenWidth * 0.45)
        image.aspectRatio(1.63)
        
        macro.topToBottom(of: title, offset: screenHeight * 0.01)
        macro.leftToRight(of: image, offset: screenWidth * 0.02)
        
        if let refreshButton = refreshButton {
            refreshButton.topToBottom(of: title, offset: screenHeight * 0.05)
            refreshButton.leftToRight(of: macro, offset: screenWidth * 0.07)
            refreshButton.width(screenWidth * 0.07)
            refreshButton.aspectRatio(1)
        }
    }
}
