//
//  CTAButton.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/23/22.
//

import UIKit

struct CTAButtonModel {
    var name: String
    var backgroundColor: UIColor?
    var borderColor: CGColor?
    var action: () -> Void
}

class CTAButton: UIButton {

    // MARK: - PROPERTIES
    var action: (() -> Void)?
    
    // MARK: - VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TAP METHODS
    @objc func handleTap(_ sender: Any) {
        action?()
    }
    
    // MARK: - HELPER METHODS
    func configure(with model: CTAButtonModel) {
        setTitle(model.name, for: .normal)
        backgroundColor = model.backgroundColor
        layer.borderColor = model.borderColor
        
        if let borderColor = model.borderColor {
            layer.borderColor = borderColor
            layer.borderWidth = 1.0
            setTitleColor(Color.ctaButtonColor, for: .normal)
        } else {
            setTitleColor(UIColor.white, for: .normal)
//            addShadowEffect(type: .ctaButton)
        }
        
        action = model.action
    }

    func setupButton() {
        titleLabel?.font = Font.solid_25
        layer.cornerRadius = 14
        addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
    }
}
