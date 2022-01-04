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
        view.addSubview(mealGrid)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.14)
        
        mealGrid.centerXToSuperview()
        mealGrid.topToBottom(of: mainTitle, offset: screenHeight * 0.04)
    }
}
