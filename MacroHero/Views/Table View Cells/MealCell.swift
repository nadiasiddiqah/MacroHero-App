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

class MealCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
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
    
    // MARK: - VIEW OBJECTS
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.customYellow
        view.layer.cornerRadius = 20
        view.addShadowEffect(type: .normalButton)
        
        return view
    }()
    
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
        label.numberOfLines = 2
        label.lineBreakStrategy = []
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, nameLabel])
        stack.axis = .vertical

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: stack.leftAnchor),
            typeLabel.rightAnchor.constraint(equalTo: stack.rightAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: stack.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: stack.rightAnchor)
        ])

        return stack
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.refreshButton, for: .normal)
        button.addTarget(self, action: #selector(didTapRefresh(_:)), for: .touchUpInside)
        button.tintColor = Color.customOrange
        
        return button
    }()
    
    lazy var macroStack: UIStackView = {
        let cal = createMacroHStack("Calories", calLabel)
        let carbs = createMacroHStack("Carbs", carbLabel)
        let protein = createMacroHStack("Protein", proteinLabel)
        let fat = createMacroHStack("Fat", fatLabel)
        
        let finalStack = UIStackView(arrangedSubviews: [cal, carbs, protein, fat])
        finalStack.axis = .vertical
        finalStack.distribution = .fillEqually
        
        return finalStack
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    lazy var bottomStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iv, macroStack])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = screenHeight * 0.02
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: stack.topAnchor),
            iv.leftAnchor.constraint(equalTo: stack.leftAnchor),
            iv.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.55),
            iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 0.6),
            iv.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            macroStack.topAnchor.constraint(equalTo: stack.topAnchor),
            macroStack.rightAnchor.constraint(equalTo: stack.rightAnchor),
            macroStack.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
        
        return stack
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
    
    func createMacroHStack(_ macro: String, _ label2: UILabel) -> UIStackView {
        let label1 = UILabel()
        label1.text = macro
        label1.textAlignment = .left
        label1.translatesAutoresizingMaskIntoConstraints = false
        
        label2.textColor = .systemGray
        label2.textAlignment = .right
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [label1, label2])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
}

extension MealCell {
    func setupView() {
        addSubviews()
        autoLayoutViews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleStack)
        bgView.addSubview(bottomStack)
        bgView.addSubview(refreshButton)
    }
    
    func autoLayoutViews() {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: screenHeight * -0.03)
        ])
        
        NSLayoutConstraint.activate([
            titleStack.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            titleStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.01),
            titleStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.015),
            refreshButton.rightAnchor.constraint(equalTo: titleStack.rightAnchor),
            refreshButton.heightAnchor.constraint(equalTo: typeLabel.heightAnchor, multiplier: 0.75),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            bottomStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: screenHeight * 0.01),
            bottomStack.widthAnchor.constraint(equalTo: titleStack.widthAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: screenHeight * -0.02)
        ])
    }
}
