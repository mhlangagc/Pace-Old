//
//  PasswordViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PasswordViewController: UIViewController, UITextFieldDelegate {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var authentication = AuthenticationService()
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
	
	let loadingSpinner : UIActivityIndicatorView = {
		
		let spinnerView = UIActivityIndicatorView()
		spinnerView.hidesWhenStopped = true
		spinnerView.activityIndicatorViewStyle = .white
		spinnerView.translatesAutoresizingMaskIntoConstraints = false
		return spinnerView
		
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
		
		let titleImageView = UIImageView(image: #imageLiteral(resourceName: "home_Active"))
		titleImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		titleImageView.contentMode = .scaleAspectFit
		navigationItem.titleView = titleImageView
		
		self.navigationNoLineBar()
		self.navigationController?.navigationBar.tintColor = UIColor.white
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
		nextButton.addSubview(loadingSpinner)
		
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
		nextButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
		
		
		loadingSpinner.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
		loadingSpinner.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
		loadingSpinner.heightAnchor.constraint(equalToConstant: 20).isActive = true
		loadingSpinner.widthAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		
		
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
	
	func handleStartSpinner() {
		
		passwordTextField.resignFirstResponder()
		self.view.endEditing(true)
		self.loadingSpinner.startAnimating()
		
		//	Disable Stuff
		self.navigationItem.setHidesBackButton(true, animated: true)
		self.nextButton.isEnabled = false
		self.nextButton.setTitle("", for: UIControlState.normal)
		self.showButton.isEnabled = false
		self.passwordTextField.isEnabled = false
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		
		//	Lessen the Opacity Of Stuff
		self.nextButton.backgroundColor = UIColor.headerBlack()
		self.showButton.layer.opacity = 0.4
		self.passwordTextField.layer.opacity = 0.4
		self.passwordHeaderLabel.layer.opacity = 0.4
		
	}
	
	func handleStopSpinner() {
		
		self.loadingSpinner.stopAnimating()
		
		//	Disable Stuff
		self.navigationItem.setHidesBackButton(false, animated: true)
		self.nextButton.isEnabled = true
		self.nextButton.setTitle("next", for: UIControlState.normal)
		self.showButton.isEnabled = true
		self.passwordTextField.isEnabled = true
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
		
		//	brighten the Opacity Of Stuff
		self.nextButton.backgroundColor = UIColor.paceBrandColor()
		self.showButton.layer.opacity = 1.0
		self.passwordTextField.layer.opacity = 1.0
		self.passwordHeaderLabel.layer.opacity = 1.0
		
	}
	
	func handleNext() {
		
		passwordTextField.resignFirstResponder()
		self.view.endEditing(true)
		
		if Reachability.isConnectedToNetwork() == true {
			
			self.handleStartSpinner()
			
			if let passwordCaptured = passwordTextField.text {
				
				authentication.createNewUser(emailCaptured: emailCaptured, passwordCaptured: passwordCaptured, completion: { (error) in
					
					if error != nil {
						
						self.failurePopup(mainMessage: "🤔", detailedString: (error?.localizedDescription)!)
						
						self.handleStopSpinner()
						
						return
						
					} else {
						
						self.handleStopSpinner()
						self.navigationController?.pushViewController(NameEntryViewController(), animated: true)
						
					}
					
				})
				
			}

			
		} else {
		
			self.failurePopup(mainMessage: "🙈", detailedString: "Looks like you are not connected to the Internet. Check your connection and try again. 🙃")
			
		}
		
		
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
			nextButton.backgroundColor = UIColor.paceBrandColor()
			
		} else {
			
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.darkerBlack()
			
			
		}
		
	}

}
