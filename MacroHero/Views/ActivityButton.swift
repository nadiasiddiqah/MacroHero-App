//
//  ActivityButton.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import UIKit

struct ActivityButtonVM {
    let labelText: String
    let subLabelText: String
    let action: Selector
}

#warning("work in progress, stack view doesn't appear")
#warning("creating uicontrol class instead of uibutton class: https://www.youtube.com/watch?v=chj2ceZl51s&ab_channel=SamMeech-Ward")
// Note: Final cannot be subclassed
final class ActivityButton: UIButton {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setBackgroundImage(Image.setButtonBg, for: .normal)
        addShadowEffect()
        
        let stack = UIStackView(arrangedSubviews: [label, subLabel])
        stack.axis = .vertical
        stack.alignment = .center
        addSubview(stack)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ActivityButtonVM) {
        label.text = viewModel.labelText
        subLabel.text = viewModel.subLabelText
        self.addTarget(SetActivityVC(), action: viewModel.action,
                       for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
