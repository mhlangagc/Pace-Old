//
//  PasswordViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var buttonBottomAnchorConstraint: NSLayoutConstraint?
	var isShowingPaswword = false
	
	let passwordHeaderLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Create a password"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var passwordTextField: TextField = {
		
		let textField = TextField()
		textField.borderStyle = .none
		textField.keyboardType = .default
		textField.keyboardAppearance = .dark
		textField.isSecureTextEntry = true
		textField.autocapitalizationType = UITextAutocapitalizationType.none
		textField.backgroundColor = .black
		textField.textColor = UIColor.greyWhite()
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"atleast 6 characters (no spaces)",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
		textField.returnKeyType = .done
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()

	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("next", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor(fromHexString: "212833")
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = false
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	let showButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Show", for: UIControlState.normal)
		button.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		button.backgroundColor = UIColor.clear
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationNoLineBar()
		onboardingCounter(counterString: "2 of 5")
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		view.backgroundColor = UIColor.black
		
		self.setupViews()
		self.setupKeyboardObservers()
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
		
	}
	
	
	func setupViews() {
		
		view.addSubview(passwordHeaderLabel)
		passwordTextField.delegate = self
		view.addSubview(passwordTextField)
		view.addSubview(nextButton)
		
		view.addSubview(showButton)
		showButton.addTarget(self, action: #selector(handleShowPassword), for: UIControlEvents.touchUpInside)
		
		showButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		showButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		showButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
		showButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
		
		
		passwordHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		passwordHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		passwordHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		passwordHeaderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: passwordHeaderLabel.bottomAnchor, constant: 30).isActive = true
		passwordTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		buttonBottomAnchorConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
		buttonBottomAnchorConstraint?.isActive = true
		nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	func handleShowPassword() {
		
		if isShowingPaswword == false {
			
			passwordTextField.isSecureTextEntry = false
			showButton.setTitle("Hide", for: UIControlState.normal)
			isShowingPaswword = true
			
		} else {
			
			passwordTextField.isSecureTextEntry = true
			showButton.setTitle("Show", for: UIControlState.normal)
			isShowingPaswword = false
			
		}
		
	}
	
	
	func handleNext() {
		
		passwordTextField.resignFirstResponder()
		self.view.endEditing(true)
		
		//  TO DO - Login 
		
		self.navigationController?.pushViewController(NameEntryViewController(), animated: true)
	}
	
}


extension PasswordViewController {
	
	func setupKeyboardObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
	}
	
	
	
	
	func handleKeyboardNotification(notification: NSNotification) {
		
		let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
		
		UIView.animate(withDuration: 0.25) {
			
			if isKeyboardShowing == true {
				
				self.buttonBottomAnchorConstraint?.constant = -275
				
			} else {
				
				self.buttonBottomAnchorConstraint?.constant = -15
				
			}
			
			self.view.layoutIfNeeded()
		}
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		passwordTextField.resignFirstResponder()
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
		
	}
	
	
	func textFieldDidChange(textField: UITextField) {
		
		if (passwordTextField.text?.characters.count)! > 6 {
			
			nextButton.isEnabled = true
			nextButton.backgroundColor = UIColor(fromHexString: "00EA89")
			
		} else {
			
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor(fromHexString: "1C2026")
			
			
		}
		
	}

}
