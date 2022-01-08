//
//  MealDetailsView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import Foundation
import UIKit

extension MealDetailsViewController {
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    fileprivate func constrainSubviews() {
        scrollView.edgesToSuperview()
        
        contentView.topToSuperview(offset: screenHeight * 0.04)
        contentView.centerXToSuperview()
        contentView.bottomToSuperview()
        contentView.width(screenWidth * 0.8)
    }

}
