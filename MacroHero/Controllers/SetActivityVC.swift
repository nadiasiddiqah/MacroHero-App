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
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.noButton, for: .normal)
        button.addTarget(self, action: #selector(didTapFirst), for: .touchUpInside)
        
        return button
    }()

    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.lightButton, for: .normal)
        button.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
        
        return button
    }()

    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.moderateButton, for: .normal)
        button.addTarget(self, action: #selector(didTapThird), for: .touchUpInside)
        
        return button
    }()

    lazy var fourthButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Image.hardButton, for: .normal)
        button.addTarget(self, action: #selector(didTapFourth), for: .touchUpInside)
        
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
        secondButton.topToBottom(of: firstButton, offset: screenHeight * 0.025)
        secondButton.width(screenWidth * 0.9)
        
        thirdButton.centerXToSuperview()
        thirdButton.topToBottom(of: secondButton, offset: screenHeight * 0.025)
        thirdButton.width(screenWidth * 0.9)
        
        fourthButton.centerXToSuperview()
        fourthButton.topToBottom(of: thirdButton, offset: screenHeight * 0.025)
        fourthButton.width(screenWidth * 0.9)
        
        lowerImage.centerXToSuperview()
        lowerImage.topToBottom(of: fourthButton, offset: screenHeight * 0.04)
        lowerImage.width(screenWidth * 0.8)
    }
}

#warning("FAIL: tried to use attributes to stack two lines in a button")
//let string = "No Exercise no exercise or very infrequent"
//
//let attributedString = NSMutableAttributedString(string: string)
//let firstAttributes: [NSAttributedString.Key: Any] = [
//    .foregroundColor: UIColor.black,
//    .font: UIFont.systemFont(ofSize: 17, weight: .bold)
//]
//let secondAttributes: [NSAttributedString.Key: Any] = [
//    .foregroundColor: UIColor.gray,
//    .font: UIFont.systemFont(ofSize: 10, weight: .regular)
//]
//
//attributedString.addAttributes(firstAttributes,
//                               range: NSRange(location: 0, length: 12))
//attributedString.addAttributes(secondAttributes,
//                               range: NSRange(location: 12, length: attributedString.length - 12))
//button.setAttributedTitle(attributedString, for: .normal)

#warning("FAIL: tried to use two labels to stack two lines in a button")
//extension UIButton {
//    func addTwoLines(lineOne: String, lineTwo: String) {
//        let label1 = UILabel(frame: CGRect(x: 0, y: self.frame.size.height / 4,
//                                           width: self.frame.size.width,
//                                           height: self.frame.size.height / 4))
//        label1.text = lineOne
//        label1.textColor = .black
//        label1.font = UIFont.systemFont(ofSize: 17, weight: .bold)
//        label1.textAlignment = .center
//
//        let label2 = UILabel(frame: CGRect(x: 0, y: self.frame.size.height * 2,
//                                           width: self.frame.size.width,
//                                           height: self.frame.size.height / 4))
//        label2.text = lineTwo
//        label2.textColor = .gray
//        label2.font = UIFont.systemFont(ofSize: 10, weight: .regular)
//        label2.textAlignment = .center
//
//        self.addSubview(label1)
//        self.insertSubview(label2, belowSubview: label1)
//    }
//}
