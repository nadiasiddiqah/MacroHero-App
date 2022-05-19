//
//  UIButton+Ext.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import Foundation
import UIKit

#warning("delete after setting up activitybutton class")
extension UIButton {
    class func activityButton(action: Selector, text: String, subText: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(Image.setButtonBg, for: .normal)
        button.addTarget(SetActivityVC(), action: action, for: .touchUpInside)
        button.addShadowEffect()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        let subLabel = UILabel()
        subLabel.text = subText
        subLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subLabel.textColor = .gray
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        
        button.addSubview(stack)
        stack.centerInSuperview()
        
        return button
    }
}


