//
//  MealCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/8/22.
//

import Foundation
import UIKit
import PKHUD

class MealCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    var typeLabel = UILabel()
    var nameLabel = UILabel()
    var imageIV = UIImageView()
    
    var calLabel = UILabel()
    var carbLabel = UILabel()
    var proteinLabel = UILabel()
    var fatLabel = UILabel()
    
    var refreshButton = UIButton()
    
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
        
        typeLabel.font = Fonts.solid_30
        typeLabel.textColor = Color.customOrange
        typeLabel.width(gridWidth)
        typeLabel.adjustsFontSizeToFitWidth = true
        
        nameLabel.font = Fonts.solid_20
        nameLabel.textColor = Color.customNavy
        nameLabel.width(gridWidth)
        nameLabel.lineBreakStrategy = []
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        
        let titleVStack = Utils.createVStack(subviews: [typeLabel, nameLabel],
                                             spacing: screenHeight * 0.001)
        
        return titleVStack
    }()
    
    lazy var macroVStack: UIStackView = {
        let cal = createMacroHStack(macro: "Calories", valueLabel: calLabel)
        let carbs = createMacroHStack(macro: "Carbs", valueLabel: carbLabel)
        let protein = createMacroHStack(macro: "Protein", valueLabel: proteinLabel)
        let fat = createMacroHStack(macro: "Fat", valueLabel: fatLabel)
        
        let macroVStack = Utils.createVStack(subviews: [cal, carbs, protein, fat],
                                             spacing: screenHeight * 0.006)
        
        return macroVStack
    }()
    
    // MARK: - SETUP FUNCTIONS
    func setupView() {
        addSubview(titleVStack)
        addSubview(imageIV)
        addSubview(macroVStack)
        addSubview(refreshButton)
        
        setupImageIV()
        setupRefreshButton()
        
        addConstraints()
    }
    
    func setupImageIV() {
        
        imageIV.width(screenWidth * 0.45)
        imageIV.aspectRatio(1.63)
        imageIV.frame = CGRect(x: 0, y: 0,
                               width: screenWidth * 0.45,
                               height: screenHeight * 0.15)
    }
    
    func setupRefreshButton() {
        refreshButton.setBackgroundImage(Image.refreshButton, for: .normal)
        refreshButton.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        refreshButton.tintColor = Color.customOrange
        refreshButton.width(screenWidth * 0.07)
        refreshButton.aspectRatio(1)
    }
    
    // MARK: - TAP FUNCTIONS
    @objc func didTapRefresh() {
        print("refresh")
//        HUD.show(.progress)
//        HUD.dimsBackground = true
        //        viewModel.fetchMealBasedOn(req: viewModel.breakfastReq) { mealInfo in
        //            self.viewModel.mealPlan.breakfast = mealInfo
        //            DispatchQueue.main.async {
        //                HUD.hide(animated: true) { _ in
        //                    HUD.dimsBackground = false
        //                }
        //            }
        //        }
    }
    
    // MARK: - HELPER FUNCTIONS
    func createMacroHStack(macro: String, valueLabel: UILabel) -> UIStackView {
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = Color.customBlue
        macroLabel.font = Fonts.solid_15
        macroLabel.adjustsFontSizeToFitWidth = true
        
        valueLabel.textColor = Color.customBlue
        valueLabel.font = Fonts.solid_15
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
        
        macroVStack.topToBottom(of: titleVStack, offset: screenHeight * 0.01)
        macroVStack.leftToRight(of: imageIV, offset: screenWidth * 0.025)
        macroVStack.width(screenWidth * 0.33)
        
        refreshButton.topToBottom(of: titleVStack, offset: screenHeight * 0.05)
        refreshButton.leftToRight(of: macroVStack, offset: screenWidth * 0.025)
    }
}
