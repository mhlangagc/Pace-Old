//
//  PreferencesPopUpLauncher.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/30.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class PreferencesPopUpLauncher : NSObject {
	
	let backgroundView : UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor.black
		return view
		
	}()
	
	let blackView = UIView()
	var cancelButton : UIButton?
	var setReminderButton : UIButton?
	var moveToProfileButton : UIButton?
	
	override init() {
		super.init()
		
	}
	
	let optionsLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "2C3544")
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		return label
		
	}()
	
	func createButton(buttonLabel: String, buttonLabelColor: UIColor, buttonBackgroundColor: UIColor) -> UIButton {
		
		let button = UIButton()
		button.setTitle(buttonLabel, for: UIControlState.normal)
		button.setTitleColor(buttonLabelColor, for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.backgroundColor = buttonBackgroundColor
		return button
		
	}
	
	
	func handleShowOptions(currentView : UIView, dayColor: UIColor) {
		
		
		if let window = UIApplication.shared.keyWindow {
			
			//	Black View
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.85)
			blackView.frame = window.frame
			blackView.alpha = 0
			blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
			window.addSubview(blackView)
			
			//	Background View
			backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
			
			//	Options
			optionsLabel.frame = CGRect(x: 0.0, y: 12.0, width: backgroundView.frame.width, height: 25.0)
			optionsLabel.text = "Options"
			optionsLabel.textAlignment = .center
			backgroundView.addSubview(optionsLabel)
			
			
			// Set Workout Reminder
			setReminderButton = createButton(buttonLabel: "Set Day Reminder", buttonLabelColor: dayColor, buttonBackgroundColor: UIColor.black)
			setReminderButton?.addTarget(self, action: #selector(handleSetReminder), for: UIControlEvents.touchUpInside)
			setReminderButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 195.0, width: backgroundView.frame.width - 20.0, height: 57.0)
			backgroundView.addSubview(setReminderButton!)
			
			
			// Move to Profile
			moveToProfileButton = createButton(buttonLabel: "Move to Profile", buttonLabelColor: dayColor, buttonBackgroundColor: UIColor.black)
			moveToProfileButton?.addTarget(self, action: #selector(moveToProfile), for: UIControlEvents.touchUpInside)
			moveToProfileButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 136.0, width: backgroundView.frame.width - 20.0, height: 57.0)
			backgroundView.addSubview(moveToProfileButton!)
			
			
			//	Cancel Button
			cancelButton = createButton(buttonLabel: "Cancel", buttonLabelColor: UIColor.greyBlackColor(), buttonBackgroundColor: UIColor.black)
			cancelButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
			cancelButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 67.0, width: backgroundView.frame.width - 20.0, height: 55.0)
			backgroundView.addSubview(cancelButton!)
			
			
			window.addSubview(backgroundView)
			
			UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
				
				self.blackView.alpha = 1
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height - 255.0, width: window.frame.width, height: 255.0)
				
			}, completion: { (completed) in
				
				// TO DO - Analytics
				
			})
			
		}
	}
	
	func handleCancel() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
			
			self.blackView.alpha = 0
			
			if let window = UIApplication.shared.keyWindow {
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
				
			}
			
		}, completion: nil)
		
	}
	
	func handleSetReminder() {
		
		// TO DO
	
	}
	
	func moveToProfile() {
		
		//	TO DO
		
	}
	
}
