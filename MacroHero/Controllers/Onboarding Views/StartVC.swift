//
//  IntroViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import UIKit
import Gifu
import Inject

class StartVC: UIViewController {
    
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - VIEW VARIABLES
    lazy var introImage: UIImageView = {
        let imageView = UIImageView(image: Image.introImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_25
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        button.addShadowEffect(type: .ctaButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [introImage, startButton])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.12
        stack.alignment = .center
        
        return stack
    }()
    
    @objc func didTapStart() {
        let setGoalVC = Inject.ViewControllerHost(SetGoalVC())
        navigationController?.pushViewController(setGoalVC, animated: true)
    }
}

extension StartVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    fileprivate func addViews() {
        view.addSubview(stack)
    }
    
    fileprivate func autoLayoutViews() {
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            introImage.widthAnchor.constraint(
                equalTo: view.widthAnchor, multiplier: 0.9),
            startButton.widthAnchor.constraint(
                equalTo: view.widthAnchor, multiplier: 0.83),
            startButton.heightAnchor.constraint(
                equalTo: startButton.widthAnchor, multiplier: 0.16)
        ])
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
