//
//  MacroCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/8/22.
//

import UIKit

class MacroCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()

    // MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW OBJECTS
    lazy var stackView: UIStackView = {
        var labels = [leftLabel, rightLabel]
        leftLabel.textColor = .black
        leftLabel.textAlignment = .left
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rightLabel.textColor = .gray
        rightLabel.textAlignment = .center
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .horizontal
        stack.distribution = .fill
        
        return stack
    }()

    func setupView() {
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: screenWidth * 0.85 * 0.09)
        ])
    }
}
