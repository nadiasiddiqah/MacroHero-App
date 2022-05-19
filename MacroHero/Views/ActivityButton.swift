//
//  ActivityButton.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import UIKit

struct ActivityButtonVM {
    let text: String
    let subText: String
}

// Note: Final cannot be subclassed
#warning("Continue to set up ActivityButton: https://youtu.be/2ApnvSzf6Xo?t=368")
final class ActivityButton: UIButton {
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ActivityButtonVM) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
