//
//  ExerciseCellView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/26.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

protocol VideoCellDelegate {
	
	func didBeginVideo(cell: ExerciseCellView)
	func didEndBeginVideoView(cell: ExerciseCellView)
	
}

class ExerciseCellView : TableBaseCell {
	
	
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
		label.text = "5 mins"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let disclosureIndicator: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "downIndicator")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	
	let dividerLineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.headerBlack()
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
	
	var videoDelegate : VideoCellDelegate?
	var cellSelected = false
	var recognizer : UITapGestureRecognizer?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
		
		recognizer = UITapGestureRecognizer(target: self, action: #selector(handleCellSelected))
		recognizer?.delegate = self
		addGestureRecognizer(recognizer!)
		
	}
	
	func handleCellSelected() {
  
		if videoDelegate != nil {
			
			videoDelegate!.didBeginVideo(cell: self)
			cellSelected = true
			recognizer = UITapGestureRecognizer(target: self, action: #selector(handleDeleselectedCell))
			
		}
		
	}
 
	func handleDeleselectedCell() {
		
		if videoDelegate != nil {
			
			videoDelegate!.didEndBeginVideoView(cell: self)
			cellSelected = false
			recognizer = UITapGestureRecognizer(target: self, action: #selector(handleCellSelected))
			
		}
		
	}
	
	func setupView() {
		
		self.contentView.addSubview(exerciseImage)
		self.contentView.addSubview(exerciseName)
		self.contentView.addSubview(exerciseDetails)
		self.contentView.addSubview(disclosureIndicator)
		self.contentView.addSubview(dividerLineView)
		
		exerciseImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		exerciseImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		exerciseImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		exerciseImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
		
		
		disclosureIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		disclosureIndicator.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
		disclosureIndicator.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		
		
		exerciseName.leftAnchor.constraint(equalTo: exerciseImage.rightAnchor, constant: 15.0).isActive = true
		exerciseName.topAnchor.constraint(equalTo: topAnchor, constant: 35.0).isActive = true
		exerciseName.rightAnchor.constraint(equalTo: disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		exerciseName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		exerciseDetails.leftAnchor.constraint(equalTo: exerciseImage.rightAnchor, constant: 15.0).isActive = true
		exerciseDetails.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 10.0).isActive = true
		exerciseDetails.rightAnchor.constraint(equalTo:  disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		exerciseDetails.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}
	
}
