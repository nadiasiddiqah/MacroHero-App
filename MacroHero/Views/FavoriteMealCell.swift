//
//  FavoriteMealCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 4/13/22.
//

import Foundation
import UIKit
import PKHUD

class FavoriteMealCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    var typeLabel = UILabel()
    var nameLabel = UILabel()
    var imageIV = UIImageView()
    
    // MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAZY VARIABLES
    lazy var titleVStack: UIStackView = {
        let gridWidth = screenWidth * 0.9
        
        typeLabel.font = Font.solid_30
        typeLabel.textColor = Color.customOrange
        typeLabel.width(gridWidth)
        typeLabel.adjustsFontSizeToFitWidth = true
        
        nameLabel.font = Font.solid_20
        nameLabel.textColor = Color.customNavy
        nameLabel.width(gridWidth)
        nameLabel.lineBreakStrategy = []
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        
        let titleVStack = Utils.createVStack(subviews: [typeLabel, nameLabel],
                                             spacing: screenHeight * 0.001)
        
        return titleVStack
    }()
    
    // MARK: - SETUP FUNCTIONS
    func setupView() {
        contentView.addSubview(titleVStack)
        contentView.addSubview(imageIV)
        
        setupImageIV()
        
        addConstraints()
    }
    
    func setupImageIV() {
        imageIV.frame = CGRect(x: 0, y: 0,
                               width: screenWidth * 0.45,
                               height: screenHeight * 0.15)
    }
    
    // MARK: - HELPER FUNCTIONS
    func createMacroHStack(macro: String, valueLabel: UILabel) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = Color.customBlue
        macroLabel.font = Font.solid_15
        macroLabel.adjustsFontSizeToFitWidth = true
        
        valueLabel.textColor = Color.customBlue
        valueLabel.font = Font.solid_15
        valueLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, valueLabel])
        macroHStack.width(screenWidth * 0.33)
        macroHStack.axis = .horizontal
        
        return macroHStack
    }

    func addConstraints() {
        titleVStack.topToSuperview()
        titleVStack.leftToSuperview()
        
        imageIV.leftToSuperview()
        imageIV.topToBottom(of: titleVStack, offset: screenHeight * 0.01)
        imageIV.bottomToSuperview(offset: screenHeight * -0.03)
        imageIV.width(screenWidth * 0.45)
        imageIV.aspectRatio(1.63)
    }
}
