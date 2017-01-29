//
//  PickGenderViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Crashlytics
import Fabric
import Firebase
import FirebaseAuth
import FirebaseDatabase


class PickGenderViewController : UIViewController {
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	var authentication = AuthenticationService()
	var genderSelected = false
	var femaleSelected = Bool()
	
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
	
	lazy var femaleButton : UIButton = {
		
		let button = UIButton()
		button.contentHorizontalAlignment = .left
		button.setTitle("Female", for: UIControlState.normal)
		button.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightHeavy)
		button.addTarget(self, action: #selector(handleFemaleSelected), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	lazy var femaleImageButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "female_select")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		button.tintColor = UIColor.greyBlackColor()
		button.addTarget(self, action: #selector(handleFemaleSelected), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	lazy var maleButton : UIButton = {
		
		let button = UIButton()
		button.contentHorizontalAlignment = .left
		button.setTitle("Male", for: UIControlState.normal)
		button.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightHeavy)
		button.addTarget(self, action: #selector(handleMaleSelected), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	lazy var maleImageButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "male_select")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		button.tintColor = UIColor.greyBlackColor()
		button.addTarget(self, action: #selector(handleMaleSelected), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	lazy var nextButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("next", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.darkerBlack()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleNext), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		authentication.updateFireBasewithName(nameCaptured: firstName) { (error) in
			
			if error != nil {
				
				self.failurePopup(mainMessage: "Something's being a doozy", detailedString: (error?.localizedDescription)!)
				
			} else {
				
				//	Sucess 
				print("Name Updated")
				
			}
		}
	}
	
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
		view.addSubview(femaleButton)
		view.addSubview(femaleImageButton)
		view.addSubview(maleButton)
		view.addSubview(maleImageButton)
		view.addSubview(nextButton)
		
		pickHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		pickHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		pickHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
		pickHeaderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: pickHeaderLabel.bottomAnchor, constant: 30).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		
		femaleImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
		femaleImageButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60).isActive = true
		femaleImageButton.heightAnchor.constraint(equalToConstant: 68.0).isActive = true
		femaleImageButton.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
		
		
		femaleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 115.0).isActive = true
		femaleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		femaleButton.centerYAnchor.constraint(equalTo: femaleImageButton.centerYAnchor).isActive = true
		femaleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		maleImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
		maleImageButton.topAnchor.constraint(equalTo: femaleImageButton.bottomAnchor, constant: 45).isActive = true
		maleImageButton.heightAnchor.constraint(equalToConstant: 68.0).isActive = true
		maleImageButton.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
		
		
		maleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 115.0).isActive = true
		maleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		maleButton.centerYAnchor.constraint(equalTo: maleImageButton.centerYAnchor).isActive = true
		maleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	func handleFemaleSelected() {
		
		genderSelected = true
		femaleSelected = true
		nextButton.isEnabled = true
		nextButton.backgroundColor = UIColor.paceBrandColor()
		
		
		femaleImageButton.tintColor = UIColor.paceBrandColor()
		femaleButton.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		
		self.maleButton.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		self.maleImageButton.tintColor = UIColor.greyBlackColor()
		
		
	}
	
	
	func handleMaleSelected() {
		
		genderSelected = true
		femaleSelected = false
		nextButton.isEnabled = true
		nextButton.backgroundColor = UIColor.paceBrandColor()
		
		
		self.maleImageButton.tintColor = UIColor.paceBrandColor()
		self.maleButton.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		
		self.femaleButton.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		self.femaleImageButton.tintColor = UIColor.greyBlackColor()
		
		
	}
	
	
	func handleNext() {
		
		if genderSelected == false {
			
			return
			
		} else {
			
			if femaleSelected == true {
				
				// Female
				UserDefaults.standard.setValue("Female", forKey: "userGenderSetting")
				Answers.logCustomEvent(withName: "Gender",
				                       customAttributes: [
										"User": "Female"
					])
				
				self.navigationController?.pushViewController(HealthConnectViewController(), animated: true)
				self.genderSelected = false
				
			} else if femaleSelected == false {
				
				// Male
				UserDefaults.standard.setValue("Male", forKey: "userGenderSetting")
				Answers.logCustomEvent(withName: "Gender",
				                       customAttributes: [
										"User": "Male"
					])
				
				self.navigationController?.pushViewController(HealthConnectViewController(), animated: true)
				self.genderSelected = false
				
			}

			
		}
		
		
		
	}

	func handleNothing() {
		
		//	DO NOTHING
		
	}
	
}
