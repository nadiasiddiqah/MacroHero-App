//
//  MacroDetailView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/25/22.
//

import UIKit

final class VerticalMacroView: UIView {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW OBJECTS
    lazy var bgView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.addShadowEffect(type: .normalButton)
        
        return view
    }()
    
    lazy var label1: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var label2: UILabel = {
        var label = UILabel()
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
    func configure(with model: VerticalMacroModel) {
        bgView.backgroundColor = model.bgColor ?? Color.customYellow
        
        label1.text = model.percent
        label1.textColor = model.percentColor
        
        label2.text = model.grams
        label2.font = model.gramsFont ?? Font.solid_25
        
        label3.text = model.label
    }
}

extension VerticalMacroView {
    func setupViews() {
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    func addViews() {
        addSubview(bgView)
        bgView.addSubview(labelStack)
    }
    
    func autoLayoutViews() {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainViews() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            bgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bgView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
        ])
    }
}
