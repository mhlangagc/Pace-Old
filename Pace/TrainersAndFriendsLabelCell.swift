//
//  TrainersAndFriendsLabelCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TrainersAndFriendsLabelCell: BaseCell {
	
	var discoveryVC : ExploreViewController?
	let trainersAndFriendsLabelText = ASTextNode()
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
		trainersAndFriendsLabelText.attributedText = NSAttributedString(
			string: "Popular Trainers",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.greyWhite(),
				NSKernAttributeName: 0.0,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(trainersAndFriendsLabelText)
		
	}
	
	func seeAllButtonNode() {
		
		seeAllButton.setImage(UIImage(named: "seeAllButton"), for: UIControlState())
		seeAllButton.style.preferredSize = CGSize(width: 20.0, height: 20.0)
		seeAllButton.addTarget(self, action: #selector(handleViewAll), forControlEvents: ASControlNodeEvent.touchUpInside)
		//addSubnode(seeAllButton)
		
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		
		trainersAndFriendsLabelText.style.preferredSize = CGSize(width: constrainedSize.max.width - 20.0, height: 20.0) //constrainedSize.max.width - 130.0
		let labelAndButtonStackSpec = ASStackLayoutSpec(direction: .horizontal,
		                                                spacing: 75,
		                                                justifyContent: .start,
		                                                alignItems: .center,
		                                                children: [trainersAndFriendsLabelText])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 15.0), child: labelAndButtonStackSpec)
		
		
	}
	
	
	func handleViewAll() {
		
		discoveryVC!.handleSeeAllTrainers()
		
	}
	
	
	
}
