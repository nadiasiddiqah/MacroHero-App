//
//  ProteinViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import UIKit
import Foundation
import Gifu
import Inject

class ProteinVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var cellData = [TwoLabelCellModel]()
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewData()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "What's the scoop on your protein shake?",
            type: .onboardingView,
            numberOfLines: 2))
        
        return label
    }()
    
    lazy var proteinShakeGif: GIFImageView = {
        let gifIV = GIFImageView()
        gifIV.animate(withGIFNamed: "proteinShakeGif")
        gifIV.contentMode = .scaleAspectFit
        
        return gifIV
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LabelTextFieldCell.self, forCellReuseIdentifier: "proteinDetailsCell")
        
        tableView.backgroundColor = Color.customYellow
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        
        tableView.rowHeight = (screenHeight * 0.3) / 4
        tableView.contentInset.top = 10
        tableView.contentInset.bottom = 10
        
        return tableView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_25
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        button.addShadowEffect(type: .ctaButton)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNext() {
        goToTabViews()
    }

    // MARK: - HELPER FUNCTIONS
    func setTableViewData() {
        cellData = [
            TwoLabelCellModel(title: "Calories", value: ""),
            TwoLabelCellModel(title: "Carbs", value: ""),
            TwoLabelCellModel(title: "Protein", value: ""),
            TwoLabelCellModel(title: "Fat", value: "")
        ]
    }
    
    func createMealPlanNC() -> UINavigationController {
        let vc = Inject.ViewControllerHost(MealPlanTabVC())
        let tabImage = UIImage(systemName: "note.text")
        vc.tabBarItem = UITabBarItem(title: "Meal Plan", image: tabImage, tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let vc = Inject.ViewControllerHost(FavoritesTabVC())
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createProfileNC() -> UINavigationController {
        let vc = Inject.ViewControllerHost(ProfileTabVC())
        let tabImage = UIImage(systemName: "person.circle")
        vc.tabBarItem = UITabBarItem(title: "Profile", image: tabImage, tag: 2)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMealPlanNC(), createFavoritesNC(), createProfileNC()]
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = Color.customNavy
        tabBarAppearance.backgroundColor = Color.customYellow
        
        tabBar.modalPresentationStyle = .fullScreen
        
        return tabBar
    }
    
    // MARK: - NAV METHODS
    func goToTabViews() {
        present(createTabBarController(), animated: false)
    }
}

extension ProteinVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proteinDetailsCell") as! LabelTextFieldCell
        
        let rowData = cellData[indexPath.row]
        cell.configure(with: TwoLabelCellModel(title: rowData.title,
                                            value: rowData.value))
        
        cell.backgroundColor = Color.customYellow
        
        return cell
    }
}

extension ProteinVC {

    func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addSubviews()
        autoLayoutViews()
        constrainSubviews()
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
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(tableView)
        view.addSubview(proteinShakeGif)
        view.addSubview(nextButton)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        proteinShakeGif.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainSubviews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            proteinShakeGif.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            proteinShakeGif.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * -0.03),
            proteinShakeGif.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            proteinShakeGif.heightAnchor.constraint(equalTo: proteinShakeGif.widthAnchor, multiplier: 0.62)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: proteinShakeGif.bottomAnchor, constant: screenHeight * 0.03),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: screenHeight * -0.09),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.16)
        ])
    }
}

// MARK: - Text Field Delegate Methods
//extension ProteinVC: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if let text = textField.text, !text.isEmpty {
//            if carbsTextField == textField || proteinTextField == textField || fatTextField == textField {
//                textField.text?.removeLast()
//            }
//        }
//
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = textField.text, !text.isEmpty {
//            if calTextField == textField {
//                proteinData.macros?.calories = text
//            } else if carbsTextField == textField {
//                carbsTextField.text = "\(text)g"
//                proteinData.macros?.carbs = text
//            } else if proteinTextField == textField {
//                proteinTextField.text = "\(text)g"
//                proteinData.macros?.protein = text
//            } else if fatTextField == textField {
//                fatTextField.text = "\(text)g"
//                proteinData.macros?.fat = text
//            }
//        }
//
//        print(proteinData)
//    }
//
//    func areTextFieldsValid() {
//        if let calories = calTextField.text, let carbs = carbsTextField.text,
//           let protein = proteinTextField.text, let fat = fatTextField.text {
//            guard !calories.isEmpty || !protein.isEmpty || !carbs.isEmpty || !fat.isEmpty else {
//                nextButton.isEnabled = false
//                return
//            }
//        }
//    }
//
//    func gestureToHideKeyboard() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func hideKeyboard() {
//        view.endEditing(true)
//    }
//}

