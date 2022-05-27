//
//  UIView+Ext.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import Foundation
import UIKit

extension UIView {
    enum ViewType {
        case ctaButton
        case normalButton
    }
    
    func addShadowEffect(type: ViewType) {
        if type == ViewType.ctaButton {
            self.layer.shadowColor = UIColor.systemGray.cgColor
        } else {
            self.layer.shadowColor = Color.buttonShadow?.cgColor
        }
        
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
