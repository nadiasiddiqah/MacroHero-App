//
//  FavoriteMealCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 4/13/22.
//

import Foundation
import UIKit

class FavMealCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
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
        view.layer.cornerRadius = 12
        view.addShadowEffect(type: .normalButton)
        
        return view
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 100, height: 61.33)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.solid_15
        label.textColor = Color.customOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.solid_16
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
        
        return stack
    }()
    
    // MARK: - HELPER FUNCTIONS
    func configure(with model: MealCellModel) {
        let mealData = model.mealInfo
        guard let type = mealData.type,
              let name = mealData.name else { return }
        
        typeLabel.text = type.capitalized
        nameLabel.text = name
        
        if let image = mealData.image, image != Image.defaultMealImage {
            iv.image = mealData.image
        } else {
            iv.image = Image.defaultMealImage
        }
    }
}

extension FavMealCell {
    func setupView() {
        addSubviews()
        autoLayoutViews()
        addConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(bgView)
        bgView.addSubview(iv)
        bgView.addSubview(titleStack)
    }
    
    func autoLayoutViews() {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        titleStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: screenHeight * -0.03)
        ])
        
        NSLayoutConstraint.activate([
            iv.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            iv.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: screenHeight * 0.02),
            iv.widthAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 0.34),
            iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.015),
            titleStack.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: screenHeight * 0.01),
            titleStack.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: screenHeight * -0.02),
            titleStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: screenHeight * -0.015)
        ])
    }
}
