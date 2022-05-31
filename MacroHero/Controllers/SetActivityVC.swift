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
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    lazy var topStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [mainTitle, firstButton, secondButton,
                                                   thirdButton, fourthButton])
        stack.axis = .vertical
        stack.spacing = screenHeight * 0.03
        
        return stack
    }()
    
    lazy var bottomImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoStrong)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    
    // MARK: - TAP METHODS
    #warning("TODO: store selection in user object")
    #warning("TODO: add selection/deselection properties")
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
        view.addSubview(topStack)
        view.addSubview(bottomImage)
    }
    
    fileprivate func autoLayoutViews() {
        topStack.translatesAutoresizingMaskIntoConstraints = false
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            topStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: screenHeight * 0.01),
            topStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            bottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomImage.topAnchor.constraint(greaterThanOrEqualTo: topStack.bottomAnchor, constant: screenHeight * 0.03),
            bottomImage.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: screenHeight * -0.04),
            bottomImage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}
