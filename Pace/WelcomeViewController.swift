//
//  WelcomeViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/29.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SafariServices
/*
class WelcomeViewController: UIViewController {
	
	//  Optional Variable
	var backgroundImage : OnboardingBackgroundImageGradient?
	var signUpWithFBButton: UIButton?
	var signUpWithEmailButton: UIButton?
	var loginButton: UIButton?
	
	
	//  Logo Image
	let logoImageView : UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "logo")
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	
	let paceLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		textSpacing(label, spacing: 0)
		label.text = "Pace"
		label.textAlignment = .center
		
		if (iPhoneVersion == 5)  {
			
			label.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightHeavy)
			textSpacing(label, spacing: 0.5)
			
		} else {
			
			label.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightHeavy)
			textSpacing(label, spacing: 0)
			
		}
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let detailsLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "F7F8F9")
		label.text = "Come to organise your workouts." + "\n" + "Stay for what you discover."
		textSpacing(label, spacing: 0)
		label.numberOfLines = 2
		label.textAlignment = .center
		
		if (iPhoneVersion == 5)  {
			
			label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
			textSpacing(label, spacing: 0.5)
			
		} else {
			
			label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
			textSpacing(label, spacing: 0.0)
		}
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var termsButton : UIButton = {
		
		let button = UIButton()
		button.setTitleColor(UIColor(fromHexString: "58606C"), for: UIControlState())
		button.setTitle("Our Terms of Use", for: UIControlState())
		button.addTarget(self, action: #selector(handleShowTerms), for: UIControlEvents.touchUpInside)
		
		if (iPhoneVersion == 5)  {
			
			button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
			textSpacing(button.titleLabel!, spacing: 0.8)
			
		} else {
			
			button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
			textSpacing(button.titleLabel!, spacing: 1.0)
		}
		
		
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
 
	//  MARK: View Loading
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		
		self.navigationBarSetup()
		self.addViews()
	}
	
	//  MARK: Nav Bar Setup
	func navigationBarSetup() {
		
		//Transparent Nav Bar
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.backgroundColor = .clear
		
	}
	
	//  AddViews
	func addViews() {
		
		backgroundImage = OnboardingBackgroundImageGradient.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
		backgroundImage?.contentMode = .scaleAspectFill
		backgroundImage?.isUserInteractionEnabled = true
		backgroundImage?.layer.masksToBounds = true
		backgroundImage?.image = UIImage(named: "running")
		backgroundImage?.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(backgroundImage!)
		backgroundImage?.addSubview(logoImageView)
		backgroundImage?.addSubview(paceLabel)
		backgroundImage?.addSubview(detailsLabel)
		
		//  Facebook Buttton
		signUpWithFBButton = paceButtons(buttonText: "Sign Up with Facebook", buttonTextColor: UIColor.white, buttonBackgroundColor: UIColor(fromHexString: "3B5998"))
		signUpWithFBButton?.addTarget(self, action: #selector(facebookSignup), for: UIControlEvents.touchUpInside)
		signUpWithFBButton?.translatesAutoresizingMaskIntoConstraints = false
		backgroundImage?.addSubview(signUpWithFBButton!)
		
		signUpWithEmailButton = paceButtons(buttonText: "Sign Up with Email", buttonTextColor: UIColor.black, buttonBackgroundColor: UIColor(fromHexString: "00EA89"))
		signUpWithEmailButton?.addTarget(self, action: #selector(emailSignup), for: UIControlEvents.touchUpInside)
		signUpWithEmailButton?.translatesAutoresizingMaskIntoConstraints = false
		backgroundImage?.addSubview(signUpWithEmailButton!)
		
		loginButton = paceButtons(buttonText: "Login", buttonTextColor: UIColor.white, buttonBackgroundColor: UIColor(fromHexString: "1C2026"))
		loginButton?.addTarget(self, action: #selector(handleLogin), for: UIControlEvents.touchUpInside)
		loginButton?.translatesAutoresizingMaskIntoConstraints = false
		backgroundImage?.addSubview(loginButton!)
		
		backgroundImage?.addSubview(termsButton)
		
		
		
		//  Constraints
		backgroundImage?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		backgroundImage?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		backgroundImage?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		backgroundImage?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
		logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		
		paceLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		paceLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		paceLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40).isActive = true
		paceLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		detailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
		detailsLabel.topAnchor.constraint(equalTo: paceLabel.bottomAnchor, constant: 12).isActive = true
		detailsLabel.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		
		signUpWithFBButton?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		signUpWithFBButton?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		signUpWithFBButton?.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 45).isActive = true
		signUpWithFBButton?.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		
		signUpWithEmailButton?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		signUpWithEmailButton?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		signUpWithEmailButton?.topAnchor.constraint(equalTo: (signUpWithFBButton?.bottomAnchor)!, constant: 10).isActive = true
		signUpWithEmailButton?.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		loginButton?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		loginButton?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		loginButton?.topAnchor.constraint(equalTo: (signUpWithEmailButton?.bottomAnchor)!, constant: 25).isActive = true
		loginButton?.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		termsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
		termsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
		termsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		termsButton.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
		
		
	}
	
	
	//  MARK: Actions
	func facebookSignup() {
		
		buttonBounceAnimation(buttonPressed: signUpWithFBButton!)
		if Reachability.isConnectedToNetwork() {
			
			perform(#selector(handleFb), with: self, afterDelay: 0.15)
			
			
		} else {
			
			//  Popup
			let alertview = UIAlertController(title: "No Internet Connection", message: "Looks like you are not online. Check you internet connection and try again", preferredStyle: .alert)
			alertview.addAction(UIAlertAction(title: "Ok", style: .default, handler:
				{ (alertAction) -> Void in
					
			}))
			
			present(alertview, animated: true, completion: nil)
			
			
		}
		
		
	}
	
	func emailSignup() {
		
		buttonBounceAnimation(buttonPressed: signUpWithEmailButton!)
		perform(#selector(handleEmail), with: self, afterDelay: 0.2)
		
	}
	
	func handleLogin() {
		
		buttonBounceAnimation(buttonPressed: loginButton!)
		perform(#selector(handleLoginToPace), with: self, afterDelay: 0.2)
		
	}
	
	
	func handleEmail() {
		
		self.navigationController?.pushViewController(EmailViewController(), animated: true)
		
	}
	
	
	func handleLoginToPace() {
		
		self.navigationController?.pushViewController(LoginViewController(), animated: true)
		
	}
	
	
	func  handleShowTerms() {
		
		let svc = SFSafariViewController(url: NSURL(string: termsLink)! as URL)
		self.present(svc, animated: true, completion: nil)
		
	}
	
	
}
*/
