//
//  WorkoutCompleteMenuBar.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutCompleteMenuBar: BaseView {
	
	var workoutCompleteVC : WorkoutCompleteVIewController?
	
	let completedLabel: UILabel = {
		
		let label = UILabel()
		label.text = "COMPLETED"
		label.font = UIFont(name: "BebasNeueBold", size: 25)
		label.textColor = UIColor.white
		label.textAlignment = .center
		textSpacing(label, spacing: 2)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let closeButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "close"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	
	let shareButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "shareVC")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
		button.tintColor = .white
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		self.addViews()
		
	}
	
	func addViews() {
		
		addSubview(closeButton)
		addSubview(shareButton)
		addSubview(completedLabel)
		
		closeButton.addTarget(self, action: #selector(handleClose), for: UIControlEvents.touchUpInside)
		shareButton.addTarget(self, action: #selector(handleShare), for: UIControlEvents.touchUpInside)
		
		completedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		completedLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25.0).isActive = true
		completedLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		completedLabel.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
		
		closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 13).isActive = true
		closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 34.0).isActive = true
		closeButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		closeButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
		shareButton.topAnchor.constraint(equalTo: topAnchor, constant: 27.0).isActive = true
		shareButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		shareButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		
	}
	
	func handleClose() {
		
		workoutCompleteVC?.handleDismiss()
		
	}
	
	func handleShare() {
		
		workoutCompleteVC?.handleShareProgress()
		
	}
	
	
}

