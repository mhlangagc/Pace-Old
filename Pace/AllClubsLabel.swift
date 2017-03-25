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

class AllClubsLabel: BaseCell {
	
	let categoryLabel = ASTextNode()
	
	override func setupNodes() {
		super.setupNodes()
		
		self.eventLabelSetup()
		
		backgroundColor = UIColor.black
		
	}
	
	
	func eventLabelSetup() {
		
		let alignmentStyle = NSMutableParagraphStyle()
		alignmentStyle.alignment = NSTextAlignment.left
		categoryLabel.attributedText = NSAttributedString(
			string: "All Clubs".uppercased(),
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.greyBlackColor(),
				NSKernAttributeName: 0.0,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(categoryLabel)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		
		categoryLabel.style.preferredSize = CGSize(width: constrainedSize.max.width - 40.0, height: 25.0)
		let catergoryLayoutLabel = ASStackLayoutSpec(direction: .horizontal,
		                                             spacing: 0.0,
		                                             justifyContent: .start,
		                                             alignItems: .start,
		                                             children: [categoryLabel])
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0), child: catergoryLayoutLabel)
		
		
	}
	
	
}
