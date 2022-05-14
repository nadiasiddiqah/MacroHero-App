//
//  SetGoalVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/14/22.
//

import Foundation
import UIKit

class SetGoalVC: UIViewController {
    
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    lazy var mainTitle: UILabel = {
        let title = Utils.createMainTitle(text: "What's your goal?")
        
        return title
    }()
    
    lazy var loseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.goalButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapLose), for: .touchUpInside)
        
        return button
    }()
    
    lazy var gainButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.goalButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapGain), for: .touchUpInside)
        
        return button
    }()
    
    lazy var maintainButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.goalButtonBg, for: .normal)
        button.addTarget(self, action: #selector(didTapMaintain), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapLose() {
        print("User selected to lose weight")
    }
    
    @objc func didTapGain() {
        print("User selected to gain weight")
    }
    
    @objc func didTapMaintain() {
        print("User selected to maintain weight")
    }
    
    
    // Lose Weight button
    // Main Weight button
    // Gain Weight button
    // Crossroads Image
}

extension SetGoalVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        Utils.setNavigationBar(navController: navigationController,
                               navItem: navigationItem, showTitle: false,
                               leftBarButtonItem: UIBarButtonItem(image: Image.backButton,
                                                                  style: .done, target: self,
                                                                  action: #selector(goBack)))
        
        addViews()
        constrainViews()
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addViews() {
        view.addSubview(mainTitle)
        view.addSubview(loseButton)
        view.addSubview(gainButton)
        view.addSubview(maintainButton)
    }
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        
        loseButton.centerXToSuperview()
        loseButton.topToBottom(of: mainTitle, offset: screenHeight * 0.06)
        loseButton.width(screenWidth * 0.9)
        
        gainButton.centerXToSuperview()
        gainButton.topToBottom(of: loseButton, offset: screenHeight * 0.05)
        gainButton.width(screenWidth * 0.9)
        
        maintainButton.centerXToSuperview()
        maintainButton.topToBottom(of: gainButton, offset: screenHeight * 0.05)
        maintainButton.width(screenWidth * 0.9)
    }
}
