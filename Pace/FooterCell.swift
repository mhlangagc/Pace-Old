//
//  FooterCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FooterCell: BaseCell {
	
	var discoveryVC : ExploreViewController?
	let extrasTextNode = ASTextNode()
	let quickLinksTextNode = ASTextNode()
	let becomeATrainerButton = ASButtonNode()
	let sendFeedback = ASButtonNode()
	
	override func setupNodes() {
		super.setupNodes()
		
		self.setupNodesInView()
		
		backgroundColor = UIColor.paceBackgroundBlack()
	
	}
	
	
	func setupNodesInView() {
		
		let alignmentStyle = NSMutableParagraphStyle()
		alignmentStyle.alignment = NSTextAlignment.center
		extrasTextNode.attributedText = NSAttributedString(
			string: "Extras",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy),
				NSForegroundColorAttributeName: UIColor.greyWhite(),
				NSKernAttributeName: -0.4,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(extrasTextNode)
		
		
		quickLinksTextNode.attributedText = NSAttributedString(
			string: "Quick Links",
			attributes: [
				NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold),
				NSForegroundColorAttributeName: UIColor.greyBlackColor(),
				NSKernAttributeName: 0.0,
				NSParagraphStyleAttributeName: alignmentStyle
			])
		addSubnode(quickLinksTextNode)
		
		
		becomeATrainerButton.backgroundColor = UIColor.darkBlack()
		becomeATrainerButton.setTitle("Upload your workout", with: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold), with: UIColor.paceBrandColor(), for: UIControlState())
		becomeATrainerButton.addTarget(self, action: #selector(handleBecomeATrainer), forControlEvents: ASControlNodeEvent.touchUpInside)
		becomeATrainerButton.layer.cornerRadius = 7.5
		addSubnode(becomeATrainerButton)
		
		
		sendFeedback.backgroundColor = UIColor.darkBlack()
		sendFeedback.setTitle("Send Feedback", with: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold), with: UIColor.paceBrandColor(), for: UIControlState())
		sendFeedback.addTarget(self, action: #selector(handleSendFeedback), forControlEvents: ASControlNodeEvent.touchUpInside)
		sendFeedback.layer.cornerRadius = 7.5
		addSubnode(sendFeedback)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		
		becomeATrainerButton.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 45.0)
		sendFeedback.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 45.0)
		
		
		
		let linkTextsSpec = ASStackLayoutSpec(direction: .vertical,
		                                             spacing: 10.0,
		                                             justifyContent: .center,
		                                             alignItems: .center,
		                                             children: [extrasTextNode, quickLinksTextNode])
		
		
		let buttonsAndTextSpec = ASStackLayoutSpec(direction: .vertical,
		                                  spacing: 20.0,
		                                  justifyContent: .center,
		                                  alignItems: .center,
		                                  children: [linkTextsSpec, becomeATrainerButton, sendFeedback])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 30.0, right: 20.0), child: buttonsAndTextSpec)
		
		
	}
	
	
	
	func handleBecomeATrainer() {
		
	
		discoveryVC?.becomeATrainer()
	
	}
	
	
	func handleSendFeedback() {
		
		discoveryVC?.sendFeedback()
		
	}
	
	
	
}
