//
//  ProteinView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import Foundation
import UIKit

extension ProteinViewController {

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
        view.addSubview(mainTitle)
        view.addSubview(proteinShakeGif)
        view.addSubview(macroVStack)
        
        calTextArea.addSubview(calLabel)
        carbsTextArea.addSubview(carbsLabel)
        proteinTextArea.addSubview(proteinLabel)
        fatTextArea.addSubview(fatLabel)
        
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.topToSuperview(offset: screenHeight * 0.21)
        mainTitle.centerXToSuperview()
        
        proteinShakeGif.topToBottom(of: mainTitle)
        proteinShakeGif.centerXToSuperview()
        proteinShakeGif.width(screenWidth * 0.67)
        proteinShakeGif.height(screenHeight * 0.18)
        
        macroVStack.centerXToSuperview()
        macroVStack.topToBottom(of: proteinShakeGif, offset: screenHeight * 0.05)
        macroVStack.width(screenWidth * 0.65)
        macroVStack.height(screenHeight * 0.18)
        
        calLabel.centerInSuperview()
        carbsLabel.centerInSuperview()
        proteinLabel.centerInSuperview()
        fatLabel.centerInSuperview()
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}
