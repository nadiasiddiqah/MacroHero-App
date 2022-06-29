//
//  IntroViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import UIKit
import Gifu
import Inject

class StartVC: UIViewController {
    
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - VIEW VARIABLES
    lazy var introImage: UIImageView = {
        let imageView = UIImageView(image: Image.introImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var signupButton: CTAButton = {
        let button = CTAButton()
        button.configure(with: CTAButtonModel(name: "SIGN UP", backgroundColor: Color.ctaButtonColor, action: {
            self.didTapSignup()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var loginButton: CTAButton = {
        let button = CTAButton()
        button.configure(with: CTAButtonModel(name: "LOG IN", backgroundColor: UIColor.clear,
                                              borderColor: Color.ctaButtonColor?.cgColor, action: {
            self.didTapLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signupButton, loginButton])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.02
        stack.alignment = .center
        
        NSLayoutConstraint.activate([
            signupButton.widthAnchor.constraint(
                equalTo: stack.widthAnchor, multiplier: 0.83),
            signupButton.heightAnchor.constraint(
                equalTo: signupButton.widthAnchor, multiplier: 0.16),
            loginButton.widthAnchor.constraint(
                equalTo: stack.widthAnchor, multiplier: 0.83),
            loginButton.heightAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 0.16)
        ])
        
        return stack
    }()
    
    lazy var fullStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [introImage, buttonStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            introImage.widthAnchor.constraint(
                equalTo: stack.widthAnchor, multiplier: 0.9),
            introImage.bottomAnchor.constraint(lessThanOrEqualTo: buttonStack.topAnchor, constant: screenHeight * -0.1),
            buttonStack.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
        
        return stack
    }()
    
    @objc func didTapSignup() {
        let vc = Inject.ViewControllerHost(SignupVC())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapLogin() {
        let vc = Inject.ViewControllerHost(LoginVC())
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    fileprivate func addViews() {
        view.addSubview(fullStack)
    }
    
    fileprivate func autoLayoutViews() {
        fullStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            fullStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            fullStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: screenHeight * -0.05)
        ])
    }
}
