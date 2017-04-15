//
//  ShareButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/15.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ShareButtonView: BaseView {
	
	var completedWorkoutVC: CompletedRunViewController?
	
	lazy var startWorkoutButton: UIButton = {
		
		let button = UIButton()
		button.setTitle("SHARE", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		textSpacing((button.titleLabel)!, spacing: 1.0)
		button.backgroundColor = UIColor.paceBrandColor()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.addTarget(self, action: #selector(handleStartRun), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let line: UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor(fromHexString: "272932")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .black
		
		addSubview(startWorkoutButton)
		addSubview(line)
		
		startWorkoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		startWorkoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		startWorkoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		startWorkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
		
		line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
		
	}
	
	func handleStartRun() {
		
		completedWorkoutVC?.handleShareWorkout()
		
	}
}
