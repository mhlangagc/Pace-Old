//
//  ProfileWorkoutCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class WorkoutCellView : TableBaseCell {
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.darkBlack() : UIColor.black
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.darkBlack() : UIColor.black
		}
	}
	
	let workoutImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 8.5
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named : "featuredWorkout")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let workoutName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightBold)
		label.text = "Bigger Chest Workout"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let  workoutDetails: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
		label.textAlignment = .left
		label.text = "15 Exercises"
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
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
	}
	
	
	func setupView() {
		
		self.contentView.addSubview(workoutImage)
		self.contentView.addSubview(workoutName)
		self.contentView.addSubview(workoutDetails)
		self.contentView.addSubview(disclosureIndicator)
		self.contentView.addSubview(dividerLineView)
		
		workoutImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		workoutImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		workoutImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		workoutImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
		
		
		disclosureIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		disclosureIndicator.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
		disclosureIndicator.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		
		
		workoutName.leftAnchor.constraint(equalTo: workoutImage.rightAnchor, constant: 15.0).isActive = true
		workoutName.topAnchor.constraint(equalTo: topAnchor, constant: 35.0).isActive = true
		workoutName.rightAnchor.constraint(equalTo: disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		workoutName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		workoutDetails.leftAnchor.constraint(equalTo: workoutImage.rightAnchor, constant: 15.0).isActive = true
		workoutDetails.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 12.0).isActive = true
		workoutDetails.rightAnchor.constraint(equalTo:  disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		workoutDetails.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}
	
}
