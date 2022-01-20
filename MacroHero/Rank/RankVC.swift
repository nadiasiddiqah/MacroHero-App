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
import Combine

class RankVC: UIViewController {
    
    // MARK: - PROPERTIES
    private var viewModel: RankVM
    private var cancellables = Set<AnyCancellable>()
    
    var dailyMacros = [String]()
    var calories = String()
    var carbs = String()
    var protein = String()
    var fat = String()
    
    var collapsedFirstGoal: Constraint?
    var expandedFirstGoal: Constraint?
    
    // MARK: - Initializers
    init(viewModel: RankVM) {
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
        initializeMacros()
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
        button.setBackgroundImage(UIImage(named: "rankTextAreaSelected"), for: .selected)
        button.addTarget(self, action: #selector(didTapFirstGoal), for: .touchUpInside)
        
        return button
    }()
    
    lazy var firstGoalLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = UIColor.customDarkGray

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
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    lazy var secondGoalButton: UIButton = {
        let button = UIButton()
        
        button.width(screenWidth * 0.57)
        button.setBackgroundImage(UIImage(named: "rankTextArea"), for: .normal)
        button.setBackgroundImage(UIImage(named: "rankTextAreaSelected"), for: .selected)
        button.addTarget(self, action: #selector(didTapSecondGoal), for: .touchUpInside)
        
        return button
    }()
    
    lazy var secondGoalLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = UIColor.customDarkGray

        return label
    }()
    
    lazy var secondGoalHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [secondGoal, secondGoalButton])
        HStack.axis = .horizontal
        HStack.spacing = screenWidth * 0.03
        
        return HStack
    }()
    
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
  
    // MARK: - TAP METHODS
    @objc func didTapFirstGoal() {
        let firstGoalDropDown = DropDown()
        
        updateDropDownView(action: "expand")
        
        createDropDown(dropDown: firstGoalDropDown, dataSource: dailyMacros,
                       anchorView: firstGoalButton, screen: "rank")
        firstGoalDropDown.bottomOffset = CGPoint(x: 0, y: firstGoalButton.frame.size.height + screenHeight * 0.01)
        
        firstGoalDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.firstGoalLabel.text = item
            print(item)
            self?.updateDropDownView(action: "collapse")
        }
        
        firstGoalDropDown.cancelAction = { [weak self] in
            self?.expandedFirstGoal?.isActive = false
            self?.updateDropDownView(action: "collapse")
        }
    }
    
    @objc func didTapSecondGoal() {
        let secondGoalDropDown = DropDown()
        
        secondGoalButton.isSelected = true
        createDropDown(dropDown: secondGoalDropDown, dataSource: dailyMacros,
                       anchorView: secondGoalButton, screen: "rank")
        secondGoalDropDown.bottomOffset = CGPoint(x: 0, y: secondGoalButton.frame.size.height + screenHeight * 0.01)
        
        secondGoalDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.secondGoalLabel.text = item
            self?.secondGoalButton.isSelected = false
        }
        
        secondGoalDropDown.cancelAction = { [weak self] in
            self?.secondGoalButton.isSelected = false
        }
    }
    
    @objc func didTapNextButton() {
        let proteinVC = ProteinVC()
        navigationController?.pushViewController(proteinVC, animated: true)
    }
    
    // MARK: - FUNCTIONS
    func initializeMacros() {
        calories = viewModel.dailyMacro.calories
        carbs = viewModel.dailyMacro.carbs
        protein = viewModel.dailyMacro.protein
        fat = viewModel.dailyMacro.fat
        
        dailyMacros = [
            "Calories (\(calories))", "Carbs (\(carbs)g)", "Protein (\(protein)g)", "Fat (\(fat)g)"
        ]
    }
    
    func updateDropDownView(action: String) {
        if action == "expand" {
            firstGoalButton.isSelected = true
            collapsedFirstGoal?.isActive = false
            UIView.animate(withDuration: 0.3) {
                self.expandedFirstGoal?.isActive = true
                self.secondGoalHStack.layoutIfNeeded()
            }
        } else if action == "collapse" {
            firstGoalButton.isSelected = false
            expandedFirstGoal?.isActive = false
            UIView.animate(withDuration: 0.3) {
                self.collapsedFirstGoal?.isActive = true
                self.secondGoalHStack.layoutIfNeeded()
            }
        }
    }
}

extension RankVC {
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        collapsedFirstGoal?.isActive = true
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
        firstGoalButton.addSubview(firstGoalLabel)
        view.addSubview(firstGoalHStack)
        secondGoalButton.addSubview(secondGoalLabel)
        view.addSubview(secondGoalHStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.16)
        
        firstGoalLabel.leftToSuperview(offset: screenWidth * 0.04)
        firstGoalLabel.centerYToSuperview()
        
        firstGoalHStack.leftToSuperview(offset: screenWidth * 0.09)
        firstGoalHStack.topToBottom(of: mainTitle, offset: screenWidth * 0.05)
        firstGoalHStack.width(screenWidth * 0.7)
        
        secondGoalLabel.leftToSuperview(offset: screenWidth * 0.04)
        secondGoalLabel.centerYToSuperview()
        
        secondGoalHStack.leftToSuperview(offset: screenWidth * 0.09)
        
        collapsedFirstGoal = secondGoalHStack.topToBottom(of: firstGoalHStack,
                                                          offset: screenHeight * 0.04,
                                                          isActive: false)
        expandedFirstGoal = secondGoalHStack.topToBottom(of: firstGoalHStack,
                                                         offset: screenHeight * 0.26,
                                                         isActive: false)
        secondGoalHStack.width(screenWidth * 0.7)
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}
