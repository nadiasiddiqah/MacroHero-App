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
        let title = Utils.createMainTitle(text: "What's your goal?",
                                          noOfLines: 1)
        
        return title
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lose Weight", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapFirst), for: .touchUpInside)
        button.addShadowEffect()
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gain Weight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        button.addShadowEffect()
        
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("Maintain Weight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapThird), for: .touchUpInside)
        button.addShadowEffect()
        
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
        Utils.setNavigationBar(navController: navigationController,
                               navItem: navigationItem,
                               leftBarButtonItem:
                                UIBarButtonItem(image: Image.backButton,
                                                style: .done, target: self,
                                                action: #selector(didTapBackButton)))
        
        addViews()
        constrainViews()
    }
    
    @objc func didTapBackButton(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addViews() {
        view.addSubview(mainTitle)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(lowerImage)
    }
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        mainTitle.width(screenWidth * 0.9)
        
        firstButton.centerXToSuperview()
        firstButton.topToBottom(of: mainTitle, offset: screenHeight * 0.06)
        firstButton.width(screenWidth * 0.9)
        
        secondButton.centerXToSuperview()
        secondButton.topToBottom(of: firstButton, offset: screenHeight * 0.05)
        secondButton.width(screenWidth * 0.9)
        
        thirdButton.centerXToSuperview()
        thirdButton.topToBottom(of: secondButton, offset: screenHeight * 0.05)
        thirdButton.width(screenWidth * 0.9)
        
        lowerImage.centerXToSuperview()
        lowerImage.topToBottom(of: thirdButton, offset: screenHeight * 0.09)
        lowerImage.width(screenWidth * 0.8)
    }
}
