//
//  ActitivityDetailView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ActitivityDetailView : BaseView {
	
	var sleepView : UIView?
	var sleepIcon : UIImageView?
	var hoursOfSleepLabel : UILabel?
	var minsOfSleepLabel: UILabel?
	var sleepHoursLabel : UILabel?
	
	
	var workoutView : UIView?
	var activityIcon : UIImageView?
	var workoutTimeLabel : UILabel?
	var minsWorkoutLabel : UILabel?
	
	
	var stepView : UIView?
	var stepsIcon : UIImageView?
	var stepsNumberLabel : UILabel?
	var stepsLabel : UILabel?
	
	let iconsColor = UIColor.greyBlackColor()
	let labelColors = UIColor.greyBlackColor()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .clear
		self.setupSleepView()
		self.setupWorkoutView()
		self.setupStepsViews()
		
		
	}
	
	func setupSleepView() {
		
		
		sleepView = UIView()
		sleepView?.backgroundColor = UIColor.darkerBlack()
		sleepView?.layer.cornerRadius = 10.0
		sleepView?.layer.masksToBounds = true
		sleepView?.translatesAutoresizingMaskIntoConstraints = false
		addSubview(sleepView!)
		
		
		sleepIcon = UIImageView()
		sleepIcon?.image = UIImage(named: "moonAndStars")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		sleepIcon?.tintColor = iconsColor
		sleepIcon?.contentMode = .scaleAspectFill
		sleepIcon?.translatesAutoresizingMaskIntoConstraints = false
		sleepView?.addSubview(sleepIcon!)
		
		hoursOfSleepLabel = UILabel()
		hoursOfSleepLabel?.adjustsFontSizeToFitWidth = true
		hoursOfSleepLabel?.font = UIFont.systemFont(ofSize: 60, weight: UIFontWeightHeavy)
		hoursOfSleepLabel?.textColor = labelColors
		hoursOfSleepLabel?.textAlignment = .center
		hoursOfSleepLabel?.translatesAutoresizingMaskIntoConstraints = false
		sleepView?.addSubview(hoursOfSleepLabel!)
		
		minsOfSleepLabel = UILabel()
		minsOfSleepLabel?.adjustsFontSizeToFitWidth = true
		minsOfSleepLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy)
		minsOfSleepLabel?.textColor = labelColors
		minsOfSleepLabel?.textAlignment = .right
		minsOfSleepLabel?.translatesAutoresizingMaskIntoConstraints = false
		sleepView?.addSubview(minsOfSleepLabel!)
		
		sleepHoursLabel = UILabel()
		sleepHoursLabel?.text = "hrs Asleep"
		sleepHoursLabel?.adjustsFontSizeToFitWidth = true
		sleepHoursLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sleepHoursLabel?.textColor = labelColors
		sleepHoursLabel?.textAlignment = .left
		sleepHoursLabel?.translatesAutoresizingMaskIntoConstraints = false
		sleepView?.addSubview(sleepHoursLabel!)
		
		
		//	Constraints
		sleepView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		sleepView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
		sleepView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		sleepView?.widthAnchor.constraint(equalToConstant: 126.0).isActive = true
		
		
		sleepIcon?.rightAnchor.constraint(equalTo: (sleepView?.rightAnchor)!, constant: -15.0).isActive = true
		sleepIcon?.topAnchor.constraint(equalTo: (sleepView?.topAnchor)!, constant: 15.0).isActive = true
		sleepIcon?.widthAnchor.constraint(equalToConstant: 34.0).isActive = true
		sleepIcon?.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
		
		
		hoursOfSleepLabel?.leftAnchor.constraint(equalTo: (sleepView?.leftAnchor)!, constant: 14.0).isActive = true
		hoursOfSleepLabel?.topAnchor.constraint(equalTo: (sleepIcon?.bottomAnchor)!, constant: 10.0).isActive = true
		hoursOfSleepLabel?.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		hoursOfSleepLabel?.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		
		minsOfSleepLabel?.leftAnchor.constraint(equalTo: (hoursOfSleepLabel?.rightAnchor)!).isActive = true
		minsOfSleepLabel?.topAnchor.constraint(equalTo: (sleepIcon?.bottomAnchor)!, constant: 18.0).isActive = true
		minsOfSleepLabel?.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
		minsOfSleepLabel?.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		sleepHoursLabel?.leftAnchor.constraint(equalTo: (sleepView?.leftAnchor)!, constant: 20.0).isActive = true
		sleepHoursLabel?.topAnchor.constraint(equalTo: (hoursOfSleepLabel?.bottomAnchor)!, constant: 12.0).isActive = true
		sleepHoursLabel?.rightAnchor.constraint(equalTo: (sleepView?.rightAnchor)!, constant: -20.0).isActive = true
		sleepHoursLabel?.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
	}
	
	func setupWorkoutView() {
		
		
		workoutView = UIView()
		workoutView?.backgroundColor = UIColor.darkerBlack()
		workoutView?.layer.cornerRadius = 10.0
		workoutView?.layer.masksToBounds = true
		workoutView?.translatesAutoresizingMaskIntoConstraints = false
		addSubview(workoutView!)
		
		
		activityIcon = UIImageView()
		activityIcon?.image = UIImage(named: "stopWatch")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		activityIcon?.tintColor = iconsColor
		activityIcon?.contentMode = .scaleAspectFill
		activityIcon?.translatesAutoresizingMaskIntoConstraints = false
		workoutView?.addSubview(activityIcon!)
		
		workoutTimeLabel = UILabel()
		workoutTimeLabel?.text = "27"
		workoutTimeLabel?.textColor = labelColors
		workoutTimeLabel?.adjustsFontSizeToFitWidth = true
		workoutTimeLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightHeavy)
		workoutTimeLabel?.textAlignment = .left
		workoutTimeLabel?.translatesAutoresizingMaskIntoConstraints = false
		workoutView?.addSubview(workoutTimeLabel!)
		
		minsWorkoutLabel = UILabel()
		minsWorkoutLabel?.text = "mins workout"
		minsWorkoutLabel?.textColor = labelColors
		minsWorkoutLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		textSpacing(minsWorkoutLabel!, spacing: -0.3)
		minsWorkoutLabel?.textAlignment = .left
		minsWorkoutLabel?.translatesAutoresizingMaskIntoConstraints = false
		workoutView?.addSubview(minsWorkoutLabel!)
		
		
		//	Constraints
		workoutView?.leftAnchor.constraint(equalTo: (sleepView?.rightAnchor)!, constant: 7.5).isActive = true
		workoutView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
		workoutView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		workoutView?.heightAnchor.constraint(equalToConstant: 85.0).isActive = true
		
		
		activityIcon?.rightAnchor.constraint(equalTo: (workoutView?.rightAnchor)!, constant: -10.0).isActive = true
		activityIcon?.centerYAnchor.constraint(equalTo: (workoutView?.centerYAnchor)!).isActive = true
		activityIcon?.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
		activityIcon?.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		
		
		workoutTimeLabel?.leftAnchor.constraint(equalTo: (workoutView?.leftAnchor)!, constant: 20.0).isActive = true
		workoutTimeLabel?.topAnchor.constraint(equalTo: (workoutView?.topAnchor)!, constant: 16.0).isActive = true
		workoutTimeLabel?.rightAnchor.constraint(equalTo: (activityIcon?.rightAnchor)!, constant: -15).isActive = true
		workoutTimeLabel?.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		
		minsWorkoutLabel?.leftAnchor.constraint(equalTo: (workoutView?.leftAnchor)!, constant: 20.0).isActive = true
		minsWorkoutLabel?.topAnchor.constraint(equalTo: (workoutTimeLabel?.bottomAnchor)!, constant: 5.0).isActive = true
		minsWorkoutLabel?.rightAnchor.constraint(equalTo: (activityIcon?.rightAnchor)!, constant: -16.0).isActive = true
		minsWorkoutLabel?.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
	}
	
	func setupStepsViews() {
		
		
		stepView = UIView()
		stepView?.backgroundColor = UIColor.darkerBlack()
		stepView?.layer.cornerRadius = 10.0
		stepView?.layer.masksToBounds = true
		stepView?.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stepView!)
		
		
		stepsIcon = UIImageView()
		stepsIcon?.image = UIImage(named: "steps")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		stepsIcon?.tintColor = iconsColor
		stepsIcon?.contentMode = .scaleAspectFill
		stepsIcon?.translatesAutoresizingMaskIntoConstraints = false
		stepView?.addSubview(stepsIcon!)
		
		stepsNumberLabel = UILabel()
		stepsNumberLabel?.text = "10,989 "
		stepsNumberLabel?.adjustsFontSizeToFitWidth = true
		stepsNumberLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightHeavy)
		stepsNumberLabel?.textColor = labelColors
		stepsNumberLabel?.textAlignment = .left
		textSpacing(stepsNumberLabel!, spacing: -0.3)
		stepsNumberLabel?.translatesAutoresizingMaskIntoConstraints = false
		stepView?.addSubview(stepsNumberLabel!)
		
		stepsLabel = UILabel()
		stepsLabel?.text = "steps"
		stepsLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		stepsLabel?.textColor = labelColors
		stepsLabel?.textAlignment = .left
		stepsLabel?.translatesAutoresizingMaskIntoConstraints = false
		stepView?.addSubview(stepsLabel!)
		
		
		//	Constraints
		stepView?.leftAnchor.constraint(equalTo: leftAnchor, constant: 133.5).isActive = true
		stepView?.topAnchor.constraint(equalTo: topAnchor, constant: 92.5).isActive = true
		stepView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		stepView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		
		
		stepsNumberLabel?.leftAnchor.constraint(equalTo: (stepView?.leftAnchor)!, constant: 20.0).isActive = true
		stepsNumberLabel?.topAnchor.constraint(equalTo: (stepView?.topAnchor)!, constant: 10.0).isActive = true
		stepsNumberLabel?.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
		stepsNumberLabel?.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		
		stepsIcon?.rightAnchor.constraint(equalTo: (stepView?.rightAnchor)!, constant: -10.0).isActive = true
		stepsIcon?.centerYAnchor.constraint(equalTo: (stepView?.centerYAnchor)!).isActive = true
		stepsIcon?.widthAnchor.constraint(equalToConstant: 21.0).isActive = true
		stepsIcon?.heightAnchor.constraint(equalToConstant: 31.0).isActive = true
		
		
		stepsLabel?.leftAnchor.constraint(equalTo: (stepView?.leftAnchor)!, constant: 20.0).isActive = true
		stepsLabel?.topAnchor.constraint(equalTo: (stepsNumberLabel?.bottomAnchor)!).isActive = true
		stepsLabel?.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
		stepsLabel?.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
	}
	
	
}


