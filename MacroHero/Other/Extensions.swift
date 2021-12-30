//
//  Extensions.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import Foundation
import UIKit
import DropDown

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

public func createDropDown(dropDown: DropDown, dataSource: [String], anchorView: UIView, halfWidth: Bool? = nil, screen: String) {
    dropDown.dataSource = dataSource

    if halfWidth != nil {
        dropDown.width = anchorView.frame.width / 2
    }
    dropDown.anchorView = anchorView
    dropDown.direction = .bottom
    
    if screen == "info" {
        dropDown.cornerRadius = 18
        dropDown.backgroundColor = UIColor.bgColor
        dropDown.textColor = UIColor.customOrange!
        dropDown.selectionBackgroundColor = UIColor.customOrange!
        dropDown.selectedTextColor = UIColor.bgColor!
    } else if screen == "rank" {
        dropDown.cornerRadius = 8
        dropDown.backgroundColor = UIColor.white
        dropDown.textColor = UIColor.customDarkGray!
        dropDown.selectionBackgroundColor = UIColor.blueSelectedBg!
        dropDown.selectedTextColor = UIColor.blueSelectedText!
    }

    dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
        if screen == "info" {
            cell.optionLabel.textAlignment = .center
        } else if screen == "rank" {
            cell.optionLabel.textAlignment = .left
            cell.optionLabel.leftToSuperview(offset: screenWidth * 0.04)
        }
    }

    dropDown.show()
}

public func createAspectFitImage(imageName: String, width: CGFloat? = nil, height: CGFloat? = nil) -> UIImageView {
    let image = UIImageView(image: UIImage(named: imageName))
    if let width = width, let height = height {
        image.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    image.contentMode = .scaleAspectFit
    
    return image
}

public func createVStack(subviews: [UIView], width: CGFloat? = nil,
                         height: CGFloat? = nil, spacing: CGFloat) -> UIStackView {
    let VStack = UIStackView(arrangedSubviews: subviews)
    if let width = width, let height = height {
    VStack.frame = CGRect(x: 0, y: 0,
                          width: width,
                          height: height)
    }

    VStack.axis = .vertical
    VStack.spacing = spacing

    return VStack
}

public func setNavigationBar(navController: UINavigationController?, navItem: UINavigationItem,
                      leftBarButtonItem: UIBarButtonItem) {
    let bar = navController?.navigationBar
    bar?.standardAppearance.backgroundColor = UIColor(named: "navColor")
    bar?.tintColor = UIColor(named: "buttonTint")
    
    
    let title = UIImageView(image: UIImage(named: "macrohero"))
    navItem.titleView = title
    
    navItem.leftBarButtonItem = leftBarButtonItem
    navItem.hidesBackButton = true
}

public func createMainTitle(text: String, width: CGFloat? = nil, noOfLines: Int? = nil) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont(name: "KGHAPPYSolid", size: 25)
    label.textColor = UIColor(named: "orange")
    
    if let width = width {
        label.width(width)
    }
    
    if let noOfLines = noOfLines {
        label.numberOfLines = noOfLines
    }
    
    label.adjustsFontSizeToFitWidth = true
    
    return label
}

extension UIColor {
    static let bgColor = UIColor(named: "bgColor")
    static let customBlue = UIColor(named: "blue")
    static let customGray = UIColor(named: "gray")
    static let customDarkGray = UIColor(named: "darkGray")
    static let customOrange = UIColor(named: "orange")
    static let blueSelectedText = UIColor(named: "blueSelectedText")
    static let blueSelectedBg = UIColor(named: "blueSelectedBg")
}


