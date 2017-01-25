//
//  GetPopupLauncher.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/27.
//  Copyright © 2016 Pace. All rights reserved.
//

import Foundation

class GetPopupLauncher : NSObject {
	
	let backgroundView : UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor.black
		return view
		
	}()
	
	let blackView = UIView()
	var cancelButton : UIButton?
	var saveToMyProfileButton : UIButton?
	var pickADayButton : UIButton?
	
	override init() {
		super.init()
		
	}
	
	let saveWorkoutLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
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

	
	func showGetPopUp(currentView : UIView) {
		
		
		if let window = UIApplication.shared.keyWindow {
			
			//	Black View
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.85)
			blackView.frame = window.frame
			blackView.alpha = 0
			blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
			window.addSubview(blackView)
			
			//	Background View
			backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
			
			//	Save Workout
			saveWorkoutLabel.frame = CGRect(x: 0.0, y: 12.0, width: backgroundView.frame.width, height: 25.0)
			saveWorkoutLabel.text = "Save Workout"
			saveWorkoutLabel.textAlignment = .center
			backgroundView.addSubview(saveWorkoutLabel)
			
			
			// Save to my profile view
			saveToMyProfileButton = createButton(buttonLabel: "Save to my profile", buttonLabelColor: UIColor.black, buttonBackgroundColor: UIColor.paceBrandColor())
			saveToMyProfileButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
			saveToMyProfileButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 195.0, width: backgroundView.frame.width - 20.0, height: 57.0)
//			saveToMyProfileButton?.roundedButton(corners: [.topLeft, .topRight], radius: 10)
			let maskPAth1 = UIBezierPath(roundedRect: (saveToMyProfileButton?.bounds)!,
			                             byRoundingCorners: [.topLeft, .topRight],
			                             cornerRadii:CGSize(width: 10.0, height: 10.0))
			let maskLayer1 = CAShapeLayer()
			maskLayer1.frame = (saveToMyProfileButton?.bounds)!
			maskLayer1.path = maskPAth1.cgPath
			saveToMyProfileButton?.layer.mask = maskLayer1
			backgroundView.addSubview(saveToMyProfileButton!)
			
			
			// Pick a Day
			pickADayButton = createButton(buttonLabel: "Pick a day", buttonLabelColor: UIColor.black, buttonBackgroundColor: UIColor.paceBrandColor())
			pickADayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
			pickADayButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 136.0, width: backgroundView.frame.width - 20.0, height: 57.0)
			pickADayButton?.roundedButton(corners: [.bottomLeft, .bottomRight], radius: 10)
			backgroundView.addSubview(pickADayButton!)
			
			
			//	Cancel Button
			cancelButton = createButton(buttonLabel: "Cancel", buttonLabelColor: UIColor.paceBrandColor(), buttonBackgroundColor: UIColor.darkBlack())
			cancelButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
			cancelButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 67.0, width: backgroundView.frame.width - 20.0, height: 55.0)
			cancelButton?.layer.cornerRadius = 7.0
			cancelButton?.layer.masksToBounds = true
			cancelButton?.layer.masksToBounds = true
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

}





