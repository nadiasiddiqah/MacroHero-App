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

class IntroVC: UIViewController {
    
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
    lazy var textBubble: UIImageView = {
        let imageView = UIImageView(image: Image.textBubble)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var macroManGif: GIFImageView = {
        let gifImageView = GIFImageView()
        gifImageView.animate(withGIFNamed: "macroManGif")
        
        return gifImageView
    }()
    
    lazy var logo: UIImageView = {
        let imageView = UIImageView(image: Image.logo)
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
        let infoVC = InfoVC(viewModel: .init())
        navigationController?.pushViewController(infoVC, animated: true)
    }
}

extension IntroVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        constrainSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(textBubble)
        view.addSubview(macroManGif)
        view.addSubview(logo)
        view.addSubview(startButton)
    }
    
    fileprivate func constrainSubviews() {
        textBubble.topToSuperview(offset: screenHeight * 0.15)
        textBubble.rightToSuperview(offset: screenWidth * -0.06)
        textBubble.width(screenWidth * 0.3)
        textBubble.height(screenHeight * 0.12)
        
        macroManGif.centerXToSuperview()
        macroManGif.topToBottom(of: textBubble, offset: screenHeight * -0.02)
        macroManGif.width(screenWidth * 0.93)
        macroManGif.height(screenHeight * 0.3)
        
        logo.centerXToSuperview()
        logo.topToBottom(of: macroManGif, offset: screenHeight * -0.03)
        logo.width(screenWidth * 0.86)
        logo.height(screenHeight * 0.17)
        
        startButton.centerXToSuperview()
        startButton.topToSuperview(offset: screenHeight * 0.82)
        startButton.width(screenWidth * 0.36)
        startButton.height(screenHeight * 0.06)
    }
}
