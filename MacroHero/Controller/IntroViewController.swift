//
//  IntroViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 10/5/21.
//

import UIKit
import TinyConstraints
import Gifu

class IntroViewController: UIViewController {
    
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
    
    // MARK: - VIEW VARIABLES
    lazy var textBubble: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "textBubble"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var macroManGif: GIFImageView = {
        let gifImageView = GIFImageView()
        gifImageView.animate(withGIFNamed: "macroManGif")
        
        return gifImageView
    }()
    
    lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "startButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapStart() {
        let infoVC = InfoViewController()
        navigationController?.pushViewController(infoVC, animated: true)
        // Adds infoVC to navVC stack
//        let navVC = UINavigationController(rootViewController: infoVC)
//        navVC.modalPresentationStyle = .fullScreen
//
//        present(navVC, animated: true)
    }

}
