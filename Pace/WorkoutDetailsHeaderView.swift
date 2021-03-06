//
//  WorkoutDetailsHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//


import UIKit
import AsyncDisplayKit

class WorkoutDetailsHeaderView : BaseView {

	var workoutsImageView: StoreImageGradient?
	var workoutName : UILabel?
	var workoutTimeLabel : UILabel?
	
	var kmNumberLabel: UILabel?
	var kmTextLabel: UILabel?
	
	var totalRunsNumberLabel: UILabel?
	var totalRunsTextLabel: UILabel?
	
	var paceNumberLabel: UILabel?
	var paceTextLabel: UILabel?
	
	let textWidth : CGFloat = 78.0
	
	var descriptionLabel : UILabel?
	var descriptionText : UITextView?
	
	var ratingView : RatingView?
	var memberNumberLabel : UILabel?
	var ratingValueNumber = Int()
	

	var workoutDetailVC : WorkoutViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor(fromHexString: "0C0E10")
		
		self.addViews()
	}
	
	func addViews() {
		
		workoutsImageView = StoreImageGradient.init(frame: CGRect(x: 20.0, y: 15.0, width: frame.width - 40.0, height: 205.0))
		workoutsImageView?.contentMode = .scaleAspectFill
		workoutsImageView?.layer.cornerRadius = 10.0
		workoutsImageView?.layer.masksToBounds = true
		addSubview(workoutsImageView!)
		
		
		workoutName = UILabel.init(frame: CGRect(x: ((frame.width - 305.0) * 0.5), y: 90.0, width: 305.0, height: 60.0))
		workoutName?.textAlignment = .center
		workoutName?.numberOfLines = 2
		workoutName?.textColor = UIColor.white
		workoutName?.layer.shadowOffset = .zero
		workoutName?.layer.shadowColor = UIColor.black.cgColor
		workoutName?.layer.shadowRadius = 2.0
		workoutName?.layer.shadowOpacity = 0.1
		workoutName?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightBlack)
		addSubview(workoutName!)
		
		workoutTimeLabel = UILabel.init(frame: CGRect(x: ((frame.width - 305.0) * 0.5), y: 145.0, width: 305.0, height: 20.0))
		workoutTimeLabel?.textAlignment = .center
		textSpacing(workoutTimeLabel!, spacing: 5.0)
		workoutTimeLabel?.textColor = UIColor.white
		workoutTimeLabel?.layer.shadowOffset = .zero
		workoutTimeLabel?.layer.shadowColor = UIColor.black.cgColor
		workoutTimeLabel?.layer.shadowRadius = 2.0
		workoutTimeLabel?.layer.shadowOpacity = 0.1
		workoutTimeLabel?.font = UIFont(name: "BebasNeueBold", size: 18)
		//addSubview(workoutTimeLabel!)
		
		
		self.clubStas()
		self.clubDetails()
		
	}
	
	func clubStas() {
		
		//	Distance Section
		kmNumberLabel = UILabel.init(frame: CGRect(x: 24.0, y: 265, width: textWidth, height: 46))
		kmNumberLabel?.text = "8.49"
		kmNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		kmNumberLabel?.textColor = UIColor.greyWhite()
		kmNumberLabel?.textAlignment = .center
		textSpacing(kmNumberLabel!, spacing: 2.4)
		addSubview(kmNumberLabel!)
		
		
		kmTextLabel = UILabel.init(frame: CGRect(x: 24.0, y: 315, width: textWidth, height: 20))
		kmTextLabel?.text = "total km"
		kmTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		kmTextLabel?.textColor = UIColor.greyBlackColor()
		kmTextLabel?.textAlignment = .center
		addSubview(kmTextLabel!)
		
		//	Total Runs
		var xPosition = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			xPosition = (window.frame.width - textWidth) * 0.5
			
		}
		
		totalRunsNumberLabel = UILabel.init(frame: CGRect(x: xPosition, y: 265, width: textWidth, height: 46))
		totalRunsNumberLabel?.text = "49"
		totalRunsNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		totalRunsNumberLabel?.textColor = UIColor.greyWhite()
		totalRunsNumberLabel?.textAlignment = .center
		textSpacing(totalRunsNumberLabel!, spacing: 2.4)
		addSubview(totalRunsNumberLabel!)
		
		
		totalRunsTextLabel = UILabel.init(frame: CGRect(x: xPosition, y: 315, width: textWidth, height: 20))
		totalRunsTextLabel?.text = "total runs"
		totalRunsTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		totalRunsTextLabel?.textColor = UIColor.greyBlackColor()
		totalRunsTextLabel?.textAlignment = .center
		addSubview(totalRunsTextLabel!)
		
		
		//	Average Pace
		
		var xEndPosition = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			xEndPosition = window.frame.width - textWidth - 24
			
		}
		paceNumberLabel = UILabel.init(frame: CGRect(x: xEndPosition, y: 265, width: textWidth, height: 46))
		paceNumberLabel?.text = "7:09"
		paceNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		paceNumberLabel?.textColor = UIColor.greyWhite()
		paceNumberLabel?.textAlignment = .center
		textSpacing(paceNumberLabel!, spacing: 2.4)
		addSubview(paceNumberLabel!)
		
		
		paceTextLabel = UILabel.init(frame: CGRect(x: xEndPosition, y: 315, width: textWidth, height: 20))
		paceTextLabel?.text = "mins/km"
		paceTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		paceTextLabel?.textColor = UIColor.greyBlackColor()
		paceTextLabel?.textAlignment = .center
		addSubview(paceTextLabel!)
	}
	
	func clubDetails() {
		
		descriptionLabel = UILabel.init(frame: CGRect(x: 20.0, y: 380.0, width: 200, height: 20.0))
		descriptionLabel?.text = "About"
		descriptionLabel?.textColor = UIColor.greyWhite()
		descriptionLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(descriptionLabel!)
		
		descriptionText = UITextView.init(frame: CGRect(x: 20.0, y: 415, width: frame.width - 40.0, height: 85))
		descriptionText?.textColor = UIColor.greyBlackColor()
		descriptionText?.backgroundColor = UIColor.clear
		descriptionText?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		descriptionText?.isEditable = false
		descriptionText?.isSelectable = false
		descriptionText?.isScrollEnabled = false
		addSubview(descriptionText!)
	}
	
	func handleShowProfile() {
		
		//workoutDetailVC?.handleOpenProfile()
		
	}
	
	
}

