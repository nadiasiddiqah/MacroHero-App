//
//  InfoViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/6/21.
//

import UIKit
import DropDown

class InfoViewController: UIViewController {
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - TITLE
    lazy var mainTitle: UIImageView = {
        let image = createAspectFitImage(imageName: "letsplan:",
                                         width: screenWidth * 0.5,
                                         height: screenHeight * 0.06)

        return image
    }()

    // MARK: - AGE BUTTON
    lazy var ageButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.39,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(UIImage(named: "ageButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapAgeButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var ageLabel: UILabel = {
        var label = UILabel()
        label.text = "    yrs"
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "KGHAPPYSolid", size: 15)
        
        return label
    }()
    
    lazy var ageTextArea: UIImageView = {
        var image = UIImageView(image: UIImage(named: "ageTextArea"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var ageVStack: UIStackView = {
        let VStack = createVStack(subviews: [ageLabel, ageTextArea],
                                  width: ageButton.frame.width * 0.66,
                                  height: ageButton.frame.height * 0.33,
                                  spacing: ageButton.frame.height * -0.07)
    
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapAgeButton))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    // MARK: - HEIGHT BUTTON
    lazy var heightButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(UIImage(named: "heightButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapFtField), for: .touchUpInside)

        return button
    }()

    lazy var ftLabel: UILabel = {
        var label = UILabel()
        label.text = "  '"
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "KGHAPPYSolid", size: 15)

        return label
    }()

    lazy var ftTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "heightTextArea")
        
        return image
    }()
    
    lazy var inTextArea: UIImageView = {
        let image = createAspectFitImage(imageName: "heightTextArea")
        
        return image
    }()

