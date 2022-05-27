//
//  AboutYouVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit
import Inject

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
    
    #warning("add calendar popup functionality to set birthday")
    lazy var birthdaySection: UIStackView = {
        let title = UILabel()
        title.text = " Birthday"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let dateLabel = UILabel()
        dateLabel.text = "00 / 00 / 0000"
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let calendarIV = UIImageView()
        calendarIV.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        calendarIV.tintColor = Color.customNavy
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
    
        let button = UIButton()
        button.setImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapCalendar), for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)
        
        // Add button's subviews and constraints
        button.addSubview(dateLabel)
        button.addSubview(calendarIV)
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            calendarIV.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            calendarIV.leadingAnchor.constraint(equalTo: button.leadingAnchor,
                                                constant: screenWidth * 0.86 * 0.05)
        ])
        
        let stack = UIStackView(arrangedSubviews: [title, button])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.02
        
        return stack
    }()
   
    lazy var bottomSection: UIStackView = {
        // Weight Stack
        let title1 = UILabel()
        title1.text = "Weight"
        title1.textColor = .black
        title1.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let button1 = UIButton()
        button1.setTitle("-", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button1.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button1.addTarget(self, action: #selector(didTapWeight), for: .touchUpInside)
        button1.addShadowEffect(type: .normalButton)
        
        let stack1 = UIStackView(arrangedSubviews: [title1, button1])
        stack1.axis = .vertical
        stack1.alignment = .center
        stack1.spacing = screenHeight * 0.02
        
        // Height Stack
        let title2 = UILabel()
        title2.text = "Height"
        title2.textColor = .black
        title2.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        let button2 = UIButton()
        button2.setTitle("-", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button2.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button2.addTarget(self, action: #selector(didTapHeight), for: .touchUpInside)
        button2.addShadowEffect(type: .normalButton)

        let stack2 = UIStackView(arrangedSubviews: [title2, button2])
        stack2.axis = .vertical
        stack2.alignment = .center
        stack2.spacing = screenHeight * 0.02

        // Full Stack
        let fullStack = UIStackView(arrangedSubviews: [stack1, stack2])
        fullStack.axis = .horizontal
        fullStack.spacing = screenWidth * 0.07
        fullStack.distribution = .fillEqually

        return fullStack
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
    
    @objc func didTapCalendar() {
        print("open calendar")
    }
    
    @objc func didTapWeight() {
        print("open weight")
    }
    
    @objc func didTapHeight() {
        print("open height")
    }
    
    @objc func didTapNext() {
        print("next")
        goToNextScreen()
    }
    
    // MARK: - HELPER METHODS
    func goToNextScreen() {
        let nextScreen = Inject.ViewControllerHost(NutritionPlanVC())
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func select(_ button: UIButton) {
        button.setBackgroundImage(Image.aboutButtonBgSelected, for: .selected)
        button.isSelected = true
    }
    
    func deselect(_ button: UIButton) {
        button.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        button.isSelected = false
    }
}

extension AboutYouVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        constrainViews()
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
        view.addSubview(mainTitle)
        view.addSubview(sexSection)
        view.addSubview(birthdaySection)
        view.addSubview(bottomSection)
        view.addSubview(nextButton)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        sexSection.translatesAutoresizingMaskIntoConstraints = false
        birthdaySection.translatesAutoresizingMaskIntoConstraints = false
        bottomSection.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   multiplier: 0.9),
            
            sexSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sexSection.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                            constant: screenHeight * 0.05),
            
            birthdaySection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdaySection.topAnchor.constraint(equalTo: sexSection.bottomAnchor,
                                                 constant: screenHeight * 0.08),
            birthdaySection.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   multiplier: 0.87),
            
            bottomSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomSection.topAnchor.constraint(equalTo: birthdaySection.bottomAnchor,
                                               constant: screenHeight * 0.08),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: screenHeight * -0.1),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83)
        ])
    }
}

