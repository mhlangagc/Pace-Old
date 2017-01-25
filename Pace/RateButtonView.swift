//
//  RateButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RateButtonView : BaseView {
	
	var workoutCompletedVC : WorkoutCompleteVIewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		self.setupButton()
		
	}
	
	func setupButton() {
		
		let rateButton = UIButton()
		rateButton.frame = CGRect(x: 20.0, y: 10.0, width: frame.width - 40.0, height: 50)
		rateButton.setTitle("Rate this Workout", for: UIControlState.normal)
		rateButton.setTitleColor(UIColor.black, for: UIControlState.normal)
		rateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		textSpacing((rateButton.titleLabel)!, spacing: 0.56)
		rateButton.backgroundColor = selectedDayColour
		rateButton.layer.cornerRadius = 6.0
		rateButton.layer.masksToBounds = true
		rateButton.addTarget(self, action: #selector(handleRateWorkout), for: UIControlEvents.touchUpInside)
		addSubview(rateButton)
		
	}
	
	
	func handleRateWorkout() {
		
		workoutCompletedVC?.handleRateWorkout()
		
	}
	
}