    lazy var ftVStack: UIStackView = {
        let VStack = createVStack(subviews: [ftLabel, ftTextArea],
                                  width: heightButton.frame.width * 0.39,
                                  height: heightButton.frame.height * 0.3,
                                  spacing: heightButton.frame.height * -0.08)

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapFtField))
        VStack.addGestureRecognizer(tapGesture)

        return VStack
    }()
    
    lazy var inLabel: UILabel = {
        var label = UILabel()
        label.text = #"   ""#
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "KGHAPPYSolid", size: 15)

        return label
    }()
    
    lazy var inVStack: UIStackView = {
        let VStack = createVStack(subviews: [inLabel, inTextArea],
                                  width: heightButton.frame.width * 0.39,
                                  height: heightButton.frame.height * 0.3,
                                  spacing: heightButton.frame.height * -0.08)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapInField))
        VStack.addGestureRecognizer(tapGesture)

        return VStack
    }()
    
    lazy var heightHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [ftVStack, inVStack])
        
        HStack.axis = .horizontal
        HStack.spacing = heightButton.frame.width * 0.05

        return HStack
    }()
    
    lazy var heightWeightHStack: UIStackView = {
        let HStack = UIStackView(arrangedSubviews: [heightButton, weightButton])
        
        HStack.axis = .horizontal
        HStack.spacing = heightButton.frame.width * 0.06

        return HStack
    }()

    // MARK: - WEIGHT BUTTON
    lazy var weightButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(UIImage(named: "weightButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapWeightButton), for: .touchUpInside)

        return button
    }()
    
    lazy var weightLabel: UILabel = {
        var label = UILabel()
        label.text = "     lbs"
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "KGHAPPYSolid", size: 15)
        
        return label
    }()
    
    lazy var weightTextArea: UIImageView = {
        var image = UIImageView(image: UIImage(named: "ageTextArea"))
        image.frame = CGRect(x: 0, y: 0,
                             width: screenWidth * 0.65, height: screenHeight * 0.3)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var weightVStack: UIStackView = {
        let VStack = createVStack(subviews: [weightLabel, weightTextArea],
                                  width: weightButton.frame.width * 0.65,
                                  height: weightButton.frame.height * 0.3,
                                  spacing: ageButton.frame.height * -0.07)

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapWeightButton))
        VStack.addGestureRecognizer(tapGesture)

        return VStack
    }()

    @objc func didTapWeightButton() {
        let weightDropDown = DropDown()
        let weightData = Array(90...300).map { String($0) }
        
        createDropDown(dropDown: weightDropDown, dataSource: weightData, anchorView: weightButton, screen: "info")
        
        weightDropDown.bottomOffset = CGPoint(x: 0, y: weightButton.frame.size.height)
        weightDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - weightButton.frame.size.height

        weightDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.weightLabel.text = "\(item) lbs"
        }
    }

    // MARK: - ACTIVITY LEVEL BUTTON
    lazy var activityButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0,
                              width: screenWidth * 0.51,
                              height: screenHeight * 0.15)
        button.setBackgroundImage(UIImage(named: "activityButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapActivityButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var activityLabel: UILabel = {
        var label = UILabel()
        label.text = " "
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "KGHAPPYSolid", size: 15)
        
        return label
    }()
    
    lazy var activityTextArea: UIImageView = {
        var image = UIImageView(image: UIImage(named: "activityTextArea"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var activityVStack: UIStackView = {
        let VStack = createVStack(subviews: [activityLabel, activityTextArea],
                                  spacing: activityButton.frame.height * -0.08)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapActivityButton))
        VStack.addGestureRecognizer(tapGesture)
        
        return VStack
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "calculateButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
        
        return button
    }()

    lazy var allButtonsVStack: UIStackView = {
        let VStack = UIStackView(arrangedSubviews: [ageButton, heightWeightHStack,
                                                    activityButton, calculateButton])
        
        VStack.axis = .vertical
        VStack.spacing = screenHeight * 0.05

        return VStack
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapAgeButton() {
        let ageDropDown = DropDown()
        let ageData = Array(12...80).map { String($0) }
        
        createDropDown(dropDown: ageDropDown, dataSource: ageData, anchorView: ageButton, screen: "info")
        
        ageDropDown.bottomOffset = CGPoint(x: 0, y: ageButton.frame.size.height)
        ageDropDown.offsetFromWindowBottom = (screenHeight * 0.67) - ageButton.frame.size.height

        ageDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.ageLabel.text = "\(item) yrs"
        }
    }

    @objc func didTapFtField() {
        let ftDropDown = DropDown()
        let ftData = Array(4...7).map { String("\($0)'") }

        createDropDown(dropDown: ftDropDown, dataSource: ftData, anchorView: heightButton, halfWidth: true, screen: "info")
        
        ftDropDown.bottomOffset = CGPoint(x: 0, y: heightButton.frame.size.height)
        ftDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - heightButton.frame.size.height
        
        ftDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.ftLabel.text = "\(item)"
        }
    }
    
    @objc func didTapInField() {
        let inDropDown = DropDown()
        let inData = Array(0...11).map { String("\($0)\"") }
        
        createDropDown(dropDown: inDropDown, dataSource: inData, anchorView: heightButton, screen: "info")
        
        inDropDown.bottomOffset = CGPoint(x: heightButton.frame.size.width / 2, y: heightButton.frame.size.height)
        inDropDown.offsetFromWindowBottom = (screenHeight * 0.46) - heightButton.frame.size.height
        inDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.inLabel.text = "\(item)"
        }
    }
    
    @objc func didTapActivityButton() {
        let activityDropDown = DropDown()
        let activityData = ["Sedentary", "Lightly active", "Active", "Very active"]
        
        createDropDown(dropDown: activityDropDown, dataSource: activityData,
                       anchorView: activityButton, screen: "info")
        
        activityDropDown.bottomOffset = CGPoint(x: 0, y: activityButton.frame.size.height)
        
        activityDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.activityLabel.text = item
        }
    }
    
    @objc func didTapCalculateButton() {
        let planVC = PlanViewController()
        navigationController?.pushViewController(planVC, animated: true)
    }
}



