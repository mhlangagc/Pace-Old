//
//  FollowerFollowingCellNode.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FollowerFollowingCellNode: BaseCell {
	
	let profileImageNode = ASImageNode()
	let profileNameText = ASTextNode()
	let numberOfFollowersText = ASTextNode()
	let followButton = ASButtonNode()
	let lineNode = ASDisplayNode()
	
	var followersViewController: FollowersViewController?
	
	
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
		self.setupExerciseDetails()
		
		backgroundColor = .black
		
	}
	
	func setupExerciseDetails() {
		
		profileImageNode.image = UIImage(named: "trainer")
		profileImageNode.contentMode = .scaleAspectFit
		profileImageNode.clipsToBounds = true
		profileImageNode.layer.cornerRadius = 25.0
		addSubnode(profileImageNode)
		
		profileNameText.attributedText = NSAttributedString(
			string: "Jamaine",
			attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold),
			             NSForegroundColorAttributeName: UIColor.offWhite(),
			             NSKernAttributeName: 0.0
			])
		addSubnode(profileNameText)
		
		
		
		
		numberOfFollowersText.attributedText = NSAttributedString(
			string: "34 Followers",
			attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold),
			             NSForegroundColorAttributeName: UIColor.greyBlackColor(),
			             NSKernAttributeName: 0.0
			])
		addSubnode(numberOfFollowersText)
		
		
		
		followButton.setTitle("Following", with: UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), with: UIColor.black, for: ASControlState())
		followButton.backgroundColor = UIColor.paceBrandColor()
		followButton.layer.cornerRadius = 4.0
		followButton.layer.masksToBounds = true
		followButton.addTarget(self, action: #selector(handleFollow_Unfollow), forControlEvents: ASControlNodeEvent.touchUpInside)
		addSubnode(followButton)
		
		
		lineNode.backgroundColor = UIColor.darkBlack()
		lineNode.layer.opacity = 0.5
		addSubnode(lineNode)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		profileImageNode.style.preferredSize = CGSize(width: 50.0, height: 50.0)
		profileNameText.style.preferredSize = CGSize(width: constrainedSize.max.width - 225, height: 20.0)
		numberOfFollowersText.style.preferredSize = CGSize(width: constrainedSize.max.width - 225, height: 18.0)
		followButton.style.preferredSize = CGSize(width: 105.0, height: 35.0)
		lineNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1.0)
		
		let textDetailsSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 8.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [profileNameText, numberOfFollowersText])
		
		let imageAndTextSpec = ASStackLayoutSpec(direction: .horizontal,
		                                         spacing: 15.0,
		                                         justifyContent: .center,
		                                         alignItems: .center,
		                                         children: [profileImageNode, textDetailsSpec])
		
		let buttonAndDetailSpec = ASStackLayoutSpec(direction: .horizontal,
		                                                         spacing: 20.0,
		                                                         justifyContent: .center,
		                                                         alignItems: .center,
		                                                         children: [imageAndTextSpec, followButton])
		
		let followWithoutLinesSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 18.0, left: 15.0, bottom: 17.0, right: 20.0), child: buttonAndDetailSpec)
		
		let lineAndDetailSpec = ASStackLayoutSpec(direction: .vertical,
		                                          spacing: 1.0,
		                                          justifyContent: .start,
		                                          alignItems: .start,
		                                          children: [followWithoutLinesSpec, lineNode])
		
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), child: lineAndDetailSpec)
		
	}
	
	
	func handleFollow_Unfollow() {
		
		//	TODO
		
	}
	
	
}

