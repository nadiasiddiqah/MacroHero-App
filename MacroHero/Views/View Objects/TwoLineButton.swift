//
//  ActivityButton.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/18/22.
//

import UIKit

final class TwoLineButton: UIButton {
    // MARK: - PROPERTIES
    private var action: (() -> Void)?
    
    // MARK: - VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TAP METHODS
    @objc private func handleTap(_ sender: Any) {
        action?()
    }
    
    // MARK: - HELPER METHODS
    func configure(with model: TwoLineButtonModel) {
        setAttributedTitle(
            setupTwoLines(title: model.title,
                          subtitle: model.subTitle),
            for: .normal)
        action = model.action
    }
    
    private func setupView() {
        setBackgroundImage(Image.setButtonBg, for: .normal)
        titleLabel?.numberOfLines = 0
        addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        addShadowEffect(type: .normalButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTwoLines(
        title: String,
        subtitle: String
    ) -> NSAttributedString {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        let twoLines = [
            NSAttributedString(
                string: title + "\n",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                    .foregroundColor: UIColor.black,
                    .paragraphStyle: centeredParagraphStyle
                ]),
            NSAttributedString(
                string: subtitle,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: UIColor.gray,
                    .paragraphStyle: centeredParagraphStyle
                ])
        ]
        
        let string = NSMutableAttributedString()
        twoLines.forEach { string.append($0) }
        return string
    }
}
