//
//  IntroViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import UIKit
import TinyConstraints
import Gifu
import Combine
import Inject

class StartVC: UIViewController {
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
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

        return imageView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.startButton, for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        
        return button
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
        view.addSubview(introImage)
        view.addSubview(startButton)
    }
    
    fileprivate func autoLayoutViews() {
        introImage.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            introImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introImage.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.18),
            introImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: screenHeight * -0.15),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.82)
        ])
    }
}
