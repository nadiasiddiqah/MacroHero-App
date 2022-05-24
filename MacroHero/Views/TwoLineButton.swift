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
        addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
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
        addShadowEffect()
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

//struct ActivityButtonVM {
//    let labelText: String
//    let subLabelText: String
//    let action: Selector
//}
//

//final class ActivityButton: UIButton {
//    private let label: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        label.textColor = .black
//
//        return label
//    }()
//
//    private let subLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        label.textColor = .gray
//
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setBackgroundImage(Image.setButtonBg, for: .normal)
//        addShadowEffect()
//
//        let stack = UIStackView(arrangedSubviews: [label, subLabel])
//        stack.axis = .vertical
//        stack.alignment = .center
//        addSubview(stack)
//        clipsToBounds = true
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(with viewModel: ActivityButtonVM) {
//        label.text = viewModel.labelText
//        subLabel.text = viewModel.subLabelText
//        self.addTarget(SetActivityVC(), action: viewModel.action,
//                       for: .touchUpInside)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
//}
