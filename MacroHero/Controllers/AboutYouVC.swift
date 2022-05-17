//
//  AboutYouVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit

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
        let label = Utils.createMainTitle(text: "Tell us about yourself",
                                          noOfLines: 1)
        return label
    }()
    
    lazy var sexSection: UIStackView = {
        let title = UILabel()
        title.text = "Sex"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let maleButton = UIButton()
        maleButton.setTitle("Male", for: .normal)
        maleButton.setTitleColor(UIColor.black, for: .normal)
        maleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        maleButton.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        maleButton.addTarget(self, action: #selector(didTapMaleButton),
                             for: .touchUpInside)
        maleButton.width(screenWidth * 0.4)
        
        let femaleButton = UIButton()
        femaleButton.setTitle("Female", for: .normal)
        femaleButton.setTitleColor(UIColor.black, for: .normal)
        femaleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        femaleButton.setBackgroundImage(Image.aboutButtonBg, for: .normal)
        femaleButton.addTarget(self, action: #selector(didTapFemaleButton),
                             for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [maleButton, femaleButton])
        stack.axis = .horizontal
        stack.spacing = screenWidth * 0.06
        
        let fullStack = UIStackView(arrangedSubviews: [title, stack])
        fullStack.axis = .vertical
        fullStack.spacing = screenHeight * 0.02
        
        return fullStack
    }()
    
    #warning("add calendar popup functionality to set birthday")
    lazy var birthdaySection: UIStackView = {
        let title = UILabel()
        title.text = "Birthday"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        let dateLabel = UILabel()
        dateLabel.text = "00 / 00 / 0000"
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        dateLabel.textColor = .black
        
        let calendarIV = UIImageView()
        calendarIV.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: screenWidth * 0.07))
        calendarIV.tintColor = Color.customNavy
    
        let button = UIButton()
        button.setImage(Image.aboutButtonBgLarge, for: .normal)
        button.addTarget(self, action: #selector(didTapCalendar), for: .touchUpInside)
        
        // Add button's subviews and constraints
        button.addSubview(dateLabel)
        button.addSubview(calendarIV)
        dateLabel.centerInSuperview()
        calendarIV.centerYToSuperview()
        calendarIV.leftToSuperview(offset: screenWidth * 0.86 * 0.05)
        
        let stack = UIStackView(arrangedSubviews: [title, button])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.02
        
        return stack
    }()
   
    // weight button
    // height button
    // calculate macros button
    
    // MARK: - TAP METHODS
    @objc func didTapMaleButton() {
        print("male")
    }
    
    @objc func didTapFemaleButton() {
        print("female")
    }
    
    @objc func didTapCalendar() {
        print("open calendar")
    }
    
    // MARK: - HELPER METHODS
}

extension AboutYouVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        Utils.setNavigationBar(navController: navigationController,
                               navItem: navigationItem,
                               leftBarButtonItem:
                                UIBarButtonItem(image: Image.backButton,
                                                style: .done, target: self,
                                                action: #selector(didTapBackButton)))
        addViews()
        constrainViews()
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addViews() {
        view.addSubview(mainTitle)
        view.addSubview(sexSection)
        view.addSubview(birthdaySection)
    }
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        mainTitle.width(screenWidth * 0.9)
        
        sexSection.centerXToSuperview()
        sexSection.topToBottom(of: mainTitle, offset: screenHeight * 0.05)
        sexSection.width(screenWidth * 0.86)
        
        birthdaySection.centerXToSuperview()
        birthdaySection.topToBottom(of: sexSection, offset: screenHeight * 0.09)
        birthdaySection.width(screenWidth * 0.86)
    }
}
