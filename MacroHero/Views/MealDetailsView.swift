//
//  MealDetailsView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import Foundation
import UIKit

extension MealDetailsViewController {
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(topView)
        contentView.addSubview(nutritionView)
        contentView.addSubview(ingredientsView)
        contentView.addSubview(instructionsView)
    }
    
    fileprivate func constrainSubviews() {
        let VStack = [topView, nutritionView, ingredientsView]
        contentView.stack(VStack, spacing: screenHeight * 0.03)
        contentView.centerXToSuperview()
        contentView.topToSuperview(offset: screenHeight * 0.04)
        contentView.width(screenWidth * 0.8)
        
        instructionsView.width(screenWidth * 0.8)
        instructionsView.topToBottom(of: contentView, offset: screenHeight * 0.001)
    }
}
