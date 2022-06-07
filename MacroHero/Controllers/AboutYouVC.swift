//
//  AboutYouVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit
import Inject

//extension UITextField {
//    func setDatePickerAsInputViewFor(target: UIViewController, selector: Selector) {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        self.inputView = datePicker
//    }
//}

class AboutYouVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    private var userData: UserData
    var sex: Sex?
    var birthday = Date()
    var ftData = String()
    var inData = String()
    var weight = String()
    
    // MARK: - INITIALIZER
    init(userData: UserData) {
        self.userData = userData
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
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()

    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "Tell us about yourself"))

        return label
    }()

    lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapMale),
                         for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)

        return button
    }()

    lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Female", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapFemale),
                         for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)

        return button
    }()

    lazy var sexSection: UIStackView = {
        let title = UILabel()
        title.text = " Sex"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        let stack = UIStackView(arrangedSubviews: [maleButton, femaleButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = screenWidth * 0.07

        let fullStack = UIStackView(arrangedSubviews: [title, stack])
        fullStack.axis = .vertical
        fullStack.spacing = screenHeight * 0.02

        return fullStack
    }()

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(didPickDate), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.preferredDatePickerStyle = .compact
        picker.tintColor = Color.customOrange!

        return picker
    }()

    lazy var birthdaySection: UIStackView = {
        let title = UILabel()
        title.text = " Birthday"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let iv = UIImageView(image: Image.setButtonBg)
        iv.addShadowEffect(type: .normalButton)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCalendar)))
        iv.translatesAutoresizingMaskIntoConstraints = false

        let calendarIV = UIImageView()
        calendarIV.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        calendarIV.tintColor = Color.customNavy
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
        
//        let textField = UITextField()
//        textField.text = "00 / 00 / 00"
//        textField.backgroundColor = .red
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))

        // Add button's subviews and constraints
        iv.addSubview(datePicker)
