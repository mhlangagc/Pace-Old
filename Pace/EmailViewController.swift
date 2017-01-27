//
//  EmailViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class EmailViewController : UIViewController, UITextFieldDelegate {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let headerLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "What is your email"
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
	
    var buttonBottomAnchorConstraint: NSLayoutConstraint?
	
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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.navigationNoLineBar()
		onboardingCounter(counterString : "1 of 5")
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
		view.addSubview(nextButton)
		
		headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		headerLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
        
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
		nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonBottomAnchorConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        buttonBottomAnchorConstraint?.isActive = true
		nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
	
    }
   
	
	func handleNext() {
        
        emailTextField.resignFirstResponder()
        self.view.endEditing(true)
        
        //  Pass email details for checking 
		
		//	TO DO
		self.navigationController?.pushViewController(PasswordViewController(), animated: true)
		
	}
	
	
}

extension EmailViewController {
	
    
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
        
        emailTextField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if emailTextField.text!.isValidEmailAddress == true {
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.paceBrandColor()
            
        } else {
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor(fromHexString: "212833")
            
            
        }
    }
    
	func textFieldDidChange(textField: UITextField) {
		
        if emailTextField.text!.isValidEmailAddress == true {
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.paceBrandColor()
            
        } else {
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.paceBrandColor()
            
            
        }
        
    }
	
}
