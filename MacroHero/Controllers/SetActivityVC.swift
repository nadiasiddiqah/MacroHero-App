//
//  SetActivityVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit
import Inject

class SetActivityVC: UIViewController {
    
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
        var label = UILabel()
        label.text = """
        What's your activity
        level?
        """
        label.font = Fonts.solid_30
        label.textColor = Color.customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    #warning("change highlight color from gray to something else bc it hides gray text")
    lazy var firstButton: UIButton = {
        let button = UIButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFirst))
        button.addGestureRecognizer(tapGesture)
        
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addShadowEffect()
        
        let label = UILabel()
        label.text = "No Exercise"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        let subLabel = UILabel()
        subLabel.text = "no exercise or very infrequent"
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .gray
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.isUserInteractionEnabled = true
        stack.addGestureRecognizer(tapGesture)
        
        button.addSubview(stack)
        stack.centerInSuperview()
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSecond))
        button.addGestureRecognizer(tapGesture)
        
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        button.addShadowEffect()
        
        let label = UILabel()
        label.text = "Light Exercise"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        let subLabel = UILabel()
        subLabel.text = "some light cardio/weights a few times per week"
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .gray
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        
        button.addSubview(stack)
        stack.centerInSuperview()
        
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapThird))
        button.addGestureRecognizer(tapGesture)
        
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        button.addShadowEffect()
        
        let label = UILabel()
        label.text = "Moderate Exercise"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        let subLabel = UILabel()
        subLabel.text = "lifting/cardio regularly but not super intense"
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .gray
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        
        button.addSubview(stack)
        stack.centerInSuperview()
        
        return button
    }()
    
    lazy var fourthButton: UIButton = {
        let button = UIButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFourth))
        button.addGestureRecognizer(tapGesture)
        
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        button.addShadowEffect()
        
        let label = UILabel()
        label.text = "Hard Exercise"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        let subLabel = UILabel()
        subLabel.text = "most days per week involve demanding exercise"
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .gray
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        
        button.addSubview(stack)
        stack.centerInSuperview()
        
        return button
    }()
    
    lazy var lowerImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoStrong)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapFirst() {
        print("Tapped 1")
        goToNextScreen()
    }
    
    @objc func didTapSecond() {
        print("Tapped 2")
        goToNextScreen()
    }
    
    @objc func didTapThird() {
        print("Tapped 3")
        goToNextScreen()
    }
    
    @objc func didTapFourth() {
        print("Tapped 4")
        goToNextScreen()
    }
    
    // MARK: - HELPER METHODS
    func goToNextScreen() {
        let aboutYouVC = Inject.ViewControllerHost(AboutYouVC())
        navigationController?.pushViewController(aboutYouVC, animated: true)
    }
}

extension SetActivityVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
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
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(lowerImage)
    }
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        mainTitle.width(screenWidth * 0.9)
        
        firstButton.centerXToSuperview()
        firstButton.topToBottom(of: mainTitle, offset: screenHeight * 0.04)
        firstButton.width(screenWidth * 0.9)
        
        secondButton.centerXToSuperview()
        secondButton.topToBottom(of: firstButton, offset: screenHeight * 0.03)
        secondButton.width(screenWidth * 0.9)
        
        thirdButton.centerXToSuperview()
        thirdButton.topToBottom(of: secondButton, offset: screenHeight * 0.03)
        thirdButton.width(screenWidth * 0.9)
        
        fourthButton.centerXToSuperview()
        fourthButton.topToBottom(of: thirdButton, offset: screenHeight * 0.03)
        fourthButton.width(screenWidth * 0.9)
        
        lowerImage.centerXToSuperview()
        lowerImage.topToBottom(of: fourthButton, offset: screenHeight * 0.06)
        lowerImage.width(screenWidth * 0.8)
    }
}
