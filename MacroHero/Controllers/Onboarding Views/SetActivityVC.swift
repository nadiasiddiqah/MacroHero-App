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
    
    private var userData: UserData
    
    // MARK: - INITIALIZER
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userData)
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "Select activity level", type: .onboardingView))
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
        
        NSLayoutConstraint.activate([
            mainTitle.heightAnchor.constraint(equalTo: mainTitle.widthAnchor, multiplier: 0.14)
        ])
        
        let buttons = [firstButton, secondButton, thirdButton, fourthButton]
        buttons.forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 0.15)
            ])
        }
        
        return stack
    }()
    
    lazy var bottomImage: UIImageView = {
        let imageView = UIImageView(image: Image.theoStrong)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    
    // MARK: - TAP METHODS
    
    // TODO: add selection/deselection properties
    func didTapFirst() {
        goToNextScreen(Activity.noExercise)
    }
    
    func didTapSecond() {
        goToNextScreen(Activity.lightExercise)
    }
    
    func didTapThird() {
        goToNextScreen(Activity.moderateExercise)
    }
    
    func didTapFourth() {
        goToNextScreen(Activity.hardExercise)
    }
    
    // MARK: - NAV METHODS
    func goToNextScreen(_ selection: Activity) {
        userData.activityLevel = selection
        let vc = Inject.ViewControllerHost(AboutYouVC(userData: self.userData))
        navigationController?.pushViewController(vc, animated: true)
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
            topStack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: screenHeight * 0.01),
            topStack.widthAnchor.constraint(
                equalTo: view.widthAnchor,     
                multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            bottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomImage.topAnchor.constraint(
                greaterThanOrEqualTo: topStack.bottomAnchor,
                constant: screenHeight * 0.03),
            bottomImage.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: screenHeight * -0.04),
            bottomImage.widthAnchor.constraint(
                lessThanOrEqualTo: view.widthAnchor,
                multiplier: 0.8)
        ])
    }
}
