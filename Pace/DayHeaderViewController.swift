//
//  DayHeaderViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/27.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class DayHeaderViewController : BaseView {
	
	var workoutsImageView: StoreImageGradient?
	var workoutName : UILabel?
	var workoutTimeLabel : UILabel?
	
	var profileImageView : UIImageView?
	var profileNameButton : UIButton?
	
	var dayDetailVC : DayViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		
		self.addViews()
	}
	
	func addViews() {
		
		workoutsImageView = StoreImageGradient.init(frame: CGRect(x: 20.0, y: 15.0, width: frame.width - 40.0, height: 230.0))
		workoutsImageView?.contentMode = .scaleAspectFill
		workoutsImageView?.layer.cornerRadius = 10.0
		workoutsImageView?.layer.masksToBounds = true
		addSubview(workoutsImageView!)
		
		
		workoutName = UILabel.init(frame: CGRect(x: ((frame.width - 305.0) * 0.5), y: 93.0, width: 305.0, height: 60.0))
		workoutName?.textAlignment = .center
		workoutName?.numberOfLines = 2
		workoutName?.textColor = UIColor.white
		workoutName?.layer.shadowOffset = .zero
		workoutName?.layer.shadowColor = UIColor.black.cgColor
		workoutName?.layer.shadowRadius = 2.0
		workoutName?.layer.shadowOpacity = 0.1
		workoutName?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightBlack)
		addSubview(workoutName!)
		
		workoutTimeLabel = UILabel.init(frame: CGRect(x: ((frame.width - 305.0) * 0.5), y: 155.0, width: 305.0, height: 20.0))
		workoutTimeLabel?.textAlignment = .center
		workoutTimeLabel?.text = "25 min workout"
		textSpacing(workoutTimeLabel!, spacing: 2.5)
		workoutTimeLabel?.textColor = UIColor.white
		workoutTimeLabel?.layer.shadowOffset = .zero
		workoutTimeLabel?.layer.shadowColor = UIColor.black.cgColor
		workoutTimeLabel?.layer.shadowRadius = 2.0
		workoutTimeLabel?.layer.shadowOpacity = 0.1
		workoutTimeLabel?.font = UIFont(name: "BebasNeueBold", size: 18)
		addSubview(workoutTimeLabel!)
		
		
		profileImageView = UIImageView.init(frame: CGRect(x: 20.0, y: 267.0, width: 40.0, height: 40.0))
		profileImageView?.contentMode = .scaleAspectFill
		profileImageView?.isUserInteractionEnabled = true
		profileImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowProfile)))
		profileImageView?.layer.cornerRadius = 20.0
		profileImageView?.layer.masksToBounds = true
		addSubview(profileImageView!)
		
		
		profileNameButton = UIButton.init(frame: CGRect(x: 70.0, y: 275.0, width: frame.width - 90.0, height: 20.0))
		profileNameButton?.contentHorizontalAlignment = .left
		profileNameButton?.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		profileNameButton?.addTarget(self, action: #selector(handleShowProfile), for: UIControlEvents.touchUpInside)
		profileNameButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(profileNameButton!)
		
		
	}
	
	func handleShowProfile() {
		
		print("Show Profile")
		
		dayDetailVC?.handleOpenProfile()
		
	}
	
	
}
