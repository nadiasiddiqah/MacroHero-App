//
//  MacroDetailView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/25/22.
//

import UIKit

struct MacroDetailModel {
    var percent, grams, label: String
    var percentColor: UIColor
}

final class MacroDetailView: UIView {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW OBJECTS
    lazy var iv: UIView = {
        var iv = UIImageView(image: Image.planViewBg)
        iv.contentMode = .scaleAspectFit
        iv.addShadowEffect(type: .normalButton)
        
        return iv
    }()
    
    lazy var label1: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var label2: UILabel = {
        var label = UILabel()
        label.font = Font.solid_25
        label.textColor = Color.customNavy
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var label3: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = Color.customDarkGray
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var labelStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [label1, label2, label3])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.01
        
        return stack
    }()
    
    // MARK: - VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - HELPER METHODS
    func configure(with model: MacroDetailModel) {
        label1.text = model.percent
        label2.text = model.grams
        label3.text = model.label
        label1.textColor = model.percentColor
    }
}

extension MacroDetailView {
    func setupViews() {
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    func addViews() {
        addSubview(iv)
        iv.addSubview(labelStack)
    }
    
    func autoLayoutViews() {
        iv.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainViews() {
        NSLayoutConstraint.activate([
            iv.centerXAnchor.constraint(equalTo: centerXAnchor),
            iv.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
        ])
    }
}
