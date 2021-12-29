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

public func createDropDown(dropDown: DropDown, dataSource: [String], anchorView: UIView, halfWidth: Bool? = nil) {
    dropDown.dataSource = dataSource

    if halfWidth != nil {
        dropDown.width = anchorView.frame.width / 2
    }
    dropDown.anchorView = anchorView
    dropDown.direction = .bottom
    dropDown.cornerRadius = 18

    dropDown.backgroundColor = UIColor(named: "bgColor")
    dropDown.textColor = UIColor(named: "orange")!
    dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
        cell.optionLabel.textAlignment = .center
    }

    dropDown.selectionBackgroundColor = UIColor(named: "orange")!
    dropDown.selectedTextColor = UIColor(named: "bgColor")!

    dropDown.show()
    dropDown.dismissMode = .onTap
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
}

