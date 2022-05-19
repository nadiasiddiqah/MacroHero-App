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
        let text = """
        What's your activity
        level?
        """
        let title = Utils.createMainTitle(text: text, noOfLines: 2)
        title.textAlignment = .center
        
        return title
    }()
    
    #warning("change highlight color from gray to something else bc it hides gray text")
    lazy var firstButton: UIButton = {
        let button = UIButton.activityButton(action: #selector(didTapFirst),
                                             text: "No Exercise",
                                             subText: "no exercise or very infrequent")
        
        return button
    }()

    lazy var secondButton: UIButton = {
        let button = UIButton.activityButton(action: #selector(didTapFirst),
                                             text: "Light Exercise",
                                             subText: "some light cardio/weights a few times per week")
        
        return button
    }()

    lazy var thirdButton: UIButton = {
        let button = UIButton.activityButton(action: #selector(didTapFirst),
                                             text: "Moderate Exercise",
                                             subText: "lifting/cardio regularly but not super intense")
        
        return button
    }()

    lazy var fourthButton: UIButton = {
        let button = UIButton.activityButton(action: #selector(didTapFirst),
                                             text: "Hard Exercise",
                                             subText: "most days per week involve demanding exercise")
        
        return button
    }()

    lazy var lowerImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoStrong)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapFirst() {
        print("Tapped 1")
        goToNextScreen()
    }
    
    @objc func didTapSecond() {
        print("Tapped 2")
        goToNextScreen()
    }
    
    @objc func didTapThird() {
        print("Tapped 3")
        goToNextScreen()
    }
    
    @objc func didTapFourth() {
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
        Utils.setNavigationBar(navController: navigationController,
                               navItem: navigationItem, 
                               leftBarButtonItem: UIBarButtonItem(image: Image.backButton,
                                                                  style: .done, target: self,
                                                                  action: #selector(didTapBackButton)))
        addViews()
        constrainViews()
    }
    
    @objc func didTapBackButton(sender: UIBarButtonItem) {
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
    
    fileprivate func constrainViews() {
        mainTitle.centerXToSuperview()
        mainTitle.topToSuperview(offset: screenHeight * 0.12)
        mainTitle.width(screenWidth * 0.9)
        
        firstButton.centerXToSuperview()
        firstButton.topToBottom(of: mainTitle, offset: screenHeight * 0.04)
        firstButton.width(screenWidth * 0.9)
        
        secondButton.centerXToSuperview()
        secondButton.topToBottom(of: firstButton, offset: screenHeight * 0.03)
        secondButton.width(screenWidth * 0.9)
        
        thirdButton.centerXToSuperview()
        thirdButton.topToBottom(of: secondButton, offset: screenHeight * 0.03)
        thirdButton.width(screenWidth * 0.9)
        
        fourthButton.centerXToSuperview()
        fourthButton.topToBottom(of: thirdButton, offset: screenHeight * 0.03)
        fourthButton.width(screenWidth * 0.9)
        
        lowerImage.centerXToSuperview()
        lowerImage.topToBottom(of: fourthButton, offset: screenHeight * 0.06)
        lowerImage.width(screenWidth * 0.8)
    }
}
