//
//  ProteinView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/29/21.
//

import Foundation
import UIKit

extension ProteinViewController {

    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
        gestureToHideKeyboard()
    }
    
    func setupDelegates() {
        calTextField.delegate = self
        carbsTextField.delegate = self
        proteinTextField.delegate = self
        fatTextField.delegate = self
    }

    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(proteinShakeGif)
        view.addSubview(macroVStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainSubviews() {
        mainTitle.topToSuperview(offset: screenHeight * 0.21)
        mainTitle.centerXToSuperview()
        
        proteinShakeGif.topToBottom(of: mainTitle)
        proteinShakeGif.centerXToSuperview()
        proteinShakeGif.width(screenWidth * 0.67)
        proteinShakeGif.height(screenHeight * 0.18)
        
        macroVStack.centerXToSuperview()
        macroVStack.topToBottom(of: proteinShakeGif, offset: screenHeight * 0.05)
        macroVStack.width(screenWidth * 0.65)
        macroVStack.height(screenHeight * 0.18)
        
        nextButton.centerXToSuperview()
        nextButton.bottomToSuperview(offset: screenHeight * -0.09)
    }
}

// MARK: - Text Field Delegate Methods
extension ProteinViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == calTextField {
            keyboardDistanceFromTextField = macroVStack.frame.height
            print(keyboardDistanceFromTextField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = calTextField.text {
            calValue = text
        } else if let text = carbsTextField.text {
            carbsValue = text
        } else if let text = proteinTextField.text {
            proteinValue = text
        } else if let text = fatTextField.text {
            fatValue = text
        }
        
        view.endEditing(true)
    }
    
    // Ends all editing
    func gestureToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Text View Delegate Methods
extension ProteinViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if calValue.isEmpty || carbsValue.isEmpty || proteinValue.isEmpty || fatValue.isEmpty {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
}
