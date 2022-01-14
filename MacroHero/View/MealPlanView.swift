//
//  MealPlanView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/31/21.
//

import Foundation
import UIKit

extension MealPlanViewController {
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        
        setNavigationBar(navController: navigationController, navItem: navigationItem)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainTitle)
        
        contentView.addSubview(breakfastTitle)
        contentView.addSubview(breakfastImage)
        contentView.addSubview(breakfastMacro)
        contentView.addSubview(refreshBreakfast)
        
        contentView.addSubview(lunchTitle)
        contentView.addSubview(lunchImage)
        contentView.addSubview(lunchMacro)
        contentView.addSubview(refreshLunch)
        
        contentView.addSubview(dinnerTitle)
        contentView.addSubview(dinnerImage)
        contentView.addSubview(dinnerMacro)
        contentView.addSubview(refreshDinner)

        contentView.addSubview(proteinShakeTitle)
        contentView.addSubview(proteinShakeImage)
        contentView.addSubview(proteinShakeMacro)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.04)
        
        addConstraintsForMeal(title: breakfastTitle, topToBottomOf: mainTitle,
                              image: breakfastImage, macro: breakfastMacro,
                              refreshButton: refreshBreakfast)
        
        addConstraintsForMeal(title: lunchTitle, topToBottomOf: breakfastImage,
                              image: lunchImage, macro: lunchMacro,
                              refreshButton: refreshLunch)
        
        addConstraintsForMeal(title: dinnerTitle, topToBottomOf: lunchImage,
                              image: dinnerImage, macro: dinnerMacro,
                              refreshButton: refreshDinner)
        
        addConstraintsForMeal(title: proteinShakeTitle, topToBottomOf: dinnerImage,
                              image: proteinShakeImage, macro: proteinShakeMacro)
    }
}
