//
//  MainLabel.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/24/22.
//

import UIKit

final class MainLabel: UILabel {

    // MARK: - VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MainLabelModel) {
        text = model.title
        numberOfLines = model.numberOfLines ?? 1
        if model.type == MainLabelType.onboardingView {
            font = Font.solid_30
            textColor = Color.customOrange
            textAlignment = .center
        } else {
            font = Font.shadow_28
            textColor = model.textColor ?? Color.customNavy
        }
        adjustsFontSizeToFitWidth = true
    }
}