//        iv.addSubview(textField)
        iv.addSubview(calendarIV)

        NSLayoutConstraint.activate([
//            textField.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
//            textField.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            datePicker.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            calendarIV.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            calendarIV.leadingAnchor.constraint(equalTo: iv.leadingAnchor,
                                                constant: screenWidth * 0.86 * 0.05)
        ])

        let stack = UIStackView(arrangedSubviews: [title, iv])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.02

        return stack
    }()
    
    // MARK: - HEIGHT
    lazy var ftTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .right

        return textField
    }()

    lazy var inTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .right

        return textField
    }()
    
    lazy var heightLabelStack: UIStackView = {
        // Feet
        let label1 = UILabel()
        label1.text = "'"
        label1.textColor = .black
        label1.translatesAutoresizingMaskIntoConstraints = false

        let ftStack = UIStackView(arrangedSubviews: [ftTextField, label1])
        ftStack.axis = .horizontal
        ftStack.translatesAutoresizingMaskIntoConstraints = false
        ftStack.spacing = 0

        // Inches
        let label2 = UILabel()
        label2.text = #"""#
        label2.textColor = .black
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        let inStack = UIStackView(arrangedSubviews: [inTextField, label2])
        inStack.axis = .horizontal
        inStack.translatesAutoresizingMaskIntoConstraints = false
        inStack.spacing = 0

        // Feet and inches
        let labelStack = UIStackView(arrangedSubviews: [ftStack, inStack])
        labelStack.axis = .horizontal
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label1.widthAnchor.constraint(equalToConstant: 10),
            label2.widthAnchor.constraint(equalTo: label1.widthAnchor)
        ])
        
        return labelStack
    }()

    lazy var heightStack: UIStackView = {
        let title = UILabel()
        title.text = "Height"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        let iv = UIImageView(image: Image.aboutButtonBg)
        iv.addShadowEffect(type: .normalButton)
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeight)))

        iv.addSubview(heightLabelStack)

        NSLayoutConstraint.activate([
            ftTextField.widthAnchor.constraint(equalTo: inTextField.widthAnchor),
            heightLabelStack.heightAnchor.constraint(equalTo: iv.heightAnchor),
            heightLabelStack.widthAnchor.constraint(
                equalTo: iv.widthAnchor, multiplier: 0.4),
            heightLabelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            heightLabelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor)
        ])

        let stack = UIStackView(arrangedSubviews: [title, iv])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = screenHeight * 0.02

        return stack
    }()

    // MARK: - WEIGHT
    lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.keyboardType = .numberPad

        return textField
    }()
    lazy var weightLabelStack: UIStackView = {
        let label = UILabel()
        label.text = "lbs"
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        let labelStack = UIStackView(arrangedSubviews: [weightTextField, label])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .horizontal
        
        return labelStack
    }()

    lazy var weightStack: UIStackView = {
        let title = UILabel()
        title.text = "Weight"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        let iv = UIImageView(image: Image.aboutButtonBg)
        iv.addShadowEffect(type: .normalButton)
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapWeight)))

        iv.addSubview(weightLabelStack)

        NSLayoutConstraint.activate([
            weightLabelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            weightLabelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            weightLabelStack.widthAnchor.constraint(
                equalTo: iv.widthAnchor, multiplier: 0.5),
            weightLabelStack.heightAnchor.constraint(equalTo: iv.heightAnchor)
        ])

        let stack = UIStackView(arrangedSubviews: [title, iv])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = screenHeight * 0.02

        return stack
    }()

    lazy var bottomSection: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heightStack, weightStack])
        stack.axis = .horizontal
        stack.spacing = screenWidth * 0.07
        stack.distribution = .fillEqually

        return stack
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_25
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        button.addShadowEffect(type: .ctaButton)

        return button
    }()

    // MARK: - TAP METHODS
    @objc func didTapMale() {
        if !maleButton.isSelected {
            select(maleButton, sex: Sex.male)
            deselect(femaleButton)
        }
    }

    @objc func didTapFemale() {
        if !femaleButton.isSelected {
            select(femaleButton, sex: Sex.female)
            deselect(maleButton)
        }
    }

    @objc func didTapCalendar() {
        print("clicked calendar")
    }
    
    // TODO: save picked date to user object
    @objc func didPickDate(_ sender: UIDatePicker) {
        birthday = sender.date
    }

    @objc func didTapHeight(_ gesture: UITapGestureRecognizer) {
        if let view = gesture.view {
            let touchPoint = gesture.location(in: view)
                if touchPoint.x <= view.center.x {
                ftTextField.becomeFirstResponder()
            } else {
                inTextField.becomeFirstResponder()
            }
        }
    }

    @objc func didTapWeight() {
        weightTextField.becomeFirstResponder()
    }

    // TODO: loading circle to generate nutrition plan in screen based on user object
    @objc func didTapNext() {
        view.endEditing(true)
        goToNextScreen()
    }

    // MARK: - HELPER METHODS
    func select(_ button: UIButton, sex: Sex) {
        button.setBackgroundImage(Image.aboutButtonBgSelected, for: .selected)
        button.isSelected = true
        self.sex = sex
    }

    func deselect(_ button: UIButton) {
        button.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button.isSelected = false
    }

    func gestureToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)

        let downSwipe = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(hideKeyboard))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)


        let upSwipe = UISwipeGestureRecognizer(target: self,
                                               action: #selector(hideKeyboard))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func convertBirthdayToAge() -> String {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        
        return "\(ageComponents.year!)"
    }
    
    func convertHeightToCm() -> String {
        guard let ftData = Int(ftData), let inData = Int(inData) else { return "" }
        let totalIn = (ftData * 12) + inData
        let totalCm = Int(Double(totalIn) * 2.54)
        
        return "\(totalCm)"
    }
    
    func convertWeightToKg() -> String {
        guard let weight = Int(weight) else { return "" }
        let kg = Int(Double(weight) * 0.45)
        
        return "\(kg)"
    }

    // MARK: - NAV METHODS
    func goToNextScreen() {
        // Passed Data
//        userData.sex = sex
//        userData.age = convertBirthdayToAge()
//        userData.heightCm = convertHeightToCm()
//        userData.weightKg = convertWeightToKg()
        
        userData = UserData(age: "25", heightCm: "160", weightKg: "68", sex: Sex.female, activityLevel: Activity.moderateExercise, goal: Goal.lose)
        
        DispatchQueue.main.async {
            MacroCalculatorAPI.fetchMacroData(for: self.userData) { [weak self] results in
                guard let self = self else { return }
                self.userData.macroPlan = results
                
                guard let macroPlan = self.userData.macroPlan else { return }
                let vc = Inject.ViewControllerHost(
                    NutritionChartVC(userData: self.userData))
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension AboutYouVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var maxLength = 0

        if textField == weightTextField {
            maxLength = 3
        } else if textField == ftTextField {
            maxLength = 1
        } else {
            maxLength = 2
        }

        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField) did end editing")
        if let userInput = textField.text, !userInput.isEmpty {
            if textField == weightTextField {
                weight = userInput
            } else if textField == ftTextField {
                ftData = userInput
            } else if textField == inTextField {
                inData = userInput
            }
        }
        
        print(weight)
        print(ftData)
        print(inData)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AboutYouVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        constrainViews()
        gestureToHideKeyboard()
    }

    fileprivate func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBack))
    }

    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    fileprivate func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(sexSection)
        scrollView.addSubview(birthdaySection)
        scrollView.addSubview(bottomSection)
        scrollView.addSubview(nextButton)
    }

    fileprivate func autoLayoutViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        sexSection.translatesAutoresizingMaskIntoConstraints = false
        birthdaySection.translatesAutoresizingMaskIntoConstraints = false
        bottomSection.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainTitle.topAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            sexSection.centerXAnchor.constraint(
                equalTo: scrollView.centerXAnchor),
            sexSection.topAnchor.constraint(
                equalTo: mainTitle.bottomAnchor,
                constant: screenHeight * 0.05)
        ])
        
        NSLayoutConstraint.activate([
            birthdaySection.centerXAnchor.constraint(
                equalTo: scrollView.centerXAnchor),
            birthdaySection.topAnchor.constraint(
                equalTo: sexSection.bottomAnchor,
                constant: screenHeight * 0.08)
        ])
        
        NSLayoutConstraint.activate([
            bottomSection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bottomSection.topAnchor.constraint(
                equalTo: birthdaySection.bottomAnchor,
                constant: screenHeight * 0.08)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nextButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: screenHeight * -0.09),
            nextButton.widthAnchor.constraint(
                equalTo: view.widthAnchor, multiplier: 0.83)
        ])
    }
}

