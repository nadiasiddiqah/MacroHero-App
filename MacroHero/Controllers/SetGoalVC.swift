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
        
        return button
    }()
    
    lazy var lowerImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoCrossroads)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - TOUCH METHODS
    #warning("add functionality to buttons")
    @objc func didTapFirst() {
        print("User selected to lose weight")
        goToNextScreen()
    }
    
    @objc func didTapSecond() {
        print("User selected to gain weight")
        goToNextScreen()
    }
    
    @objc func didTapThird() {
        print("User selected to maintain weight")
        goToNextScreen()
    }
    
    // MARK: - HELPER METHODS
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
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(lowerImage)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        lowerImage.translatesAutoresizingMaskIntoConstraints = false
    }

    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.05),
            firstButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: screenHeight * 0.05),
            secondButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: screenHeight * 0.05),
            thirdButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            lowerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerImage.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                            constant: screenHeight * -0.05),
            lowerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
    }
}
