//
//  SetGoalVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/14/22.
//

import Foundation
import UIKit
import Inject

class SetGoalVC: UIViewController {
    
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
            title: "What's your goal?"))
        
        return label
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lose Weight", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapFirst), for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gain Weight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("Maintain Weight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapThird), for: .touchUpInside)
        button.addShadowEffect(type: .normalButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.05
        
        return stack
    }()
    
    lazy var lowerImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoCrossroads)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - TOUCH METHODS
    #warning("store selection in user object")
    @objc func didTapFirst() {
        if firstButton.isSelected {
            goToNextScreen()
        } else {
            deselect([secondButton, thirdButton])
            select(firstButton)
            goToNextScreen()
        }
    }
    
    @objc func didTapSecond() {
        if secondButton.isSelected {
            goToNextScreen()
        } else {
            deselect([thirdButton, firstButton])
            select(secondButton)
            goToNextScreen()
        }
    }
    
    @objc func didTapThird() {
        if thirdButton.isSelected {
            goToNextScreen()
        } else {
            deselect([firstButton, secondButton])
            select(thirdButton)
            goToNextScreen()
        }
    }
    
    // MARK: - HELPER METHODS
    func select(_ button: UIButton) {
        button.setBackgroundImage(Image.setButtonBgSelected, for: .selected)
        button.isSelected = true
    }
    
    func deselect(_ buttons: [UIButton]) {
        buttons.forEach {
            $0.setBackgroundImage(Image.setButtonBg, for: .normal)
            $0.isSelected = false
        }
    }
    
    // MARK: - NAV METHODS
    func goToNextScreen() {
        let setActivityVC = Inject.ViewControllerHost(SetActivityVC())
        navigationController?.pushViewController(setActivityVC, animated: true)
    }
}

extension SetGoalVC {
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
        view.addSubview(buttonStack)
        view.addSubview(lowerImage)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        lowerImage.translatesAutoresizingMaskIntoConstraints = false
    }

    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.05),
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            lowerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerImage.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: screenHeight * 0.05),
            lowerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
    }
}
