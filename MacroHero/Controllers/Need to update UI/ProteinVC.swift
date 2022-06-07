//
//  ProteinViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import UIKit
import Foundation
import Gifu
import Combine
import Inject

class ProteinVC: UIViewController {
    
    // MARK: - PROPERTIES
    private var viewModel: ProteinVM
    private var cancellables = Set<AnyCancellable>()
    
    var proteinData: MealInfo
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    // MARK: - Initializers
    init(viewModel: ProteinVM) {
        self.viewModel = viewModel
        self.proteinData = MealInfo(mealOrder: 3,
                                    image: "defaultMealImage",
                                    type: "Protein", name: "Protein Shake",
                                    macros: MacroPlan(calories: "", carbs: "", protein: "", fat: ""))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        let label = Utils.createMainTitle(
            text: "What's the scoop on your protein shake?",
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
        let textField = createValueField(value: proteinData.macros?.calories ?? "")
        
        return textField
    }()
    
    lazy var carbsTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros?.carbs ?? "")
        
        return textField
    }()
    
    lazy var proteinTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros?.protein ?? "")
        
        return textField
    }()
    
    lazy var fatTextField: UITextField = {
        let textField = createValueField(value: proteinData.macros?.fat ?? "")
        
        return textField
    }()
    
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(Image.nextButton, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNextButton() {
        segueToMealPlanTab()
        
//        guard let macros = proteinData.macros, !macros.calories.isEmpty,
//              !macros.carbs.isEmpty, !macros.protein.isEmpty, !macros.fat.isEmpty else { return }
//
//        guard Int(macros.calories) != nil, Int(macros.carbs) != nil,
//              Int(macros.protein) != nil, Int(macros.fat) != nil else { return }
//
//        segueToMealPlanTab()
    }

    // MARK: - FUNCTIONS
    func segueToMealPlanTab() {
        let tabBarController = UITabBarController()
        
        let vc1 = UINavigationController(rootViewController:
                                            MealPlanVC(viewModel: .init(mealPlan: [proteinData])))
        let vc2 = UINavigationController(rootViewController: Inject.ViewControllerHost(FavoritesView()))
        let vc3 = UINavigationController(rootViewController: ProfileView())
        
        tabBarController.setViewControllers([vc1, vc2, vc3], animated: false)
        
        guard let items = tabBarController.tabBar.items else { return }
        let images = ["note.text", "plus.circle", "person.circle"]
        
        for item in 0..<items.count {
            items[item].image = UIImage(systemName: images[item])
        }
        
        tabBarController.tabBar.tintColor = Color.customNavy
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: false)
    }
    
    func createMacroVStack() -> UIStackView {
        let cal = createMacroHStack(macro: "Calories", textField: calTextField)
        let carbs = createMacroHStack(macro: "Carbs (g)", textField: carbsTextField)
        let protein = createMacroHStack(macro: "Protein (g)", textField: proteinTextField)
        let fat = createMacroHStack(macro: "Fat (g)", textField: fatTextField)
        
        let macroVStack = Utils.createVStack(subviews: [cal, carbs, protein, fat],
                                             spacing: screenHeight * 0.02)
        
        return macroVStack
    }
    
    func createMacroHStack(macro: String, textField: UITextField) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = Color.customBlue
        macroLabel.font = Font.solid_15
        macroLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, textField])
        macroHStack.axis = .horizontal
        
        return macroHStack
    }
    
    func createValueField(value: String) -> UITextField {
        let textField = UITextField()
        textField.textColor = Color.customOrange
        
        textField.background = Image.proteinTextArea
        textField.textAlignment = .center
        textField.font = Font.solid_15
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numberPad
        
        textField.width(screenWidth * 0.16)
        textField.height(screenHeight * 0.03)
        
        return textField
    }
}

extension ProteinVC {

    func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        constrainSubviews()
//        Utils.setNavigationBar(navController: navigationController, navItem: navigationItem,
//                               leftBarButtonItem: UIBarButtonItem(image: Image.backButton,
//                                                            style: .done, target: self,
//                                                            action: #selector(didTapBackButton)))
        gestureToHideKeyboard()
    }
    
    func setupDelegates() {
        calTextField.delegate = self
        carbsTextField.delegate = self
        proteinTextField.delegate = self
        fatTextField.delegate = self
    }

    @objc func didTapBackButton(sender: UIBarButtonItem) {
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
extension ProteinVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            if carbsTextField == textField || proteinTextField == textField || fatTextField == textField {
                textField.text?.removeLast()
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            if calTextField == textField {
                proteinData.macros?.calories = text
            } else if carbsTextField == textField {
                carbsTextField.text = "\(text)g"
                proteinData.macros?.carbs = text
            } else if proteinTextField == textField {
                proteinTextField.text = "\(text)g"
                proteinData.macros?.protein = text
            } else if fatTextField == textField {
                fatTextField.text = "\(text)g"
                proteinData.macros?.fat = text
            }
        }
        
        print(proteinData)
    }
    
    func areTextFieldsValid() {
        if let calories = calTextField.text, let carbs = carbsTextField.text,
           let protein = proteinTextField.text, let fat = fatTextField.text {
            guard !calories.isEmpty || !protein.isEmpty || !carbs.isEmpty || !fat.isEmpty else {
                nextButton.isEnabled = false
                return
            }
        }
    }
    
    func gestureToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

