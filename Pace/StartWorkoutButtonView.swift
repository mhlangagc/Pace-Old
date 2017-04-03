//
//  StartWorkoutButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class StartWorkoutButtonView: BaseView {
	
	var clubChatVC: ClubChatViewController?
	
	lazy var startWorkoutButton: UIButton = {
		
		let button = UIButton()
		button.setTitle("START RUN", for: UIControlState.normal)
		button.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		textSpacing((button.titleLabel)!, spacing: 1.0)
		button.backgroundColor = UIColor(fromHexString: "14161B")
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.addTarget(self, action: #selector(handleStartRun), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .paceBackgroundBlack()
		
		addSubview(startWorkoutButton)
		
		startWorkoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		startWorkoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		startWorkoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		startWorkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
		
	}
	
	func handleStartRun() {
	
		clubChatVC?.handleStartWorkout()
	
	}
}
