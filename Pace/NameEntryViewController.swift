//
//  NameEntryViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

var firstName  = String()

class NameEntryViewController : UIViewController, UITextFieldDelegate {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var buttonBottomAnchorConstraint: NSLayoutConstraint?
	
	let nameHeaderLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "What is your name"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var nameEntryTextField: TextField = {
		
		let textField = TextField()
		textField.borderStyle = .none
		textField.keyboardType = .default
		textField.keyboardAppearance = .dark
		textField.autocapitalizationType = UITextAutocapitalizationType.words
		textField.backgroundColor = .black
		textField.textColor = UIColor.greyWhite()
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"your first name",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
		textField.returnKeyType = .done
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	
	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("next", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.darkerBlack()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = false
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationNoLineBar()
		self.navigationController?.navigationBar.tintColor = UIColor.white
		onboardingCounter(counterString : "3 of 5")
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleNothing))
		view.backgroundColor = UIColor.black
		
		self.setupViews()
		self.setupKeyboardObservers()
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
		
	}
	
	
	func setupViews() {
		
		view.addSubview(nameHeaderLabel)
		nameEntryTextField.delegate = self
		view.addSubview(nameEntryTextField)
		view.addSubview(nextButton)
		
		nameHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		nameHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		nameHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		nameHeaderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		nameEntryTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		nameEntryTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		nameEntryTextField.topAnchor.constraint(equalTo: nameHeaderLabel.bottomAnchor, constant: 30).isActive = true
		nameEntryTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		buttonBottomAnchorConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
		buttonBottomAnchorConstraint?.isActive = true
		nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handleNext() {
		
		nameEntryTextField.resignFirstResponder()
		self.view.endEditing(true)
		
		if let usersFirstName = nameEntryTextField.text {
			
			firstName = usersFirstName
			self.navigationController?.pushViewController(PickGenderViewController(), animated: true)
		
		}
		
		
	}
	
	
	func handleNothing() {
		
		//	DO NOTHING
	}
	
	
}

extension NameEntryViewController {
	
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
		
		nameEntryTextField.resignFirstResponder()
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
		
	}
	
	
	func textFieldDidChange(textField: UITextField) {
		
		if (nameEntryTextField.text?.characters.count)! > 0 {
			
			nextButton.isEnabled = true
			nextButton.backgroundColor = UIColor.paceBrandColor()
			
		} else {
			
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.darkerBlack()
			
			
		}
		
	}
	
}
