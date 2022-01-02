//
//  MealPlanView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/31/21.
//

import Foundation
import UIKit

extension MealPlanViewController {
    
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
        
    }
    
    fileprivate func constrainSubviews() {
        
    }
}
