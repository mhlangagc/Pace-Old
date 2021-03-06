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
	
	let loadingSpinner : UIActivityIndicatorView = {
		
		let spinnerView = UIActivityIndicatorView()
		spinnerView.hidesWhenStopped = true
		spinnerView.activityIndicatorViewStyle = .white
		spinnerView.translatesAutoresizingMaskIntoConstraints = false
		return spinnerView
		
	}()
	
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
		textField.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
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
		textField.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	var buttonBottomAnchorConstraint: NSLayoutConstraint?
	var textFieldTopAnchorConstraint: NSLayoutConstraint?
	var authService = AuthenticationService()
	
	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Login", for: UIControlState.normal)
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
	
	lazy var forgotPasswordButton : UIButton = {
		
		let button = UIButton()
		button.setTitleColor(UIColor(fromHexString: "58606C"), for: UIControlState())
		button.setTitle("Forgot you Password 😑", for: UIControlState())
		button.addTarget(self, action: #selector(handleForgotPassword), for: UIControlEvents.touchUpInside)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
		textSpacing(button.titleLabel!, spacing: 0.8)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.navigationItem.title = "Login"
		self.navigationClearBar()
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.setupViews()
		self.setupKeyboardObservers()
		self.navigationBarItems()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Login"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
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
		nextButton.addSubview(loadingSpinner)
		
		textFieldTopAnchorConstraint = headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
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
		
		loadingSpinner.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
		loadingSpinner.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
		loadingSpinner.heightAnchor.constraint(equalToConstant: 20).isActive = true
		loadingSpinner.widthAnchor.constraint(equalToConstant: 20).isActive = true
		
		
	}
	
	func handleStartSpinner() {
		
		passwordTextField.resignFirstResponder()
		self.view.endEditing(true)
		self.loadingSpinner.startAnimating()
		
		//	Disable Stuff
		self.navigationItem.setHidesBackButton(true, animated: true)
		self.nextButton.isEnabled = false
		self.nextButton.setTitle("", for: UIControlState.normal)
		self.passwordTextField.isEnabled = false
		self.emailTextField.isEnabled = false
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		
		//	Lessen the Opacity Of Stuff
		self.nextButton.backgroundColor = UIColor.headerBlack()
		self.passwordTextField.layer.opacity = 0.4
		self.passwordHeaderLabel.layer.opacity = 0.4
		self.emailTextField.layer.opacity = 0.4
		self.headerLabel.layer.opacity = 0.4
		
	}
	
	func handleStopSpinner() {
		
		self.loadingSpinner.stopAnimating()
		
		//	Disable Stuff
		self.navigationItem.setHidesBackButton(false, animated: true)
		self.nextButton.isEnabled = true
		self.nextButton.setTitle("next", for: UIControlState.normal)
		self.emailTextField.isEnabled = true
		self.passwordTextField.isEnabled = true
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
		
		//	brighten the Opacity Of Stuff
		self.nextButton.backgroundColor = UIColor.paceBrandColor()
		self.passwordTextField.layer.opacity = 1.0
		self.passwordHeaderLabel.layer.opacity = 1.0
		self.emailTextField.layer.opacity = 1.0
		self.headerLabel.layer.opacity = 1.0
		
	}

	
	
	func handleNext() {
		
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		self.view.endEditing(true)
		
		if Reachability.isConnectedToNetwork() == true {
			
			self.handleStartSpinner()
			
			if let emailCaptured = emailTextField.text, let passwordCaptured = passwordTextField.text {
				
				authService.signIn(userEmail: emailCaptured, userPassword: passwordCaptured, completion: { (error) in
					
					if error != nil {
						
						self.failurePopup(mainMessage: "🤔", detailedString: (error?.localizedDescription)!)
						
						self.handleStopSpinner()
						
					} else {
						
						self.handleStopSpinner()
						self.navigateToWeek()
						
					}
					
				})
				
			}

			
			
		} else {
			
			self.failurePopup(mainMessage: "🙈", detailedString: "Looks like you are not connected to the Internet. Check your connection and try again. 🙃")
			
		}
	
	}
	
	
	func handleForgotPassword() {
		
		//	TO DO
	}
	
	
	func navigateToWeek() {
		
		let myRoutineVC = CustomTabBarController()
		myRoutineVC.modalTransitionStyle = .flipHorizontal
		let navC = UINavigationController(rootViewController: myRoutineVC)
		navC.isNavigationBarHidden = true
		self.present(navC, animated: true) {
			
			// Completed
			
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
				
				self.textFieldTopAnchorConstraint?.constant = 60
				self.buttonBottomAnchorConstraint?.constant = -275
				
			} else {
				
				self.textFieldTopAnchorConstraint?.constant = 150
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

