//
//  HeaderLabelCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HeaderLabelCell : BaseCell {
	
	let discoveryLabelText = ASTextNode()

	override func setupNodes() {
		
		super.setupNodes()
		self.setupDiscoveryLabel()
		
		backgroundColor = .black
		
	}
	
	
	func setupDiscoveryLabel() {
		
		discoveryLabelText.attributedText = NSAttributedString(
			string: "New Workouts",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 23, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.white,
				NSKernAttributeName: 1.0
			])
		addSubnode(discoveryLabelText)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		discoveryLabelText.style.preferredSize = CGSize(width: constrainedSize.max.width - 70.0, height: 50.0)
		
		
		let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 15,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [discoveryLabelText])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 20.0, bottom: 0.0, right: 20.0), child: headerStackSpec)
		
	}
	
}

