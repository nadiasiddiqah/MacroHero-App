//
//  PlanViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 11/23/21.
//

import Foundation
import TinyConstraints
import Gifu
import DropDown
import Combine

class PlanVC: UIViewController {
    
    // MARK: - PROPERTIES
    private var viewModel: PlanVM
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - INITIALIZERS
    init(viewModel: PlanVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
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
        let calories = viewModel.dailyMacro.calories
        var HStack = createMacroHStack(macro: "Calories  ",
                                       value: calories)
        
        return HStack
    }()

    lazy var carbHStack: UIStackView = {
        let carbs = viewModel.dailyMacro.carbs
        var HStack = createMacroHStack(macro: "Carbs  ", grams: "\(carbs)g",
                                       value: calculatePercentage(of: carbs))

        return HStack
    }()

    lazy var proteinHStack: UIStackView = {
        let protein = viewModel.dailyMacro.protein
        var HStack = createMacroHStack(macro: "Protein  ", grams: "\(protein)g",
                                       value: calculatePercentage(of: protein))

        return HStack
    }()

    lazy var fatHStack: UIStackView = {
        let fat = viewModel.dailyMacro.fat
        var HStack = createMacroHStack(macro: "Fat  ", grams: "\(fat)g",
                                       value: calculatePercentage(of: fat))

        return HStack
    }()
    
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNextButton() {
        let rankVC = RankView()
        navigationController?.pushViewController(rankVC, animated: true)
    }
    
    // MARK: - FUNCTIONS
    func calculatePercentage(of: String) -> String {
        guard let value = Double(of),
              let carbs = Double(viewModel.dailyMacro.carbs),
              let protein = Double(viewModel.dailyMacro.protein),
              let fat = Double(viewModel.dailyMacro.fat) else {
            return "0%"
        }
        
        let total = carbs + protein + fat
        let percentage = round((value/total) * 100)
        return "\(Int(percentage))%"
    }
    
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
        valueLabel.textColor = UIColor.customOrange
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "KGHAPPYSolid", size: 20)
        
        let HStack = UIStackView(arrangedSubviews: [macroLabel, valueLabel])
        HStack.axis = .horizontal
        
        return HStack
    }
}

extension PlanVC {
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
    }

    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(pieChart)
        view.addSubview(macroVStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.19)
        mainTitle.width(screenWidth * 0.85)
        mainTitle.height(screenHeight * 0.05)
        
        pieChart.centerXToSuperview()
        pieChart.topToBottom(of: mainTitle, offset: screenHeight * 0.05)
        pieChart.width(screenWidth * 0.71)
        pieChart.height(screenHeight * 0.25)
        
        macroVStack.centerXToSuperview()
        macroVStack.topToBottom(of: pieChart, offset: screenHeight * 0.05)
        macroVStack.width(screenWidth * 0.75)
        macroVStack.height(screenHeight * 0.18)
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}

