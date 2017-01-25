//
//  WorkoutsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class WorkoutsCell: BaseCell {
	
	let workoutImageNode = ASImageNode()
	let workoutTitleNode = ASTextNode()
	let workoutDetails = ASTextNode()
	
	//	Workout Name
	let workoutNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold),
	                             NSForegroundColorAttributeName: UIColor.white] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()

	//	Price
	let detailsAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold),
	                       NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var detailsMutableString = NSMutableAttributedString()
	
//	var exploreWorkout : ExploreModel? {
//		
//		didSet {
//			
//			if let workoutFeaturedImage  = exploreWorkout?.workoutImage, let workoutName = exploreWorkout?.workoutName, let reviewNumber = exploreWorkout?.numberOfReviews, let price = exploreWorkout?.workoutPrice {
//				
//				workoutImageNode.image = workoutFeaturedImage
//				
//				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
//				workoutTitleNode.attributedText = workoutNameMutableString
//				
//				detailsMutableString = NSMutableAttributedString(string: "\(reviewNumber)    •    R\(price.rawValue)", attributes: detailsAttributes)
//				workoutDetails.attributedText = detailsMutableString
//				
//			}
//			
//		}
//	}
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupWorkoutDetails()
		
	}
	
	func setupWorkoutDetails() {
		
		//	Image
		workoutImageNode.image = UIImage(named: "21")
		workoutImageNode.backgroundColor = UIColor.darkBlack()
		workoutImageNode.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
		workoutImageNode.layer.cornerRadius = 9.5
		workoutImageNode.shouldRasterizeDescendants = true
		workoutImageNode.clipsToBounds = true
		addSubnode(workoutImageNode)
		
		//	Title
		workoutTitleNode.maximumNumberOfLines = 2
		workoutNameMutableString = NSMutableAttributedString(string: "Legs & Butt Workout", attributes: workoutNameAttributes)
		workoutTitleNode.attributedText = workoutNameMutableString
		addSubnode(workoutTitleNode)
		
		//	Workouts Details
		detailsMutableString = NSMutableAttributedString(string: "For Legs", attributes: detailsAttributes)
		workoutDetails.attributedText = detailsMutableString
		workoutDetails.maximumNumberOfLines = 1
		addSubnode(workoutDetails)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		workoutImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 180.0)
		workoutDetails.style.preferredSize = CGSize(width: 165.0, height: 22)
		
		let imageAndTitlesSpec = ASStackLayoutSpec(direction: .vertical,
		                                           spacing: 14.0,
		                                           justifyContent: .start,
		                                           alignItems: .start,
		                                           children: [workoutImageNode, workoutTitleNode])
		
		
		let titleAndRatingsSpec = ASStackLayoutSpec(direction: .vertical,
		                                            spacing: 6.0,
		                                            justifyContent: .start,
		                                            alignItems: .start,
		                                            children: [imageAndTitlesSpec, workoutDetails])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 15.0, right: 20.0), child: titleAndRatingsSpec)
		
		
	}
	
	
	
}

