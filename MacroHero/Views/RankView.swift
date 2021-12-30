//
//  RankView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/27/21.
//

import Foundation
import UIKit

extension RankViewController {
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        collapsedFirstGoal?.isActive = true
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        firstGoalButton.addSubview(firstGoalLabel)
        view.addSubview(firstGoalHStack)
        secondGoalButton.addSubview(secondGoalLabel)
        view.addSubview(secondGoalHStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.16)
        
        firstGoalLabel.leftToSuperview(offset: screenWidth * 0.04)
        firstGoalLabel.centerYToSuperview()
        
        firstGoalHStack.leftToSuperview(offset: screenWidth * 0.09)
        firstGoalHStack.topToBottom(of: mainTitle, offset: screenWidth * 0.05)
        firstGoalHStack.width(screenWidth * 0.7)
        
        secondGoalLabel.leftToSuperview(offset: screenWidth * 0.04)
        secondGoalLabel.centerYToSuperview()
        
        secondGoalHStack.leftToSuperview(offset: screenWidth * 0.09)
        
        collapsedFirstGoal = secondGoalHStack.topToBottom(of: firstGoalHStack,
                                                          offset: screenHeight * 0.04,
                                                          isActive: false)
        expandedFirstGoal = secondGoalHStack.topToBottom(of: firstGoalHStack,
                                                         offset: screenHeight * 0.26,
                                                         isActive: false)
        secondGoalHStack.width(screenWidth * 0.7)
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}
