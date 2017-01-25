//
//  NewsDetailsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class NewsDetailsCell : CollectionViewBaseCell {
	
	var newsCollectionCell : NewsCollectionCell?
	
	var newsModel : ActivityNewsModel? {
		
		didSet {
			
			if let trainerName = newsModel?.trainerName, let trainerImage  = newsModel?.trainerImage, let workoutImage = newsModel?.workoutImage, let workoutName = newsModel?.workoutName {
				
				profileImageView.image = trainerImage
				trainerNameLabel.text = trainerName
				detailLabel.text = "Created the \(workoutName) Workout"
				workoutImageView.image = workoutImage
			}
			
		}
	}
	
	
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
	
	let profileImageView : UIImageView = {
	
		let iv = UIImageView()
		iv.isUserInteractionEnabled = true
		iv.contentMode = .scaleAspectFill
		iv.backgroundColor = UIColor.darkBlack()
		iv.layer.masksToBounds = true
		iv.layer.cornerRadius = 30.0
		iv.translatesAutoresizingMaskIntoConstraints = false
		return iv
		
		
	}()
	
	let trainerNameLabel : UILabel = {
		
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		label.textColor = UIColor(fromHexString: "CBD7ED")
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let detailLabel : UILabel = {
		
		let label = UILabel()
		label.text = "Just created the Boxing Workout"
		label.numberOfLines = 2
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.textColor = UIColor.greyBlackColor()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let workoutImageView : UIImageView = {
		
		let iv = UIImageView()
		iv.image = UIImage(named: "newWorkout")
		iv.contentMode = .scaleAspectFill
		iv.backgroundColor = UIColor.darkBlack()
		iv.layer.masksToBounds = true
		iv.layer.cornerRadius = 8.0
		iv.translatesAutoresizingMaskIntoConstraints = false
		return iv
		
		
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		
		self.createViews()
		
	}
	
	
	
	func createViews() {
		
		addSubview(profileImageView)
		addSubview(trainerNameLabel)
		addSubview(detailLabel)
		addSubview(workoutImageView)
		
		profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
		profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		
		trainerNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15.0).isActive = true
		trainerNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
		trainerNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -85.0).isActive = true
		trainerNameLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
		
		detailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15.0).isActive = true
		detailLabel.topAnchor.constraint(equalTo: trainerNameLabel.bottomAnchor, constant: 5.0).isActive = true
		detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -85.0).isActive = true
		detailLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		
		workoutImageView.leftAnchor.constraint(equalTo: detailLabel.rightAnchor, constant: 10.0).isActive = true
		workoutImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		workoutImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		workoutImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		workoutImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true

		
		
	}
	
}

