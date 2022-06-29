//
//  LoginVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/23/22.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: MainLabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(title: "Welcome back!",
                                             type: .onboardingView))
        return label
    }()
    
    lazy var emailField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        
        let iv = UIImageView(image: Image.emailIcon)
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.06,
                          height: screenWidth * 0.06)
        iv.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.14,
                                            height: screenWidth * 0.85 * 0.16))
        leftView.addSubview(iv)
        iv.center = leftView.center
        
        tf.leftView = leftView
        tf.leftViewMode = .always

        tf.backgroundColor = .white
        tf.layer.cornerRadius = 14
        tf.layer.borderColor = UIColor.systemGray4.cgColor
        tf.layer.borderWidth = 1.0
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var passField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Password"
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        
        let iv = UIImageView(image: Image.keyIcon)
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.06,
                          height: screenWidth * 0.06)
        iv.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.14,
                                            height: screenWidth * 0.85 * 0.16))
        leftView.addSubview(iv)
        iv.center = leftView.center
        
        tf.leftView = leftView
        tf.leftViewMode = .always

        tf.backgroundColor = .white
        tf.layer.cornerRadius = 14
        tf.layer.borderColor = UIColor.systemGray4.cgColor
        tf.layer.borderWidth = 1.0
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = Color.ctaButtonColor
        button.layer.cornerRadius = 14
        button.addShadowEffect(type: .ctaButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var loginStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [emailField, passField])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.015
        
        var fullStack = UIStackView(arrangedSubviews: [stack, loginButton])
        fullStack.axis = .vertical
        fullStack.spacing = screenHeight * 0.02
        
        NSLayoutConstraint.activate([
            emailField.widthAnchor.constraint(equalTo: fullStack.widthAnchor),
            emailField.heightAnchor.constraint(equalTo: fullStack.widthAnchor, multiplier: 0.16)
        ])
        
        NSLayoutConstraint.activate([
            passField.widthAnchor.constraint(equalTo: fullStack.widthAnchor),
            passField.heightAnchor.constraint(equalTo: fullStack.widthAnchor, multiplier: 0.16)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalTo: fullStack.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: fullStack.widthAnchor, multiplier: 0.17),
        ])
        
        return fullStack
    }()
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "or"
        label.textAlignment = .center
        label.textColor = Color.customOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

}

extension LoginVC {
    func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func addViews() {
        view.addSubview(mainTitle)
        view.addSubview(loginStack)
        view.addSubview(text)
    }
    
    func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        loginStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.03),
            loginStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: screenHeight * 0.03),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
