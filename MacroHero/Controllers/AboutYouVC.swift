//
//  AboutYouVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit
import Inject

#warning("create wheneditingbegins delegate for textfields height and weight")
class AboutYouVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
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
        picker.tintColor = Color.customOrange
        
        return picker
    }()
    
    lazy var birthdaySection: UIStackView = {
        let title = UILabel()
        title.text = " Birthday"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let calendarIV = UIImageView()
        calendarIV.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        calendarIV.tintColor = Color.customNavy
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
        
        let iv = UIImageView(image: Image.setButtonBg)
        iv.addShadowEffect(type: .normalButton)
        iv.isUserInteractionEnabled = true
        
        // Add button's subviews and constraints
        iv.addSubview(datePicker)
        iv.addSubview(calendarIV)
        
        NSLayoutConstraint.activate([
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
    
    lazy var weightStack: UIStackView = {
        let title = UILabel()
        title.text = "Weight"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let iv = UIImageView(image: Image.aboutButtonBg)
        iv.addShadowEffect(type: .normalButton)
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = UITextField()
        textField.text = "-"
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        iv.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: iv.heightAnchor),
            textField.widthAnchor.constraint(equalTo: iv.widthAnchor),
            textField.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: iv.centerYAnchor)
        ])
        
        let stack = UIStackView(arrangedSubviews: [title, iv])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = screenHeight * 0.02
        
        return stack
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
        
        let textField = UITextField()
        textField.text = "-"
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        iv.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: iv.heightAnchor),
            textField.widthAnchor.constraint(equalTo: iv.widthAnchor),
            textField.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: iv.centerYAnchor)
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
            select(maleButton)
            deselect(femaleButton)
        }
    }
    
    @objc func didTapFemale() {
        if !femaleButton.isSelected {
            select(femaleButton)
            deselect(maleButton)
        }
    }
    
    // TODO: save picked date to user object
    @objc func didPickDate(_ sender: UIDatePicker) {
    }
    
    // TODO: save parameters into user object
    // TODO: loading circle to generate nutrition plan in screen based on user object
    @objc func didTapNext() {
        print("next")
        goToNextScreen()
    }
    
    // MARK: - HELPER METHODS
    func select(_ button: UIButton) {
        button.setBackgroundImage(Image.aboutButtonBgSelected, for: .selected)
        button.isSelected = true
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
    
    // MARK: - NAV METHODS
    func goToNextScreen() {
        let nextScreen = Inject.ViewControllerHost(NutritionPlanVC())
        navigationController?.pushViewController(nextScreen, animated: true)
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
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                             multiplier: 0.9)
        ])
            
        NSLayoutConstraint.activate([
            sexSection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            sexSection.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                            constant: screenHeight * 0.05)
        ])

        NSLayoutConstraint.activate([
            birthdaySection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            birthdaySection.topAnchor.constraint(equalTo: sexSection.bottomAnchor,
                                                 constant: screenHeight * 0.08),
            birthdaySection.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                   multiplier: 0.87)
        ])

        NSLayoutConstraint.activate([
            bottomSection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bottomSection.topAnchor.constraint(equalTo: birthdaySection.bottomAnchor,
                                               constant: screenHeight * 0.08)
        ])

        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: screenHeight * -0.1),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83)
        ])
    }
}

