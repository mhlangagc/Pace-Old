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
			backgroundColor = isHighlighted ? UIColor.darkBlack() : UIColor.paceBackgroundBlack()
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.darkBlack() : UIColor.paceBackgroundBlack()
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
		label.text = "-"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let imageOverlayView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0.0, alpha: 0.55)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let workoutTimeLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.textAlignment = .center
		label.font = UIFont(name: "BebasNeueBold", size: 17)
		textSpacing(label, spacing: 1.0)
		label.text = "15 MINS"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let  workoutDetails: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
		label.textAlignment = .left
		label.text = "- Exercises"
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
	
	
	var  workoutModel : ExploreWorkoutModel? {
		
		didSet {
			
			if let workoutNameFound = workoutModel?.name, let workoutImageUrl = workoutModel?.backgroundImageUrl {
				
				workoutName.text = workoutNameFound
				workoutImage.loadImageFromCacheWithUrlString(urlString: workoutImageUrl)
				
			}
			
			if let workoutTime = workoutModel?.time {
				
				workoutTimeLabel.text = "\(workoutTime) mins"
			}
			
			
		}
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.paceBackgroundBlack()
		self.setupView()
		
	}
	
	
	func setupView() {
		
		self.contentView.addSubview(workoutImage)
		workoutImage.addSubview(imageOverlayView)
		imageOverlayView.addSubview(workoutTimeLabel)
		self.contentView.addSubview(workoutName)
		self.contentView.addSubview(workoutDetails)
		self.contentView.addSubview(disclosureIndicator)
		self.contentView.addSubview(dividerLineView)
		
		workoutImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		workoutImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		workoutImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		workoutImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
		
		imageOverlayView.leftAnchor.constraint(equalTo: workoutImage.leftAnchor).isActive = true
		imageOverlayView.rightAnchor.constraint(equalTo: workoutImage.rightAnchor).isActive = true
		imageOverlayView.topAnchor.constraint(equalTo: workoutImage.topAnchor).isActive = true
		imageOverlayView.bottomAnchor.constraint(equalTo: workoutImage.bottomAnchor).isActive = true
		
		
		workoutTimeLabel.leftAnchor.constraint(equalTo: imageOverlayView.leftAnchor).isActive = true
		workoutTimeLabel.centerYAnchor.constraint(equalTo: imageOverlayView.centerYAnchor).isActive = true
		workoutTimeLabel.rightAnchor.constraint(equalTo: imageOverlayView.rightAnchor).isActive = true
		workoutTimeLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
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
