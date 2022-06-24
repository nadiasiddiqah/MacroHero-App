//
//  SignupVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/23/22.
//

import Foundation
import UIKit

class SignupVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: MainLabel = {
        let label = MainLabel()
        label.configure(with: MainLabelModel(title: "Hey there!", type: .onboardingView))
        
        return label
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        iv.image = Image.theoWave
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Let's create an account:"
        label.textAlignment = .center
        
        return label
    }()
    
    
    lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.googleSignup, for: .normal)
        button.addShadowEffect(type: .ctaButton)
        button.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.appleSignup, for: .normal)
        button.addShadowEffect(type: .ctaButton)
        button.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.emailSignup, for: .normal)
        button.addShadowEffect(type: .ctaButton)
        button.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [text, googleButton, appleButton, emailButton])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.03
        
        NSLayoutConstraint.activate([
            googleButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            googleButton.heightAnchor.constraint(equalTo: stack.widthAnchor,
                                                 multiplier: 0.17),
            appleButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            appleButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor),
            emailButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            emailButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor)
        ])
        
        return stack
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapEmail() {
        
    }
}

extension SignupVC {
    func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        configureViews()
    }
    
    func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBack))
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func addViews() {
        view.addSubview(mainTitle)
        view.addSubview(buttonStack)
        view.addSubview(iv)
    }
    
    func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        iv.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureViews() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iv.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.03),
            iv.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.85)
        ])
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(greaterThanOrEqualTo: iv.bottomAnchor, constant: screenHeight * 0.05),
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               multiplier: 0.82),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                constant: screenHeight * -0.07)
        ])
    }
}
