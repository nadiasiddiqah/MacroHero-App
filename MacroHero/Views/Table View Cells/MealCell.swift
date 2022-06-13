//
//  MealCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/8/22.
//

import Foundation
import UIKit
import AlamofireImage
import PKHUD

struct MealCellModel {
    var mealInfo: MealInfo
    var refreshAction: () -> Void
}

class MealCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    var iv = UIImageView()
    var refreshAction: (() -> Void)?
    
    var calLabel = UILabel()
    var carbLabel = UILabel()
    var proteinLabel = UILabel()
    var fatLabel = UILabel()
    
    // MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: screenHeight * 0.03, right: 0))
//    }
    
    // MARK: - VIEW OBJECTS
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.solid_25
        label.textColor = Color.customOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.solid_17
        label.textColor = Color.customNavy
        label.lineBreakStrategy = []
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, nameLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = true
        
        return stack
    }()
    
    lazy var fullStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, iv])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.01
        
        return stack
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
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.refreshButton, for: .normal)
        button.addTarget(self, action: #selector(didTapRefresh(_:)), for: .touchUpInside)
        button.tintColor = Color.customOrange
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 10)
        
        return button
    }()
    
    // MARK: - TAP FUNCTIONS
    @objc func didTapRefresh(_ sender: Any) {
        refreshAction?()
    }
    
    // MARK: - HELPER FUNCTIONS
    func configure(with model: MealCellModel) {
        let mealData = model.mealInfo
        guard let type = mealData.type,
              let name = mealData.name,
              let image = mealData.image,
              let macros = mealData.macros else { return }
        
        typeLabel.text = type.capitalized
        if type == "Protein" {
            refreshButton.isHidden = true
        }
        
        nameLabel.text = name
        
        if let url = URL(string: image), image != "defaultMealImage" {
            let filter = AspectScaledToFillSizeFilter(size: iv.frame.size)
            iv.af.setImage(withURL: url, filter: filter)
        } else {
            iv.image = Image.defaultMealImage
        }
        
        calLabel.text = macros.calories
        carbLabel.text = "\(macros.carbs)g"
        proteinLabel.text = "\(macros.protein)g"
        fatLabel.text = "\(macros.fat)g"
        
        refreshAction = model.refreshAction
    }
    
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
}

extension MealCell {
    func setupView() {
        contentView.backgroundColor = Color.customYellow
        contentView.layer.cornerRadius = 20
        contentView.addShadowEffect(type: .normalButton)
        
        addSubviews()
        autoLayoutViews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleStack)
        contentView.addSubview(iv)
//        contentView.addSubview(macroVStack)
        contentView.addSubview(refreshButton)
    }
    
    func autoLayoutViews() {
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleStack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: screenHeight * 0.01),
            titleStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: screenHeight * 0.015),
            refreshButton.rightAnchor.constraint(equalTo: titleStack.rightAnchor),
            refreshButton.heightAnchor.constraint(equalTo: typeLabel.heightAnchor, multiplier: 0.8),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: screenHeight * 0.01),
            iv.leftAnchor.constraint(equalTo: titleStack.leftAnchor),
            iv.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 0.6),
            iv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: screenHeight * -0.02)
        ])
        
//        macroVStack.topToBottom(of: titleStack, offset: screenHeight * 0.01)
//        macroVStack.leftToRight(of: imageIV, offset: screenWidth * 0.025)
//        macroVStack.width(screenWidth * 0.33)
    }
}
