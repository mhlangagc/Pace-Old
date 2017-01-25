//
//  PickGenderViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class PickGenderViewController : UIViewController {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let pickHeaderLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "Pick your gender"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let descriptionLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 3
		label.text = "This is so Pace can be a little smart and show you relavant workout images"
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("next", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor(fromHexString: "212833")
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationNoLineBar()
		onboardingCounter(counterString : "4 of 5")
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleNothing))
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
		view.backgroundColor = UIColor.black
		
		self.setupViews()
		
	}
	
	func setupViews() {
		
		
		view.addSubview(pickHeaderLabel)
		view.addSubview(descriptionLabel)
		view.addSubview(nextButton)
		
		pickHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		pickHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		pickHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		pickHeaderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: pickHeaderLabel.bottomAnchor, constant: 30).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		
		nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handleNext() {
		
		self.navigationController?.pushViewController(HealthConnectViewController(), animated: true)
		
		
	}

	func handleNothing() {
		
		//	DO NOTHING
		
	}
	
}
