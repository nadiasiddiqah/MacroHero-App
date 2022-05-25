//
//  SetActivityVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/17/22.
//

import UIKit
import Inject

class SetActivityVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: """
                   What's your activity
                   level?
                   """,
            numberOfLines: 2))
        
        return label
    }()
    
    lazy var firstButton: UIButton = {
        let button = TwoLineButton()
        button.configure(with: TwoLineButtonModel(
            title: "No Exercise",
            subTitle: "no exercise or very infrequent",
            action: didTapFirst))
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = TwoLineButton()
        button.configure(with: TwoLineButtonModel(
            title: "Light Exercise",
            subTitle: "some light cardio/weights a few times per week",
            action: didTapSecond))
        
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = TwoLineButton()
        button.configure(with: TwoLineButtonModel(
            title: "Moderate Exercise",
            subTitle: "lifting/cardio regularly but not super intense",
            action: didTapThird))
        
        return button
    }()
    
    lazy var fourthButton: UIButton = {
        let button = TwoLineButton()
        button.configure(with: TwoLineButtonModel(
            title: "Hard Exercise",
            subTitle: "most days per week involve demanding exercise",
            action: didTapFourth))
        
        return button
    }()
    
    lazy var lowerImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoStrong)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - TAP METHODS
    func didTapFirst() {
        print("Tapped 1")
        goToNextScreen()
    }
    
    func didTapSecond() {
        print("Tapped 2")
        goToNextScreen()
    }
    
    func didTapThird() {
        print("Tapped 3")
        goToNextScreen()
    }
    
    func didTapFourth() {
        print("Tapped 4")
        goToNextScreen()
    }
    
    // MARK: - HELPER METHODS
    func goToNextScreen() {
        let aboutYouVC = Inject.ViewControllerHost(AboutYouVC())
        navigationController?.pushViewController(aboutYouVC, animated: true)
    }
}

extension SetActivityVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
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
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(lowerImage)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        fourthButton.translatesAutoresizingMaskIntoConstraints = false
        lowerImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: 0.9),
            
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                             constant: screenHeight * 0.04),
            firstButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               multiplier: 0.9),
            
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor,
                                              constant: screenHeight * 0.035),
            secondButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.9),
            
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor,
                                             constant: screenHeight * 0.035),
            thirdButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               multiplier: 0.9),
            
            fourthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor,
                                              constant: screenHeight * 0.035),
            fourthButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.9),
            
            lowerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerImage.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: screenHeight * -0.05),
            lowerImage.widthAnchor.constraint(equalTo: view.widthAnchor,
                                              multiplier: 0.8),
        ])
    }
}
