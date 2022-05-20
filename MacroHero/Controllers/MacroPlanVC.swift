//
//  MacroPlanVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/20/22.
//

import UIKit

class MacroPlanVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // Add main title
    lazy var mainTitle: UILabel = {
        var label = UILabel()
        label.text = "Here's your plan"
        label.font = Fonts.solid_30
        label.textColor = Color.customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    // Stack view
    // Add circle with calories in the middle
    
    // Stack view
    // Add carbs - %, g, and title
    // Add protein -
    // Add fat -
    
    // MARK: - TAP METHODS
}

extension MacroPlanVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        constrainViews()
    }
    
    fileprivate func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBack))
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addViews() {
        view.addSubview(mainTitle)
    }
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        mainTitle.width(screenWidth * 0.9)
    }
}
