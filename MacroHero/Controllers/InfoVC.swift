//
//  InfoViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/6/21.
//

import UIKit
import DropDown
import Combine

class InfoVC: UIViewController {
    
    // MARK: - PROPERTIES
    private var viewModel: InfoVM
    private var cancellables = Set<AnyCancellable>()
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    // MARK: - INITIALIZERS
    init(viewModel: InfoVM) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - TITLE
    lazy var mainTitle: UIImageView = {
        let image = Utils.createAspectFitImage(image: Image.letsplan,
                                               width: screenWidth * 0.5,
                                               height: screenHeight * 0.06)
        
        return image
    }()
    
    // MARK: - AGE BUTTON
    lazy var ageButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.39,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(Image.ageButton, for: .normal)
        button.addTarget(self, action: #selector(didTapAgeButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var ageLabel: UILabel = {
        var label = UILabel()
        label.text = "    yrs"
        label.textColor = Color.customOrange
        label.textAlignment = .center
        label.font = Fonts.solid_15
        
        return label
    }()
    
    lazy var ageTextArea: UIImageView = {
        var image = UIImageView(image: Image.ageTextArea)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var ageVStack: UIStackView = {
        let VStack = Utils.createVStack(subviews: [ageLabel, ageTextArea],
                                        width: ageButton.frame.width * 0.66,
                                        height: ageButton.frame.height * 0.33,
                                        spacing: ageButton.frame.height * -0.07)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapAgeButton))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    // MARK: - HEIGHT BUTTON
    lazy var heightButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(Image.heightButton, for: .normal)
        button.addTarget(self, action: #selector(didTapFtField), for: .touchUpInside)
        
        return button
    }()
    
    lazy var ftLabel: UILabel = {
        var label = UILabel()
        label.text = "  '"
        label.textColor = Color.customOrange
        label.textAlignment = .center
        label.font = Fonts.solid_15
        
        return label
    }()
    
    lazy var ftTextArea: UIImageView = {
        let image = Utils.createAspectFitImage(image: Image.heightTextArea)
        
        return image
    }()
    
    lazy var inTextArea: UIImageView = {
        let image = Utils.createAspectFitImage(image: Image.heightTextArea)
        
        return image
    }()
    
