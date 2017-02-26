//
//  WorkoutProcessCellView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutProcessCellView : TableBaseCell {
	
	let exerciseImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 9.5
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named : "box")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let exerciseName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightBold)
		label.text = "Leg Stretches"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let  exerciseDetails: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
		label.textAlignment = .left
		label.text = "3 Sets      10 Reps"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let timerButton : UIButton = {
		
		let button = UIButton()
		button.backgroundColor = UIColor.darkerBlack()
		button.tintColor = UIColor.greyBlackColor()
		button.setImage(UIImage(named: "smallTimer")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
		button.layer.cornerRadius = 10.0
		button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	let dividerLineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkerBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	/*
	var exerciseModel : ExerciseModel? {
		
		didSet {
			
			if let name  = exerciseModel?.exerciseName, let image = exerciseModel?.exerciseImage {
				
				exerciseImage.image = image
				
				exerciseName.text = name
				
				
			}
			
			if let exerciseCatergory = exerciseModel?.exerciseType {
				
				if exerciseCatergory == .cardio, let duration = exerciseModel?.durationOrSets, let distance = exerciseModel?.distanceOrReps {
					
					if distance.intValue == 0 {
						
						exerciseDetails.text = "\(duration) mins"
						
					} else {
						
						exerciseDetails.text = "\(duration) mins   \(distance) km"
						
					}
					
					
					
				} else if exerciseCatergory == .strength, let sets = exerciseModel?.durationOrSets, let reps = exerciseModel?.distanceOrReps, let weight = exerciseModel?.weight {
					
					if weight.intValue == 0 {
						
						exerciseDetails.text = "\(sets) sets    \(reps) reps"
						
					} else {
						
						exerciseDetails.text = "\(sets) sets    \(reps) reps    \(weight) kg"
						
					}
					
					
				} else if exerciseCatergory == .stretch, let duration = exerciseModel?.durationOrSets {
					
					exerciseDetails.text = "\(duration) mins"
					
					
				}
				
			}
			
		}
	}
	*/
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
	}
	
	
	func setupView() {
		
		self.contentView.addSubview(exerciseImage)
		self.contentView.addSubview(exerciseName)
		self.contentView.addSubview(exerciseDetails)
		self.contentView.addSubview(timerButton)
		self.contentView.addSubview(dividerLineView)
		
		exerciseImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		exerciseImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		exerciseImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		exerciseImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
		
		
		timerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		timerButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		timerButton.widthAnchor.constraint(equalToConstant: 37.0).isActive = true
		timerButton.heightAnchor.constraint(equalToConstant: 37.0).isActive = true
		
		
		exerciseName.leftAnchor.constraint(equalTo: exerciseImage.rightAnchor, constant: 15.0).isActive = true
		exerciseName.topAnchor.constraint(equalTo: topAnchor, constant: 36.0).isActive = true
		exerciseName.rightAnchor.constraint(equalTo: timerButton.leftAnchor, constant: -5.0).isActive = true
		exerciseName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		exerciseDetails.leftAnchor.constraint(equalTo: exerciseImage.rightAnchor, constant: 15.0).isActive = true
		exerciseDetails.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 10.0).isActive = true
		exerciseDetails.rightAnchor.constraint(equalTo:  timerButton.leftAnchor, constant: -5.0).isActive = true
		exerciseDetails.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}
	
}
