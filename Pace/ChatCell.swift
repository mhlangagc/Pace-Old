//
//  ChatCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatCell: TableBaseCell {
	
	let trainerImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 70 * 0.5
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named : "3")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let groupName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightBold)
		label.text = "Bigger Chest Workout"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let  numberOfMembersLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
		label.textAlignment = .left
		label.text = "3,904 Members"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let disclosureIndicator: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "DisclosureIndicator")
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
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
	}
	
	func setupView() {
		
		self.contentView.addSubview(trainerImage)
		self.contentView.addSubview(groupName)
		self.contentView.addSubview(numberOfMembersLabel)
		self.contentView.addSubview(disclosureIndicator)
		self.contentView.addSubview(dividerLineView)
		
		trainerImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		trainerImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		trainerImage.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
		trainerImage.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
		
		
		disclosureIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		disclosureIndicator.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
		disclosureIndicator.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		
		
		groupName.leftAnchor.constraint(equalTo: trainerImage.rightAnchor, constant: 15.0).isActive = true
		groupName.topAnchor.constraint(equalTo: topAnchor, constant: 35.0).isActive = true
		groupName.rightAnchor.constraint(equalTo: disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		groupName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		numberOfMembersLabel.leftAnchor.constraint(equalTo: trainerImage.rightAnchor, constant: 15.0).isActive = true
		numberOfMembersLabel.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 10.0).isActive = true
		numberOfMembersLabel.rightAnchor.constraint(equalTo:  disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		numberOfMembersLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}

}
