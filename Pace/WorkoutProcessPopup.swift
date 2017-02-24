//
//  WorkoutProcessPopup.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/05.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation

class EndWorkoutPopupLauncher : NSObject {
	
	let backgroundView : UIView = {
		
		let view = UIView()
		return view
		
	}()
	
	let blackView = UIView()
	var cancelButton : UIButton?
	var endWorkoutButton : UIButton?
	var cancelWorkout : UIButton?
	
	var workoutProcessVC : WorkoutProcessViewController?
	
	override init() {
		super.init()
		
	}
	
	let addTo : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
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
	
	
	func showEndWorkoutPopUp(currentView : UIView) {
		
		
		if let window = UIApplication.shared.keyWindow {
			
			//	Black View
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.85)
			blackView.frame = window.frame
			blackView.alpha = 0
			blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
			window.addSubview(blackView)
			
			//	Background View
			backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
			backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 250.0)
			
			self.endWorkoutButtons()
			
			window.addSubview(backgroundView)
			
			UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
				
				self.blackView.alpha = 1
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height - 250.0, width: window.frame.width, height: 250.0)
				
			}, completion: { (completed) in
				
				// TO DO - Analytics
				
			})
			
		}
	}
	
	func endWorkoutButtons() {
		
		//	Add To
		addTo.frame = CGRect(x: 0.0, y: 10.0, width: backgroundView.frame.width, height: 25.0)
		addTo.text = "End Workout"
		addTo.textAlignment = .center
		backgroundView.addSubview(addTo)
		
		
		// End Workout
		endWorkoutButton = createButton(buttonLabel: "End Workout", buttonLabelColor: UIColor.black, buttonBackgroundColor: selectedDayColour)
		endWorkoutButton?.addTarget(self, action: #selector(handleEndWorkout), for: UIControlEvents.touchUpInside)
		endWorkoutButton?.frame = CGRect(x: 10.0, y: 50.0, width: backgroundView.frame.width - 20.0, height: 57.0)
		endWorkoutButton?.roundedButton(corners: [.topLeft, .topRight], radius: 10)
		backgroundView.addSubview(endWorkoutButton!)
		
		
		//	Cancel Workout
		cancelWorkout = createButton(buttonLabel: "Cancel Workout", buttonLabelColor: UIColor.black, buttonBackgroundColor: selectedDayColour)
		cancelWorkout?.addTarget(self, action: #selector(handleStopWorkout), for: UIControlEvents.touchUpInside)
		cancelWorkout?.frame = CGRect(x: 10.0, y: 50.0 + 57.5, width: backgroundView.frame.width - 20.0, height: 57.0)
		cancelWorkout?.roundedButton(corners: [.bottomLeft, .bottomRight], radius: 10)
		backgroundView.addSubview(cancelWorkout!)
		
		
		//	Cancel Button
		cancelButton = createButton(buttonLabel: "Cancel", buttonLabelColor: selectedDayColour, buttonBackgroundColor: UIColor.darkBlack())
		cancelButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		cancelButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 72.5, width: backgroundView.frame.width - 20.0, height: 55.0)
		cancelButton?.layer.cornerRadius = 7.0
		cancelButton?.layer.masksToBounds = true
		cancelButton?.layer.masksToBounds = true
		backgroundView.addSubview(cancelButton!)
		
	}
	
	func handleCancel() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
			
			self.blackView.alpha = 0
			
			if let window = UIApplication.shared.keyWindow {
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
				
			}
			
		}, completion: nil)
		
	}
	
	func handleStopWorkout() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
			
			self.blackView.alpha = 0
			
			if let window = UIApplication.shared.keyWindow {
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
				
			}
			
		}) { (completed) in
			
			self.workoutProcessVC?.handleCancelWorkout()
			
		}
		
		
		
	}
	
	func handleEndWorkout() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
			
			self.blackView.alpha = 0
			
			if let window = UIApplication.shared.keyWindow {
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
				
			}
			
		}) { (completed) in
			
			self.workoutProcessVC?.endWorkout()
			
		}
		
		
	}
	
}
