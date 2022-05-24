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
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(lowerImage)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        fourthButton.translatesAutoresizingMaskIntoConstraints = false
        lowerImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.04),
            firstButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: screenHeight * 0.03),
            secondButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: screenHeight * 0.03),
            thirdButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            fourthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: screenHeight * 0.03),
            fourthButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            lowerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerImage.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: screenHeight * 0.03),
            lowerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
    }
}
