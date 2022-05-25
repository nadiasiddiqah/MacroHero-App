//
//  MacroDetailView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/25/22.
//

import UIKit

struct MacroDetailModel {
    var label: String
    var color: UIColor
}

final class MacroDetailView: UIView {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW OBJECTS
    var iv = UIImageView(image: Image.planViewBg)
    var stackView = UIStackView()
    var percent = "31%"
    var grams = "30g"
    var label = "Carbs"
    
    // MARK: - VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - HELPER METHODS
    func configure(with model: MacroDetailModel) {
        
    }
    
    private func setupViews() {
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.29,
                                   height: screenHeight * 0.15)
        iv.contentMode = .scaleAspectFit
        iv.addShadowEffect()
        
        
    }
    
    private func addViews() {
        addSubview(iv)
    }
}

