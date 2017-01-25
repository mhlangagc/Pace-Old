//
//  HealthConnectViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class HealthConnectViewController : UIViewController{

	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let connectHeader : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Connect to Healthkit"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let descriptionLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 3
		label.text = "Pace will use this to show your steps, sleep and other workout related info. Sorta like below.."
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var connectButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Connect", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleConnect), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationNoLineBar()
		onboardingCounter(counterString : "5 of 5")
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleNothing))
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
		descriptionLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		
		connectButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		connectButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		connectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		connectButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handleConnect() {
		
		//	TO DO
		self.navigationController?.pushViewController(GoalsInterestsViewController(), animated: true)
		
	}
	
	func handleNothing() {
		
		//	DO NOTHING
		
	}
	
}

