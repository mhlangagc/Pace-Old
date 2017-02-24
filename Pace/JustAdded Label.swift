//
//  NewWorkoutsCollection.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class JustAddedLabel: BaseCell {
	
	var discoveryVC : ExploreViewController?
	let newWorkoutLabel = ASTextNode()
	let seeAllButton = ASButtonNode()
	
	let categoryTitle = "Popular on Pace"
	
	lazy var ExploreWorkoutSetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	
	override func setupNodes() {
		super.setupNodes()
		
		self.newWorkoutsLabelSetup()
		//self.seeAllButtonNode()
		
		backgroundColor = UIColor.black
		
		
	}
	
	
	func newWorkoutsLabelSetup() {
		
		let alignmentStyle = NSMutableParagraphStyle()
		alignmentStyle.alignment = NSTextAlignment.left
		newWorkoutLabel.attributedText = NSAttributedString(
			string: categoryTitle,
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.greyBlackColor(),
				NSKernAttributeName: 0.0,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(newWorkoutLabel)
		
	}
	
	func seeAllButtonNode() {
		
		seeAllButton.setImage(UIImage(named: "seeAllButton"), for: ASControlState())
		seeAllButton.style.preferredSize = CGSize(width: 20.0, height: 20.0)
		//seeAllButton.addTarget(self, action: #selector(handleViewAll), forControlEvents: ASControlNodeEvent.touchUpInside)
		//addSubnode(seeAllButton)
		
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		
		newWorkoutLabel.style.preferredSize = CGSize(width: constrainedSize.max.width - 130.0, height: 25.0)
		let labelAndButtonStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 75,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [newWorkoutLabel, seeAllButton])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 20.0, bottom: 15, right: 15), child: labelAndButtonStackSpec)
		
		
	}
	
	
	func handleViewAll() {
		
//		discoveryVC?.exploreWorkoutsToPass = ExploreWorkoutSetup.setupNewWorkouts()
//		discoveryVC?.allWorkoutsTitle = categoryTitle
//		discoveryVC?.handleSeeAllWorkouts()
		
	}
	
	
	
}

