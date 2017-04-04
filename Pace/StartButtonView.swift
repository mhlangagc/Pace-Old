//
//  StartButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/13.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class StartButtonView : BaseView {
	
	var startButton: UIButton?
	
	var dayDetailsVC : DayViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .black
		self.setupButton()
		
	}
	
	func setupButton() {
		
		startButton = UIButton()
		startButton?.frame = CGRect(x: 20.0, y: 15.0, width: frame.width - 40.0, height: 47.5)
		startButton?.setTitle("start workout".uppercased(), for: UIControlState.normal)
		startButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
		startButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		textSpacing((startButton?.titleLabel)!, spacing: 1.0)
		startButton?.layer.cornerRadius = 10.0
		startButton?.layer.masksToBounds = true
		startButton?.addTarget(self, action: #selector(handleStart), for: UIControlEvents.touchUpInside)
		addSubview(startButton!)
		
	}
	
	
	func handleStart() {
		
		//dayDetailsVC?.startWorkout()
		
	}
	
}


class JoinButtonView : BaseView {
	
	var joinButton: UIButton?
	
	var workoutVC : WorkoutViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .black
		self.setupButton()
		
	}
	
	func setupButton() {
		
		joinButton = UIButton()
		joinButton?.frame = CGRect(x: 20.0, y: 15.0, width: frame.width - 40.0, height: 47.5)
		joinButton?.setTitle("join club".uppercased(), for: UIControlState.normal)
		joinButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
		joinButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		textSpacing((joinButton?.titleLabel)!, spacing: 1.0)
		joinButton?.layer.cornerRadius = 8.0
		joinButton?.layer.masksToBounds = true
		joinButton?.addTarget(self, action: #selector(handleJoinClub), for: UIControlEvents.touchUpInside)
		addSubview(joinButton!)
		
	}
	
	
	func handleJoinClub() {
		
		workoutVC?.joinClub()
		
	}
	
}


