//
//  WeekTableNodeCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class WeekTableCell: TableBaseCell {
	
	let todayIndicatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.headerBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let dayNameLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .left
		textSpacing(label, spacing: 1.0)
		label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let  workoutNameText: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.thursday()
		label.font = UIFont.systemFont(ofSize: 25.0, weight: UIFontWeightBold)
		label.textAlignment = .left
		textSpacing(label, spacing: 0.54)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let activityIndicator: UIImageView = {
		
		let imageView = UIImageView()
		imageView.image = UIImage(named: "activityCheck")
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	var  routineModel : WorkoutDaysModel? {
		
		didSet {
			
			if let weekDayName  = routineModel?.dayName {
				
				dayNameLabel.text = weekDayName.uppercased()[0...2]
				
			}
			
			if let workoutName  = routineModel?.workoutName, let dayColor = routineModel?.color { //	UIColor(fromHexString: routineModel?.colour) {
				
				workoutNameText.text = workoutName
				workoutNameText.textColor = dayColor
				
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
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupObjectsView()
	}
	
	
	func setupObjectsView() {
		
		self.contentView.addSubview(todayIndicatorView)
		self.contentView.addSubview(dayNameLabel)
		self.contentView.addSubview(workoutNameText)
		self.contentView.addSubview(activityIndicator)
		
		todayIndicatorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		todayIndicatorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		todayIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		todayIndicatorView.widthAnchor.constraint(equalToConstant: 3.0).isActive = true
		
		
		activityIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		activityIndicator.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		activityIndicator.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		
		dayNameLabel.leftAnchor.constraint(equalTo: todayIndicatorView.rightAnchor, constant: 17.0).isActive = true
		dayNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
		dayNameLabel.rightAnchor.constraint(equalTo: activityIndicator.leftAnchor, constant: -10).isActive = true
		dayNameLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
		
		
		workoutNameText.leftAnchor.constraint(equalTo: todayIndicatorView.rightAnchor, constant: 17.0).isActive = true
		workoutNameText.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor, constant: 10.0).isActive = true
		workoutNameText.rightAnchor.constraint(equalTo: activityIndicator.leftAnchor, constant: -10).isActive = true
		workoutNameText.heightAnchor.constraint(equalToConstant: 27.0).isActive = true
		
		
	}
		
}
