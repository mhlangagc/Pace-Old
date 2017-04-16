//
//  WelcomeLaunchViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/05.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Lottie
import Firebase
import FirebaseDatabase
import SafariServices

class WelcomeLaunchViewController: UIViewController {

	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var animationView : LOTAnimationView?
	
	let detailsLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.text = "Come to organise your workouts." + "\n" + "Stay for what you discover."
		textSpacing(label, spacing: 0)
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var signUpWithEmailButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Sign up", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.paceBrandColor()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.addTarget(self, action: #selector(handleSignUp), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	lazy var loginButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Login", for: UIControlState.normal)
		button.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		button.backgroundColor = UIColor.darkBlack()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.addTarget(self, action: #selector(handleLogin), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	lazy var termsButton : UIButton = {
		
		let button = UIButton()
		button.setTitleColor(UIColor.white, for: UIControlState())
		button.setTitle("Our Terms of Use", for: UIControlState())
		button.addTarget(self, action: #selector(handleShowTerms), for: UIControlEvents.touchUpInside)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	var lottieTopConstraint: NSLayoutConstraint?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .black
		self.addAnimationView()
		self.addViews()
		navigationClearBar()
		
		animationView?.play(completion: { (finished) in
			
			UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
				
				self.lottieTopConstraint?.constant = -150
				
			}, completion: nil)
			
			UIView.animate(withDuration: 0.9, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
				
				self.detailsLabel.layer.opacity = 1.0
				self.signUpWithEmailButton.layer.opacity = 1.0
				self.loginButton.layer.opacity = 1.0
				self.termsButton.layer.opacity = 1.0
				
			}, completion: nil)
			
			
		
		})
		
    }
	
	func addAnimationView() {
		
		animationView = LOTAnimationView(name: "LottieLogo2")
		animationView?.backgroundColor = .black
		animationView?.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(animationView!)
		
		lottieTopConstraint = animationView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
		lottieTopConstraint?.isActive = true
		animationView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		animationView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		animationView?.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
		
		
	}
	
	func addViews() {
		
		detailsLabel.layer.opacity = 0.0
		signUpWithEmailButton.layer.opacity = 0.0
		loginButton.layer.opacity = 0.0
		termsButton.layer.opacity = 0.0
		
		view.addSubview(detailsLabel)
		view.addSubview(signUpWithEmailButton)
		view.addSubview(loginButton)
		view.addSubview(termsButton)
		
		
		//  Constraints
		termsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
		termsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
		termsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		termsButton.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
		
		loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		loginButton.bottomAnchor.constraint(equalTo: termsButton.topAnchor, constant: -65).isActive = true
		loginButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		signUpWithEmailButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		signUpWithEmailButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		signUpWithEmailButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15).isActive = true
		signUpWithEmailButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		detailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
		detailsLabel.bottomAnchor.constraint(equalTo: signUpWithEmailButton.topAnchor, constant: -65).isActive = true
		detailsLabel.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		
	}

	
	func handleSignUp() {
		
		self.navigationController?.pushViewController(EmailViewController(), animated: true)
		
	}
	
	
	func handleLogin() {
		
		self.navigationController?.pushViewController(LoginViewController(), animated: true)
		
	}
	
	
	func  handleShowTerms() {
		
		let svc = SFSafariViewController(url: NSURL(string: termsLink)! as URL)
		self.present(svc, animated: true, completion: nil)
		
	}
	
}
