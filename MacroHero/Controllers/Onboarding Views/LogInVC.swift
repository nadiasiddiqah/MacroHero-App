//
//  LogInVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/23/22.
//

import Foundation
import UIKit

class LogInVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: MainLabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(title: "Welcome back!",
                                             type: .onboardingView))
        return label
    }()
}

extension LogInVC {
    func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        constrainViews()
    }
    
    func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func addViews() {
        view.addSubview(mainTitle)
    }
    
    func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
