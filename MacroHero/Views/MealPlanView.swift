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
        
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         rightBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                                             style: .done, target: self,
                                                             action: #selector(showProfile)))
    }
    
    @objc func showProfile(sender: UIBarButtonItem) {
        print("showProfile")
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(breakfastTitle)
        view.addSubview(breakfastImage)
        view.addSubview(breakfastMacro)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.14)
        
        breakfastTitle.leftToSuperview(offset: screenWidth * 0.05)
        breakfastTitle.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        
        breakfastImage.leftToSuperview(offset: screenWidth * 0.05)
        breakfastImage.topToBottom(of: breakfastTitle, offset: screenHeight * 0.01)
        breakfastImage.width(screenWidth * 0.45)
        breakfastImage.aspectRatio(1.63)
        
        breakfastMacro.topToBottom(of: breakfastTitle, offset: screenHeight * 0.01)
        breakfastMacro.leftToRight(of: breakfastImage, offset: screenWidth * 0.02)
        
    }
}
