//
//  WorkoutProcessMenuBar.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutProcessMenuBar: BaseView {
	
	var workoutProcessVC : WorkoutProcessViewController?
	
	let timerLabel: UILabel = {
		
		let label = UILabel()
		label.text = "00:00"
		label.font = UIFont(name: "BebasNeueBold", size: 40)
		label.textColor = UIColor.white
		label.textAlignment = .center
		textSpacing(label, spacing: 5.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let cancelButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "more"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	
	let endButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "more"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	let dividerLineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
		
	}
	
	func addViews() {
		
//		addSubview(cancelButton)
		addSubview(endButton)
		addSubview(timerLabel)
		addSubview(dividerLineView)
		
		cancelButton.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		endButton.addTarget(self, action: #selector(handleEnd), for: UIControlEvents.touchUpInside)
		
		timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25.0).isActive = true
		timerLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		timerLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
		
//		cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
//		cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 32.0).isActive = true
//		cancelButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//		cancelButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		endButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
		endButton.topAnchor.constraint(equalTo: topAnchor, constant: 32.0).isActive = true
		endButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		endButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}
	
	func handleEnd() {
		
		workoutProcessVC?.handleEndWorkout()
	}
	
	func handleCancel() {
		
		workoutProcessVC?.handleDismiss()
		
	}
	
	
}
