//
//  WeekHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/05.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WeekHeaderView : BaseView {
	
	var closeButton : UIButton?
	var myRoutineLabel : UILabel?
	var headerDetailLabel : UILabel?
	var findWorkoutsButton : UIButton?
	
	var myRoutineVC : WeekViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		self.addViews()
		
	}
	
	func addViews() {
		
		closeButton = UIButton.init(frame: CGRect(x: frame.width - 45, y: 20.0, width: 30, height: 30))
		closeButton?.setImage(UIImage(named: "close"), for: UIControlState.normal)
		closeButton?.addTarget(self, action: #selector(handleClose), for: UIControlEvents.touchUpInside)
		addSubview(closeButton!)
		
		myRoutineLabel = UILabel.init(frame: CGRect(x: 0.0, y: 75.0, width: frame.width, height: 24))
		myRoutineLabel?.textAlignment = .center
		myRoutineLabel?.text = "My Routine"
		myRoutineLabel?.textColor = UIColor.offWhite()
		myRoutineLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy)
		addSubview(myRoutineLabel!)
		
		
		headerDetailLabel = UILabel.init(frame: CGRect(x: 25.0, y: 126.0, width: frame.width - 50.0, height: 70.0))
		headerDetailLabel?.textAlignment = .center
		headerDetailLabel?.text = "This is where your weekly workout routine will live. Get started by finding workouts that suit your goal."
		headerDetailLabel?.numberOfLines = 3
		textSpacing(headerDetailLabel!, spacing: 0.47)
		headerDetailLabel?.textColor = UIColor.greyBlackColor()
		headerDetailLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		addSubview(headerDetailLabel!)
		
		
		findWorkoutsButton = UIButton.init(frame: CGRect(x: 48.0, y: 232.0, width: frame.width - 96.0, height: 40.0))
		findWorkoutsButton?.setTitle("Find Workouts", for: UIControlState.normal)
		findWorkoutsButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
		findWorkoutsButton?.backgroundColor = UIColor.darkBlack()
		findWorkoutsButton?.layer.cornerRadius = 6.0
		findWorkoutsButton?.layer.masksToBounds = true
		findWorkoutsButton?.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		findWorkoutsButton?.addTarget(self, action: #selector(handleFindWorkouts), for: UIControlEvents.touchUpInside)
		addSubview(findWorkoutsButton!)
		
		
	}
	
	func handleFindWorkouts() {
		
		myRoutineVC.handleOpenDiscovery()
		
	}
	
	
	func handleClose() {
		
		myRoutineVC?.closeHeaderView()
		
	}
	
	
}
