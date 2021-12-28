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

extension UIColor {
    static let bgColor = UIColor(named: "bgColor")
    static let customBlue = UIColor(named: "blue")
    static let customGray = UIColor(named: "gray")
}