    lazy var ftVStack: UIStackView = {
        let VStack = Utils.createVStack(subviews: [ftLabel, ftTextArea],
                                        width: heightButton.frame.width * 0.39,
                                        height: heightButton.frame.height * 0.3,
                                        spacing: heightButton.frame.height * -0.08)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapFtField))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    lazy var inLabel: UILabel = {
        var label = UILabel()
        label.text = #"   ""#
        label.textColor = Color.customOrange
        label.textAlignment = .center
        label.font = Fonts.solid_15
        
        return label
    }()
    
    lazy var inVStack: UIStackView = {
        let VStack = Utils.createVStack(subviews: [inLabel, inTextArea],
                                        width: heightButton.frame.width * 0.39,
                                        height: heightButton.frame.height * 0.3,
                                        spacing: heightButton.frame.height * -0.08)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapInField))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    lazy var heightHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [ftVStack, inVStack])
        
        HStack.axis = .horizontal
        HStack.spacing = heightButton.frame.width * 0.05
        
        return HStack
    }()
    
    lazy var heightWeightHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [heightButton, weightButton])
        
        HStack.axis = .horizontal
        HStack.spacing = heightButton.frame.width * 0.06
        
        return HStack
    }()
    
    // MARK: - WEIGHT BUTTON
    lazy var weightButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(Image.weightButton, for: .normal)
        button.addTarget(self, action: #selector(didTapWeightButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var weightLabel: UILabel = {
        var label = UILabel()
        label.text = "     lbs"
        label.textColor = Color.customOrange
        label.textAlignment = .center
        label.font = Fonts.solid_15
        
        return label
    }()
    
    lazy var weightTextArea: UIImageView = {
        var image = UIImageView(image: Image.ageTextArea)
        image.frame = CGRect(x: 0, y: 0,
                             width: screenWidth * 0.65, height: screenHeight * 0.3)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var weightVStack: UIStackView = {
        let VStack = Utils.createVStack(subviews: [weightLabel, weightTextArea],
                                        width: weightButton.frame.width * 0.65,
                                        height: weightButton.frame.height * 0.3,
                                        spacing: ageButton.frame.height * -0.07)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapWeightButton))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    // MARK: - ACTIVITY LEVEL BUTTON
    lazy var activityButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.51,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(Image.activityButton, for: .normal)
        button.addTarget(self, action: #selector(didTapActivityButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var activityLabel: UILabel = {
        var label = UILabel()
        label.textColor = Color.customOrange
        label.text = " "
        label.textAlignment = .center
        label.font = Fonts.solid_15
        
        return label
    }()
    
    lazy var activityTextArea: UIImageView = {
        var image = UIImageView(image: Image.activityTextArea)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var activityVStack: UIStackView = {
        let VStack = Utils.createVStack(subviews: [activityLabel, activityTextArea],
                                        spacing: activityButton.frame.height * -0.08)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapActivityButton))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.calculateButton, for: .normal)
        button.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var allButtonsVStack: UIStackView = {
        let VStack = UIStackView(arrangedSubviews: [ageButton, heightWeightHStack,
                                                    activityButton, calculateButton])
        
        VStack.axis = .vertical
        VStack.spacing = screenHeight * 0.05
        
        return VStack
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapAgeButton() {
        let ageDropDown = DropDown()
        let ageData = Array(18...80).map { String("\($0) yrs") }
        
        Utils.createDropDown(dropDown: ageDropDown, dataSource: ageData, anchorView: ageButton, screen: "info")
        
        ageDropDown.bottomOffset = CGPoint(x: 0, y: ageButton.frame.size.height)
        ageDropDown.offsetFromWindowBottom = (screenHeight * 0.67) - ageButton.frame.size.height
        
        ageDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.ageLabel.text = item
        }
    }
    
    @objc func didTapFtField() {
        let ftDropDown = DropDown()
        let ftData = Array(4...7).map { String("\($0)'") }
        
        Utils.createDropDown(dropDown: ftDropDown, dataSource: ftData, anchorView: heightButton,
                             halfWidth: true, screen: "info")
        
        ftDropDown.bottomOffset = CGPoint(x: 0, y: heightButton.frame.size.height)
        ftDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - heightButton.frame.size.height
        
        ftDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.ftLabel.text = item
            if item == "4'" || item == "7'" {
                self?.inLabel.text = #"   ""#
            }
        }
    }
    
    @objc func didTapInField() {
        let inDropDown = DropDown()
        var inData = [String]()
        
        if ftLabel.text == "4'" {
            inData = Array(4...11).map { String("\($0)\"") }
        } else if ftLabel.text == "7'" {
            inData = Array(0...6).map { String("\($0)\"") }
        } else {
            inData = Array(0...11).map { String("\($0)\"") }
        }
        
        Utils.createDropDown(dropDown: inDropDown, dataSource: inData, anchorView: heightButton, screen: "info")
        
        inDropDown.bottomOffset = CGPoint(x: heightButton.frame.size.width / 2, y: heightButton.frame.size.height)
        inDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - heightButton.frame.size.height
        inDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.inLabel.text = item
        }
    }
    
    @objc func didTapWeightButton() {
        let weightDropDown = DropDown()
        let weightData = Array(90...300).map { String("\($0) lbs") }
        
        Utils.createDropDown(dropDown: weightDropDown, dataSource: weightData, anchorView: weightButton, screen: "info")
        
        weightDropDown.bottomOffset = CGPoint(x: 0, y: weightButton.frame.size.height)
        weightDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - weightButton.frame.size.height
        
        weightDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.weightLabel.text = item
        }
    }
    
    @objc func didTapActivityButton() {
        let activityDropDown = DropDown()
        let activityData = ["Sedentary", "Lightly active", "Active", "Very active"]
        
        Utils.createDropDown(dropDown: activityDropDown, dataSource: activityData,
                             anchorView: activityButton, screen: "info")
        
        activityDropDown.bottomOffset = CGPoint(x: 0, y: activityButton.frame.size.height)
        
        activityDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.activityLabel.text = item
        }
    }
    
    func convertInputsIntoUserData() -> UserData? {
        guard let age = ageLabel.text, age != "    yrs",
              let ft = ftLabel.text, ft != "  '",
              let inch = inLabel.text, inch != #"   ""#,
              let weight = weightLabel.text, weight != "     lbs",
              let activity = activityLabel.text, activity != " " else { return nil }

        let ageData = age.replacingOccurrences(of: " yrs", with: "")
        let genderData = "female"
        let ftData = (Double(ft.replacingOccurrences(of: "'", with: "")) ?? 0) * 12
        let inData = Double(inch.replacingOccurrences(of: #"""#, with: "")) ?? 0
        let heightData = round((ftData + inData) * 2.54)
        let weightData = round((Double(weight.replacingOccurrences(of: " lbs", with: "")) ?? 0) * 0.45)
        var activityData = ""
        let goalData = "maintain"

        switch activity {
        case "Sedentary":
            activityData = "1"
        case "Lightly active":
            activityData = "2"
        case "Active":
            activityData = "3"
        case "Very Active":
            activityData = "4"
        default:
            activityData = "1"
        }
        
        let userData = UserData(age: ageData, gender: genderData,
                                heightCm: "\(Int(heightData))",
                                weightKg: "\(Int(weightData))",
                                activityLevel: activityData,
                                goal: goalData)
        
        return userData
    }
    
    @objc func didTapCalculateButton() {
        viewModel.userData = convertInputsIntoUserData()

        if let userData = viewModel.userData {
            MacroCalculatorAPI.fetchMacroData(for: userData) { [weak self] dailyMacro in
                guard let self = self else { return }
                self.viewModel.dailyMacro = dailyMacro
                DispatchQueue.main.async {
                    if let dailyMacro = self.viewModel.dailyMacro {
                        let planVC = PlanVC(viewModel: .init(dailyMacro: dailyMacro))
                        self.navigationController?.pushViewController(planVC, animated: true)
                    }
                }
            }
        }
        
//        let dailyMacro = MacroBreakdown(calories: "1890", carbs: "215", protein: "145", fat: "55")
//
//        let planVC = PlanVC(viewModel: .init(dailyMacro: dailyMacro))
//        navigationController?.pushViewController(planVC, animated: true)
    }
}

extension InfoVC {

    func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        constrainSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        
        view.addSubview(ageButton)
        ageButton.addSubview(ageVStack)
        
        view.addSubview(heightWeightHStack)
        
        heightWeightHStack.addSubview(heightButton)
        heightButton.addSubview(heightHStack)
        
        heightWeightHStack.addSubview(weightButton)
        weightButton.addSubview(weightVStack)
        
        view.addSubview(activityButton)
        activityButton.addSubview(activityVStack)
        
        view.addSubview(calculateButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.leftToSuperview(offset: screenWidth * 0.06)
        mainTitle.topToSuperview(offset: screenHeight * 0.09)
        mainTitle.height(screenHeight * 0.06)
        mainTitle.width(screenWidth * 0.5)
        
        ageButton.centerXToSuperview()
        ageButton.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        ageButton.width(screenWidth * 0.39)
        ageButton.height(screenHeight * 0.15)
        
        ageVStack.centerXToSuperview()
        ageVStack.bottomToSuperview(offset: ageButton.frame.height * -0.12)
        ageVStack.height(ageButton.frame.height * 0.33)
        ageVStack.width(ageButton.frame.width * 0.66)

        heightWeightHStack.centerXToSuperview()
        heightWeightHStack.topToBottom(of: ageButton, offset: screenHeight * 0.05)
        heightButton.width(screenWidth * 0.42)
        heightButton.height(screenHeight * 0.15)
        weightButton.width(screenWidth * 0.42)
        weightButton.height(screenHeight * 0.15)

        heightHStack.centerXToSuperview()
        heightHStack.bottomToSuperview(offset: heightButton.frame.height * -0.12)
        heightHStack.width(heightButton.frame.width * 0.87)
        heightHStack.height(heightButton.frame.height * 0.3)
        
        weightVStack.centerXToSuperview()
        weightVStack.bottomToSuperview(offset: heightButton.frame.height * -0.12)
        weightVStack.height(weightButton.frame.height * 0.3)
        weightVStack.width(weightButton.frame.width * 0.65)
        
        activityButton.centerXToSuperview()
        activityButton.topToBottom(of: heightWeightHStack, offset: screenHeight * 0.05)
        
        activityVStack.centerXToSuperview()
        activityVStack.bottomToSuperview(offset: activityButton.frame.height * -0.12)
        activityVStack.height(screenHeight * 0.05)
        activityVStack.width(screenWidth * 0.42)
        
        calculateButton.centerXToSuperview()
        calculateButton.topToBottom(of: activityButton, offset: screenHeight * 0.06)
    }

}



