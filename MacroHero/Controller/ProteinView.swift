//
//  ProteinViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import UIKit
import Foundation
import Gifu

class ProteinView: UIViewController {
    
    // MARK: - VARIABLES
    var proteinData = MealInfo(image: "defaultMealImage",
                               type: "Protein Shake", name: "",
                               macros: MacroBreakdown(calories: "", carbs: "",
                                                      protein: "", fat: ""),
                               ingredients: [],
                               instructions: [])

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
            let tabBarController = UITabBarController()
            
            let vc1 = UINavigationController(rootViewController: MealPlanView())
            let vc2 = UINavigationController(rootViewController: AddView())
            let vc3 = UINavigationController(rootViewController: ProfileView())
            
            vc1.title = "Plan"
            vc2.title = "Add"
            vc3.title = "Profile"
            
            tabBarController.setViewControllers([vc1, vc2, vc3], animated: false)
            
            guard let items = tabBarController.tabBar.items else { return }
            let images = ["note.text", "plus.circle", "person.circle"]
            
            for item in 0..<items.count {
                items[item].image = UIImage(systemName: images[item])
            }
            
            tabBarController.tabBar.tintColor = UIColor.customNavy
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: false)
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

extension ProteinView {

    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
        gestureToHideKeyboard()
    }
    
    func setupDelegates() {
        calTextField.delegate = self
        carbsTextField.delegate = self
        proteinTextField.delegate = self
        fatTextField.delegate = self
    }

    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(proteinShakeGif)
        view.addSubview(macroVStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.topToSuperview(offset: screenHeight * 0.21)
        mainTitle.centerXToSuperview()
        
        proteinShakeGif.topToBottom(of: mainTitle)
        proteinShakeGif.centerXToSuperview()
        proteinShakeGif.width(screenWidth * 0.67)
        proteinShakeGif.height(screenHeight * 0.18)
        
        macroVStack.centerXToSuperview()
        macroVStack.topToBottom(of: proteinShakeGif, offset: screenHeight * 0.05)
        macroVStack.width(screenWidth * 0.65)
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}

// MARK: - Text Field Delegate Methods
extension ProteinView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == calTextField {
            keyboardDistanceFromTextField = macroVStack.frame.height
            print(keyboardDistanceFromTextField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = calTextField.text {
            proteinData.macros.calories = text
        } else if let text = carbsTextField.text {
            proteinData.macros.carbs = text
        } else if let text = proteinTextField.text {
            proteinData.macros.protein = text
        } else if let text = fatTextField.text {
            proteinData.macros.fat = text
        }
        
        view.endEditing(true)
    }
    
    // Ends all editing
    func gestureToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Text View Delegate Methods
extension ProteinView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if proteinData.macros.calories.isEmpty || proteinData.macros.carbs.isEmpty || proteinData.macros.protein.isEmpty || proteinData.macros.fat.isEmpty {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
}
