//
//  FeaturedCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FeaturedCell: BaseCell {
	
	var featureCollection: FeaturedCollectionCell?
	let workoutImageNode = ASNetworkImageNode()
	let clubNameTextNode = ASTextNode()
	
	//	Distance Ran
	let clubDistanceNumberTextNode = ASTextNode()
	let clubDistanceTextNode = ASTextNode()
	
	//	Distance Ran
	let clubMembersNumberTextNode = ASTextNode()
	let clubMembersTextNode = ASTextNode()
	
	
	//	Average Pace Ran
	let clubPaceNumberTextNode = ASTextNode()
	let clubPaceTextNode = ASTextNode()
	
	let imageWidth : CGFloat = 320
	let imageHeight : CGFloat = 400
	
	let workoutNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy), NSForegroundColorAttributeName: UIColor.white] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()
	
	var  exploreClubModel : ClubModel? {
		
		didSet {
			
			workoutImageNode.url = NSURL(string: (exploreClubModel?.backgroundImageUrl!)!)! as URL
			
			if let workoutName = exploreClubModel?.name {
				
				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
				clubNameTextNode.attributedText = workoutNameMutableString
				
			}
			
			
		}
	}

	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		workoutImageNode.backgroundColor = UIColor.darkerBlack()
		workoutImageNode.contentMode = .scaleAspectFill
		workoutImageNode.layer.cornerRadius = 10.0
		workoutImageNode.clipsToBounds = true
		addSubnode(workoutImageNode)
		
		clubNameTextNode.maximumNumberOfLines = 2
		addSubnode(clubNameTextNode)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		workoutImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		
		let textNodeSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 10.0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [clubNameTextNode])
		
		let insets = UIEdgeInsets(top: CGFloat.infinity, left: 20.0, bottom: 25.0, right: 10.0) // Infinity is used to make the inset unbounded
		let textInsetSpec = ASInsetLayoutSpec(insets: insets, child: textNodeSpec)
		
		return ASOverlayLayoutSpec(child: workoutImageNode, overlay: textInsetSpec)
		
	}
	
}
