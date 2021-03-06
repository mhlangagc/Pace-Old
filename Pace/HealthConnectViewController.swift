//
//  HealthConnectViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import HealthKit

class HealthConnectViewController : UIViewController{

	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var healthKitManagerAccess = HealthkitAccessAndManager()
	
	let connectHeader : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Allow Access to Health App"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let descriptionLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 0
		label.text = "Pace will use read your steps, sleep and other workout to calculate your activity and transfer your workouts into your Health App."
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var connectButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Grant Access", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.addTarget(self, action: #selector(handleConnect), for: UIControlEvents.touchUpInside)
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
		onboardingCounter(counterString : "5 of 5")
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleSkip))
		view.backgroundColor = UIColor.black
		
		self.setupViews()
		
	}
	
	func setupViews() {
		
		view.addSubview(connectHeader)
		view.addSubview(descriptionLabel)
		view.addSubview(connectButton)
		
		connectHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		connectHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		connectHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		connectHeader.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: connectHeader.bottomAnchor, constant: 30).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		
		connectButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		connectButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		connectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		connectButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handleConnect() {
		
		healthKitManagerAccess.authorizeHealthKitAcess { (authorised, error) in
			
			if authorised {
				
				print("HealthKit authorized.")
				
			} else {
				
				print("HealthKit authorization denied!")
				if error != nil {
					print("\(String(describing: error))")
				}

				
			}
			
		}
		
		perform(#selector(changeButton), with: self, afterDelay: 1.5)
		
	}
	
	func changeButton() {
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleNothing))
		connectHeader.text = "Awesome"
		descriptionLabel.text = "You're Connected"
		
		
		connectButton.addTarget(self, action: #selector(setupWeek), for: UIControlEvents.touchUpInside)
		connectButton.backgroundColor = UIColor.paceBrandColor()
		connectButton.setTitleColor(UIColor.black, for: UIControlState())
		connectButton.setTitle("Next", for: UIControlState())
		
	}
	
	func setupWeek() {
		
		self.navigateToWeek()
		
	}
	
	func handleSkip() {
		
		self.navigateToWeek()
		
	}
	
	func handleNothing() {
		
		
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

