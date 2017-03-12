//
//  SaveToMyRoutines.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class SaveToMyRoutinesView : BaseView {
	
	var gradientBackground : UIView?
	var saveButton : UIButton?
	var workoutDownloadVC : WorkoutDownloadViewController?
	
	override func setupViews() {
		super.setupViews()
		
		self.setupButtons()
		
	}
	
	func setupButtons() {
		
		if let window = UIApplication.shared.keyWindow {
			
			
			gradientBackground = UIView()
			gradientBackground?.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: frame.height)
			gradientBackground?.backgroundColor = UIColor.clear
			backgroundGradientLayer(view: gradientBackground!, overLayView: self)
			gradientBackground?.layer.masksToBounds = true
			addSubview(gradientBackground!)
			
			saveButton = UIButton()
			saveButton?.frame = CGRect(x: 20.0, y: 10.0, width: window.frame.width - 40.0, height: 50.0)
			saveButton?.setTitle("SAVE TO MY ROUTINES".uppercased(), for: UIControlState.normal)
			saveButton?.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
			textSpacing((saveButton?.titleLabel)!, spacing: 0.5)
			saveButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15.5, weight: UIFontWeightBold)
			saveButton?.layer.cornerRadius = 8.0
			saveButton?.layer.masksToBounds = true
			saveButton?.backgroundColor = UIColor.darkBlack()
			saveButton?.addTarget(self, action: #selector(handlesSaveToRoutine), for: UIControlEvents.touchUpInside)
			gradientBackground?.addSubview(saveButton!)
			
			
		}
		
		
		
	}
	
	func backgroundGradientLayer(view: UIView, overLayView: UIView) {
		
		let gradient = CAGradientLayer()
		gradient.frame = overLayView.frame
		gradient.startPoint = CGPoint(x: 0.5, y: 0)
		gradient.endPoint = CGPoint(x: 0.5, y: 1)
		let colors : [CGColor] = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
		let location = [0.0, 0.05, 1.0]
		gradient.colors = colors
		gradient.isOpaque = true
		gradient.locations = location as [NSNumber]?
		view.layer.addSublayer(gradient)
		
	}
	
	
	
	func handlesSaveToRoutine() {
		
		workoutDownloadVC?.handleSaveWorkoutToRoutine()
		
	}
}
