//
//  ProteinDetailsCell.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/8/22.
//

import UIKit

class ProteinDetailsCell: UITableViewCell {

    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    var label = UILabel()
    var textField = UITextField()
    
    // MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - VIEW OBJECTS
    lazy var stackView: UIStackView = {
        var labels = [label, textField]
        label.textColor = .black
        label.textAlignment = .left
        
        textField.textColor = .gray
        textField.textAlignment = .center
        
        var stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .horizontal
        stack.distribution = .fill
        
        return stack
    }()

    func setupView() {
        contentView.addSubview(stackView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: screenWidth * 0.85 * 0.09)
        ])
    }

}
