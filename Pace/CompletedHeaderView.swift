//
//  CompletedHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class CompletedHeaderView : BaseView {
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		addViews()
		
	}
	
	func addViews() {
		
		let activityIcon = UIImageView()
		activityIcon.frame = CGRect(x: ((frame.width - 40) * 0.5), y: 30.0, width: 40.0, height: 40.0)
		activityIcon.image = UIImage(named: "activityCheck")?.withRenderingMode(.alwaysTemplate)
		activityIcon.tintColor = selectedDayColour
		activityIcon.contentMode = .scaleAspectFit
		activityIcon.clipsToBounds = true
		addSubview(activityIcon)
		
		let minsNumberLabel = UILabel()
		minsNumberLabel.frame = CGRect(x: 0.0, y: 110.0, width: frame.width, height: 35.0)
		minsNumberLabel.textAlignment = .center
		minsNumberLabel.text = "44 mins".uppercased()
		minsNumberLabel.textColor = .white
		textSpacing(minsNumberLabel, spacing: 3.5)
		minsNumberLabel.font = UIFont(name: "BebasNeueBold", size: 35)
		addSubview(minsNumberLabel)
		
		
		let workoutTimeLabel = UILabel()
		workoutTimeLabel.frame = CGRect(x: 0.0, y: 157.0, width: frame.width, height: 24.0)
		workoutTimeLabel.textAlignment = .center
		workoutTimeLabel.text = "Workout Time"
		textSpacing(workoutTimeLabel, spacing: 3.5)
		workoutTimeLabel.textColor = .white
		workoutTimeLabel.font = UIFont(name: "BebasNeueBold", size: 20)
		addSubview(workoutTimeLabel)
		
	}
	
}
