//
//  PlanView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 11/23/21.
//

import Foundation
import UIKit

extension PlanViewController {
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
    }
    
    func setNavigationBar() {
        let bar = navigationController?.navigationBar
        bar?.standardAppearance.backgroundColor = UIColor(named: "navColor")
        bar?.tintColor = UIColor(named: "buttonTint")
        
        
        let title = UIImageView(image: UIImage(named: "macrohero"))
        navigationItem.titleView = title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(goBack))
        navigationItem.hidesBackButton = true
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(pieChart)
        
        view.addSubview(macroVStack)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.19)
        mainTitle.width(screenWidth * 0.85)
        mainTitle.height(screenHeight * 0.05)
        
        pieChart.centerXToSuperview()
        pieChart.topToBottom(of: mainTitle, offset: screenHeight * 0.05)
        pieChart.width(screenWidth * 0.71)
        pieChart.height(screenHeight * 0.25)
        
        macroVStack.centerXToSuperview()
        macroVStack.topToBottom(of: pieChart, offset: screenHeight * 0.05)
        macroVStack.width(screenWidth * 0.75)
        macroVStack.height(screenHeight * 0.18)
    }
}
