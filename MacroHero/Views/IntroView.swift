//
//  IntroView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import Foundation
import UIKit

extension IntroViewController {
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(textBubble)
        view.addSubview(macroManGif)
        view.addSubview(logo)
        view.addSubview(startButton)
    }
    
    fileprivate func constrainSubviews() {
        textBubble.topToSuperview(offset: screenHeight * 0.15)
        textBubble.rightToSuperview(offset: screenWidth * -0.06)
        textBubble.width(screenWidth * 0.3)
        textBubble.height(screenHeight * 0.12)
        
        macroManGif.centerXToSuperview()
        macroManGif.topToBottom(of: textBubble, offset: screenHeight * -0.02)
        macroManGif.width(screenWidth * 0.93)
        macroManGif.height(screenHeight * 0.3)
        
        logo.centerXToSuperview()
        logo.topToBottom(of: macroManGif, offset: screenHeight * -0.03)
        logo.width(screenWidth * 0.86)
        logo.height(screenHeight * 0.17)
        
        startButton.centerXToSuperview()
        startButton.topToSuperview(offset: screenHeight * 0.82)
        startButton.width(screenWidth * 0.36)
        startButton.height(screenHeight * 0.06)
    }
}
