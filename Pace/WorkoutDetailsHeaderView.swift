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
	
	var profileImageView : UIImageView?
	var profileNameButton : UIButton?
	
	var descriptionLabel : UILabel?
	var descriptionText : UITextView?
	
	var ratingView : RatingView?
	var reviewLabel : UILabel?
	var ratingValueNumber = Int()
	

	var workoutDetailVC : WorkoutViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		
		self.addViews()
	}
	
	func addViews() {
		
		workoutsImageView = StoreImageGradient.init(frame: CGRect(x: 20.0, y: 15.0, width: frame.width - 40.0, height: 205.0))
		workoutsImageView?.contentMode = .scaleAspectFill
		workoutsImageView?.layer.cornerRadius = 10.0
		workoutsImageView?.layer.masksToBounds = true
		addSubview(workoutsImageView!)
		
		
		workoutName = UILabel.init(frame: CGRect(x: ((frame.width - 305.0) * 0.5), y: 80.0, width: 305.0, height: 60.0))
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
		addSubview(workoutTimeLabel!)
		
		
		
		profileImageView = UIImageView.init(frame: CGRect(x: frame.width - 60.0, y: 250.0, width: 40.0, height: 40.0))
		profileImageView?.contentMode = .scaleAspectFill
		profileImageView?.isUserInteractionEnabled = true
		profileImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowProfile)))
		profileImageView?.layer.cornerRadius = 20.0
		profileImageView?.clipsToBounds = true
		addSubview(profileImageView!)
		
		profileNameButton = UIButton.init(frame: CGRect(x: 20.0, y: 260.0, width: frame.width - 90.0, height: 20.0))
		profileNameButton?.contentHorizontalAlignment = .left
		profileNameButton?.setTitleColor(UIColor.greyWhite(), for: UIControlState.normal)
		profileNameButton?.addTarget(self, action: #selector(handleShowProfile), for: UIControlEvents.touchUpInside)
		profileNameButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(profileNameButton!)
		
		
		
		descriptionLabel = UILabel.init(frame: CGRect(x: 20.0, y: 320, width: 200, height: 20.0))
		descriptionLabel?.text = "What you get"
		descriptionLabel?.textColor = UIColor.greyWhite()
		descriptionLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(descriptionLabel!)
		
		descriptionText = UITextView.init(frame: CGRect(x: 20.0, y: 355, width: frame.width - 40.0, height: 85))
		descriptionText?.textColor = UIColor.greyBlackColor()
		descriptionText?.backgroundColor = UIColor.clear
		descriptionText?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		descriptionText?.isEditable = false
		descriptionText?.isSelectable = false
		descriptionText?.isScrollEnabled = false
		addSubview(descriptionText!)
		
		
		
		
		
		reviewLabel = UILabel.init(frame: CGRect(x: 20.0, y: 470.0, width: 150.0, height: 20.0))
		reviewLabel?.textColor = UIColor.greyWhite()
		reviewLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(reviewLabel!)
		
		ratingView = RatingView.init(frame: CGRect(x: frame.width - 145, y: 470.0, width: 117.0, height: 18.0))
		ratingView?.ratingValue = 4
		addSubview(ratingView!)
		
	}
	
	func handleShowProfile() {
		
		workoutDetailVC?.handleOpenProfile()
		
	}
	
	
}

