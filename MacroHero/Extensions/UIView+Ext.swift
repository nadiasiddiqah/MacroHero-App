//
//  UIView+Ext.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import Foundation
import UIKit

extension UIView {
    func addShadowEffect() {
        self.layer.shadowColor = Color.buttonShadow?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
