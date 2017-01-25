//
//  WeekTableNodeCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class WeekTableNodeCell: BaseCell {
	
	var todayIndicator = ASDisplayNode()
	var weekNameText = ASTextNode()
	var workoutNameText = ASTextNode()
	var activityIndicator = ASImageNode()
	
	
	let dayNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold), NSForegroundColorAttributeName: UIColor.greyBlackColor(), NSKernAttributeName: 1.0 ] as [String : Any]
	let workoutNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 25, weight: UIFontWeightBold), NSKernAttributeName: 0.54] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()
	
	var  routineModel : WeekRoutineModel? {
		
		didSet {
			
			if let weekDayName  = routineModel?.dayName {
				
				weekNameText.attributedText = NSMutableAttributedString(string: weekDayName.uppercased()[0...2], attributes: dayNameAttributes)
				
			}
			
			
			if let workoutName  = routineModel?.workoutName, let dayColor = routineModel?.color {
				
				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
				let stringLength = NSString(string: workoutName).length
				workoutNameMutableString.addAttribute(NSForegroundColorAttributeName,
				                                      value: dayColor,
				                                      range: NSRange(
														location: 0,
														length: stringLength))
				
				workoutNameText.attributedText = workoutNameMutableString
				
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
	
	
	override func setupNodes() {
		
		super.setupNodes()
		self.setupWorkoutDetails()
		
		backgroundColor = .black
		
	}
	
	func setupWorkoutDetails() {
		
		
		todayIndicator.backgroundColor = UIColor.darkBlack()
		addSubnode(todayIndicator)
		
		
		addSubnode(weekNameText)
		
		
		workoutNameText.attributedText = NSMutableAttributedString(string: "Chest & Shoulders",
		                                                           attributes: [NSForegroundColorAttributeName: UIColor.wednesday(),
		                                                                        NSFontAttributeName: UIFont.systemFont(ofSize: 25, weight: UIFontWeightBold),
		                                                                        NSKernAttributeName: 0.54
						])
		addSubnode(workoutNameText)
		
		
		
		activityIndicator.image = UIImage(named: "activityCheck")
		activityIndicator.contentMode = .scaleAspectFit
		activityIndicator.clipsToBounds = true
		addSubnode(activityIndicator)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		todayIndicator.style.preferredSize = CGSize(width: 2.5, height: 85.0)
		weekNameText.style.preferredSize = CGSize(width: 65.0, height: 20.0)
		workoutNameText.style.preferredSize = CGSize(width: constrainedSize.max.width - 70.0, height: 30.0)
		activityIndicator.style.preferredSize = CGSize(width: 30.0, height: 30.0)
		
		let textDetailsSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 10,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [weekNameText, workoutNameText])
		
		let textindicatorSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 3.0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [textDetailsSpec, activityIndicator])
		
		
		let todayIndicatoranDetailSpec = ASStackLayoutSpec(direction: .horizontal,
		                                                   spacing: 17.0,
		                                                   justifyContent: .center,
		                                                   alignItems: .center,
		                                                   children: [todayIndicator, textindicatorSpec])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 15.0), child: todayIndicatoranDetailSpec)
		
	}

	
}
