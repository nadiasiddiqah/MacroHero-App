//
//  InfoView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/6/21.
//

import UIKit

extension InfoViewController {

    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        
        view.addSubview(ageButton)
        ageButton.addSubview(ageVStack)
        
        view.addSubview(heightWeightHStack)
        
        heightWeightHStack.addSubview(heightButton)
        heightButton.addSubview(heightHStack)
        
        heightWeightHStack.addSubview(weightButton)
        weightButton.addSubview(weightVStack)
        
        view.addSubview(activityButton)
        activityButton.addSubview(activityVStack)
        
        view.addSubview(calculateButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.leftToSuperview(offset: screenWidth * 0.06)
        mainTitle.topToSuperview(offset: screenHeight * 0.09)
        mainTitle.height(screenHeight * 0.06)
        mainTitle.width(screenWidth * 0.5)
        
        ageButton.centerXToSuperview()
        ageButton.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        ageButton.width(screenWidth * 0.39)
        ageButton.height(screenHeight * 0.15)
        
        ageVStack.centerXToSuperview()
        ageVStack.bottomToSuperview(offset: ageButton.frame.height * -0.12)
        ageVStack.height(ageButton.frame.height * 0.33)
        ageVStack.width(ageButton.frame.width * 0.66)

        heightWeightHStack.centerXToSuperview()
        heightWeightHStack.topToBottom(of: ageButton, offset: screenHeight * 0.05)
        heightButton.width(screenWidth * 0.42)
        heightButton.height(screenHeight * 0.15)
        weightButton.width(screenWidth * 0.42)
        weightButton.height(screenHeight * 0.15)

        heightHStack.centerXToSuperview()
        heightHStack.bottomToSuperview(offset: heightButton.frame.height * -0.12)
        heightHStack.width(heightButton.frame.width * 0.87)
        heightHStack.height(heightButton.frame.height * 0.3)
        
        weightVStack.centerXToSuperview()
        weightVStack.bottomToSuperview(offset: heightButton.frame.height * -0.12)
        weightVStack.height(weightButton.frame.height * 0.3)
        weightVStack.width(weightButton.frame.width * 0.65)
        
        activityButton.centerXToSuperview()
        activityButton.topToBottom(of: heightWeightHStack, offset: screenHeight * 0.05)
        
        activityVStack.centerXToSuperview()
        activityVStack.bottomToSuperview(offset: activityButton.frame.height * -0.12)
        activityVStack.height(screenHeight * 0.05)
        activityVStack.width(screenWidth * 0.42)
        
        calculateButton.centerXToSuperview()
        calculateButton.topToBottom(of: activityButton, offset: screenHeight * 0.06)
    }

}



