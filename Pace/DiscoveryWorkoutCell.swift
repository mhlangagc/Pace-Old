//
//  NewWorkoutsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscoveryWorkoutCell: BaseCell {
	
	let workoutImageNode = ASNetworkImageNode()
	let workoutTitleNode = ASTextNode()
	let catergoryTitleNode = ASTextNode()
	let ratings = RatingsNodeView()
	
	let imageWidth : CGFloat = 200
	let imageHeight : CGFloat = 150
	
	let workoutNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold),
	                             NSForegroundColorAttributeName: UIColor.white,
	                             NSKernAttributeName: 1.0] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()
	

	let catergoryAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold),
	                           NSForegroundColorAttributeName: UIColor(fromHexString: "596A83")] as [String : Any]
	var trainerNameMutableString = NSMutableAttributedString()
	
	
	
	var  exploreWorkout : ExploreWorkoutModel? {
		
		didSet {
			
			workoutImageNode.url = NSURL(string: (exploreWorkout?.backgroundImageUrl!)!)! as URL
			
			if let workoutName = exploreWorkout?.name, let workoutCatergory = exploreWorkout?.workoutCatergory {
				
				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
				workoutTitleNode.attributedText = workoutNameMutableString
				
				trainerNameMutableString = NSMutableAttributedString(string: workoutCatergory.rawValue, attributes: catergoryAttributes)
				catergoryTitleNode.attributedText = trainerNameMutableString
				
			}
			
			
		}
	}

	
	
	
	
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.clear
		self.setupWorkoutDetails()
		
	}
	
	func setupWorkoutDetails() {

		workoutImageNode.image = UIImage(named: "newWorkout")
		workoutImageNode.backgroundColor = UIColor.darkBlack()
		workoutImageNode.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
		workoutImageNode.layer.cornerRadius = 8.0
		workoutImageNode.clipsToBounds = true
		addSubnode(workoutImageNode)
		

		workoutTitleNode.maximumNumberOfLines = 2
		addSubnode(workoutTitleNode)

		
		catergoryTitleNode.maximumNumberOfLines = 1
		addSubnode(catergoryTitleNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		workoutImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		workoutTitleNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: imageWidth - 10)
		catergoryTitleNode.style.preferredSize = CGSize(width: imageWidth - 10, height: 20)
		
		let layoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                           spacing: 8,
		                                           justifyContent: .start,
		                                           alignItems: .start,
		                                           children: [workoutImageNode, workoutTitleNode, catergoryTitleNode])
		
		
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 18.0, left: 0.0, bottom: 37.0, right: 0.0), child: layoutSpec)
		
		
	}
	
	
	
}



