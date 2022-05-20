//
//  Extensions.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import Foundation
import UIKit
import DropDown

class Utils {
    static var keyboardDistanceFromTextField: CGFloat = 10
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static func createDropDown(dropDown: DropDown, dataSource: [String], anchorView: UIView,
                               halfWidth: Bool? = nil, screen: String) {
        dropDown.dataSource = dataSource

        if halfWidth != nil {
            dropDown.width = anchorView.frame.width / 2
        }
        dropDown.anchorView = anchorView
        dropDown.direction = .bottom
        
        if screen == "info" {
            dropDown.cornerRadius = 18
            dropDown.backgroundColor = Color.bgColor
            dropDown.textColor = Color.customOrange!
            dropDown.selectionBackgroundColor = Color.customOrange!
            dropDown.selectedTextColor = Color.bgColor!
        } else if screen == "rank" {
            dropDown.cornerRadius = 8
            dropDown.backgroundColor = UIColor.white
            dropDown.textColor = Color.customDarkGray!
            dropDown.selectionBackgroundColor = Color.blueSelectedBg!
            dropDown.selectedTextColor = Color.blueSelectedText!
        }

        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            if screen == "info" {
                cell.optionLabel.textAlignment = .center
            } else if screen == "rank" {
                cell.optionLabel.textAlignment = .left
                cell.optionLabel.leftToSuperview(offset: self.screenWidth * 0.04)
            }
        }

        dropDown.show()
    }

    static func createAspectFitImage(image: UIImage?, width: CGFloat? = nil, height: CGFloat? = nil) -> UIImageView {
        let image = UIImageView(image: image)
        if let width = width, let height = height {
            image.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
        image.contentMode = .scaleAspectFit
        
        return image
    }

    static func createVStack(subviews: [UIView], width: CGFloat? = nil,
                             height: CGFloat? = nil, spacing: CGFloat? = nil) -> UIStackView {
        let VStack = UIStackView(arrangedSubviews: subviews)
        if let width = width, let height = height {
            VStack.frame = CGRect(x: 0, y: 0,
                                  width: width,
                                  height: height)
        }
        
        if let spacing = spacing {
            VStack.spacing = spacing
        }

        VStack.axis = .vertical

        return VStack
    }

    static func createMainTitle(text: String,
                                textColor: UIColor? = nil,
                                noOfLines: Int? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        
        if textColor != nil {
            label.font = Fonts.shadow_30
            label.textColor = textColor
        } else {
            label.font = Fonts.solid_30
            label.textColor = Color.customOrange
        }
        
        if let noOfLines = noOfLines {
            label.numberOfLines = noOfLines
        }
        
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakStrategy = []
        
        return label
    }

    static func doubleToStr(_ double: Double) -> String {
        return "\(Int(round(double)))"
    }
}
