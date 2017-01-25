//
//  ActivityCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ActivityCell : CollectionViewBaseCell {
	
	
	var activityModel : ActivitiesModel? {
		
		didSet {
			
			if let dayName = activityModel?.dayName, let workoutName  = activityModel?.workoutName {
				
				dateAndWorkoutLabel.text = "\(dayName) : \(workoutName)"
				
			}
			
			if let sleepHours = activityModel?.sleepHours, let sleepMins  = activityModel?.sleepMins, let workoutTime = activityModel?.workoutMins, let steps = activityModel?.steps {
				
				detailView.hoursOfSleepLabel?.text = "\(sleepHours)"
				detailView.minsOfSleepLabel?.text = ": \(sleepMins)"
				detailView.stepsNumberLabel?.text = "\(steps)"
				
				detailView.workoutTimeLabel?.text = "\(workoutTime)"
				detailView.workoutTimeLabel?.textColor = UIColor.greyBlackColor()
				detailView.minsWorkoutLabel?.textColor = UIColor.greyBlackColor()
				detailView.activityIcon?.tintColor = UIColor(fromHexString: "212834")
				
			}

			
		}
	}
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	let dateAndWorkoutLabel : UILabel = {
		
		let label = UILabel()
		label.numberOfLines = 2
		label.font = UIFont.systemFont(ofSize: 19, weight: UIFontWeightBlack)
		label.textColor = UIColor(fromHexString: "94A3BE")
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let shareButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "shareActivity"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let detailView : ActitivityDetailView = {
		
		let view = ActitivityDetailView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.clear
		self.addViews()
		
	}
	
	func addViews() {
	
		addSubview(dateAndWorkoutLabel)
		//addSubview(shareButton)
		addSubview(detailView)
		
		shareButton.addTarget(self, action: #selector(handleShareActivity), for: UIControlEvents.touchUpInside)
		
		dateAndWorkoutLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dateAndWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
		dateAndWorkoutLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -55).isActive = true
		dateAndWorkoutLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
//		shareButton.centerYAnchor.constraint(equalTo: dateAndWorkoutLabel.centerYAnchor).isActive = true
//		shareButton.leftAnchor.constraint(equalTo: dateAndWorkoutLabel.rightAnchor, constant: 20.0).isActive = true
//		shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
//		shareButton.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
		
		detailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
		detailView.topAnchor.constraint(equalTo: dateAndWorkoutLabel.bottomAnchor, constant: 35.0).isActive = true
		detailView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		detailView.heightAnchor.constraint(equalToConstant: 165.0).isActive = true
		
	}
	
	func handleShareActivity() {
		
		//TODO
		
	}
	
	
	
}

