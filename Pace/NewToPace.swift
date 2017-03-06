//
//  PopularOnPaceLabel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PopularLabel: BaseCell {
	
	var discoveryVC : ExploreViewController?
	let newWorkoutLabel = ASTextNode()
	let descriptionLabel = ASTextNode()
	let seeAllButton = ASButtonNode()
	
	override func setupNodes() {
		super.setupNodes()
		
		self.newWorkoutsLabelSetup()
		self.seeAllButtonNode()
		
		backgroundColor = UIColor.black
		
	}
	
	
	func newWorkoutsLabelSetup() {
		
		let alignmentStyle = NSMutableParagraphStyle()
		alignmentStyle.alignment = NSTextAlignment.left
		newWorkoutLabel.attributedText = NSAttributedString(
			string: "Free Workouts",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.greyBlackColor(),
				NSKernAttributeName: 0.0,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(newWorkoutLabel)
		
		descriptionLabel.attributedText = NSAttributedString(
			string: "Because it's your first month here",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold),
				NSForegroundColorAttributeName: UIColor.greyBlackColor(),
				NSKernAttributeName: 0.47,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(descriptionLabel)
		
	}
	
	func seeAllButtonNode() {
		
		seeAllButton.setImage(UIImage(named: "seeAllButton"), for: UIControlState())
		seeAllButton.style.preferredSize = CGSize(width: 20.0, height: 20.0)
		seeAllButton.addTarget(self, action: #selector(handleViewAll), forControlEvents: ASControlNodeEvent.touchUpInside)
		//addSubnode(seeAllButton)
		
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		
		newWorkoutLabel.style.preferredSize = CGSize(width: constrainedSize.max.width - 130.0, height: 25.0)
		descriptionLabel.style.preferredSize = CGSize(width: constrainedSize.max.width - 40, height: 20.0)
		
		let labelsSpec = ASStackLayoutSpec(direction: .vertical,
		                                                spacing: 5,
		                                                justifyContent: .start,
		                                                alignItems: .start,
		                                                children: [newWorkoutLabel, descriptionLabel])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 20.0, bottom: 0, right: 15), child: labelsSpec)
		
		
	}
	
	
	func handleViewAll() {
		
		discoveryVC!.handleSeeAllWorkouts()
		
	}
	
	
	
}
