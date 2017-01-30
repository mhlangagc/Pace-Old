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

class WelcomeViewController: UIViewController {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var backgroundImage : OnboardingBackgroundImageGradient?
	var timer = Timer()
	let arrayImages = [UIImage(named: "butt"), UIImage(named: "featuredWorkout"), UIImage(named: "20"), UIImage(named: "21"), UIImage(named: "22"), UIImage(named: "23")]
	
	
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
		label.text = "Pace"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightHeavy)
		textSpacing(label, spacing: 0.5)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let detailsLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.text = "Come to organise your workouts." + "\n" + "Stay for what you discover."
		textSpacing(label, spacing: 0)
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
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
		button.setTitleColor(UIColor.white, for: UIControlState.normal)
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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		self.addViews()
		navigationClearBar()
		
		timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loopThroughImages), userInfo: nil, repeats: true)
	}
	
	func loopThroughImages() {
		
		let randomIndex = Int(arc4random_uniform(UInt32(arrayImages.count)))
		UIView.transition(with: self.view, duration: 3, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
				
				self.backgroundImage?.image = self.arrayImages[randomIndex]
				
		}, completion: { (finished: Bool) -> () in
			
		})
		
	}
	
	func addViews() {
		
		backgroundImage = OnboardingBackgroundImageGradient.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
		backgroundImage?.contentMode = .scaleAspectFill
		backgroundImage?.isUserInteractionEnabled = true
		backgroundImage?.layer.masksToBounds = true
		self.backgroundImage?.image = self.arrayImages[0]
		backgroundImage?.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(backgroundImage!)
		backgroundImage?.addSubview(logoImageView)
		backgroundImage?.addSubview(paceLabel)
		backgroundImage?.addSubview(detailsLabel)
		backgroundImage?.addSubview(signUpWithEmailButton)
		backgroundImage?.addSubview(loginButton)
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
		paceLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60).isActive = true
		paceLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		detailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
		detailsLabel.topAnchor.constraint(equalTo: paceLabel.bottomAnchor, constant: 12).isActive = true
		detailsLabel.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		signUpWithEmailButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		signUpWithEmailButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		signUpWithEmailButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 45).isActive = true
		signUpWithEmailButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		loginButton.topAnchor.constraint(equalTo: signUpWithEmailButton.bottomAnchor, constant: 15).isActive = true
		loginButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		termsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
		termsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
		termsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		termsButton.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
		
		
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
