//
//  LoginViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/30.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let headerLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Enter is your email"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var emailTextField: TextField = {
		
		let textField = TextField()
		textField.borderStyle = .none
		textField.keyboardType = .emailAddress
		textField.keyboardAppearance = .dark
		textField.autocapitalizationType = UITextAutocapitalizationType.none
		textField.backgroundColor = .black
		textField.textColor = UIColor.greyWhite()
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"email",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
		textField.returnKeyType = .done
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	
	let passwordHeaderLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Enter your password"
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
		textField.attributedPlaceholder = NSAttributedString(string:"6+ characters (no spaces)",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
		textField.returnKeyType = .done
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	var buttonBottomAnchorConstraint: NSLayoutConstraint?
	var textFieldTopAnchorConstraint: NSLayoutConstraint?
	var emailTextFieldEntered = Bool()
	var passwordTextFieldEntered = Bool()
	
	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Login", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.darkerBlack()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = false
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.navigationNoLineBar()
		self.setupViews()
		self.setupKeyboardObservers()
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
		
	}
	
	
	func setupViews() {
		
		view.addSubview(headerLabel)
		emailTextField.delegate = self
		view.addSubview(emailTextField)
		view.addSubview(passwordHeaderLabel)
		passwordTextField.delegate = self
		view.addSubview(passwordTextField)
		view.addSubview(nextButton)
		
		textFieldTopAnchorConstraint = headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
		textFieldTopAnchorConstraint?.isActive = true
		headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		headerLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		emailTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30).isActive = true
		emailTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		passwordHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		passwordHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		passwordHeaderLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50).isActive = true
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
	
	
	func handleNext() {
		
		emailTextField.resignFirstResponder()
		self.view.endEditing(true)
		
		if let emailAdded = emailTextField.text {
			
			emailCaptured = emailAdded
			self.navigationController?.pushViewController(PasswordViewController(), animated: true)
			
		} else {
			
			return
			
		}
		
		
		
	}
	
	
}

extension LoginViewController {
	
	
	func setupKeyboardObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
	}
	
	
	
	
	func handleKeyboardNotification(notification: NSNotification) {
		
		let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
		
		UIView.animate(withDuration: 0.25) {
			
			if isKeyboardShowing == true {
				
				self.textFieldTopAnchorConstraint?.constant = 40
				self.buttonBottomAnchorConstraint?.constant = -275
				
			} else {
				
				self.textFieldTopAnchorConstraint?.constant = 100
				self.buttonBottomAnchorConstraint?.constant = -15
				
			}
			
			self.view.layoutIfNeeded()
		}
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
		
	}
	
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if emailTextField.text! != "" && passwordTextField.text != "" {
			
			nextButton.isEnabled = true
			nextButton.backgroundColor = UIColor.paceBrandColor()
			
		} else {
			
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.darkerBlack()
			
			
		}
	}
	
	func textFieldDidChange(textField: UITextField) {
		
		if emailTextField.text! != "" && passwordTextField.text != "" {
			
			nextButton.isEnabled = true
			nextButton.backgroundColor = UIColor.paceBrandColor()
			
		} else {
			
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.darkerBlack()
			
			
		}
		
	}
	
}

