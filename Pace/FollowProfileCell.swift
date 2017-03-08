//
//  FollowProfileCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FollowProfileCell: BaseCell {
	
	var followCollection: TrainersAndFriendsCollectionNode?
	let profileImageNode = ASNetworkImageNode()
	let nameTextNode = ASTextNode()
	let relationTextNode = ASTextNode()
	let followButtonNode = ASButtonNode()
	
	let profileImageWidth : CGFloat = 72.0
	
	//	Workout Name
	let trainerNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold),
	                             NSForegroundColorAttributeName: UIColor.white,
	                             NSKernAttributeName: 1.0] as [String : Any]
	var trainerNameMutableString = NSMutableAttributedString()
	
	//	Trainer Details
	let trainerDetailseAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold),
	                             NSForegroundColorAttributeName: UIColor.greyBlackColor(),
	                             NSKernAttributeName: 0.36] as [String : Any]
	var trainerDetailsMutableString = NSMutableAttributedString()
	
	var trainerModel : User? {
		
		didSet {
			
			if let name  = trainerModel?.name, let imageURL = trainerModel?.profileImageUrl, let details = trainerModel?.speciality {
				
				let alignmentStyle = NSMutableParagraphStyle()
				alignmentStyle.alignment = NSTextAlignment.center
				
				profileImageNode.url = NSURL(string: imageURL)! as URL
				
				trainerNameMutableString = NSMutableAttributedString(string: name, attributes: trainerNameAttributes)
				trainerNameMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyle] as [String: Any], range: NSRange(location: 0, length: NSString(string: name).length))
				nameTextNode.attributedText = trainerNameMutableString
				
				
				trainerDetailsMutableString = NSMutableAttributedString(string: details, attributes: trainerDetailseAttributes)
				trainerDetailsMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyle] as [String: Any], range: NSRange(location: 0, length: NSString(string: details).length))
				relationTextNode.attributedText = trainerDetailsMutableString
				
			}
			
		}
	}
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupViews()
		
	}
	
	func setupViews() {
		
		profileImageNode.backgroundColor = UIColor.darkBlack()
		profileImageNode.contentMode = .scaleAspectFill
		profileImageNode.layer.cornerRadius = profileImageWidth * 0.5
		profileImageNode.clipsToBounds = true
		addSubnode(profileImageNode)
		
		//	Name
		nameTextNode.maximumNumberOfLines = 1
		addSubnode(nameTextNode)
		
		
		//	Details
		relationTextNode.maximumNumberOfLines = 2
		addSubnode(relationTextNode)
		
		
		//	Follow Button Node
		followButtonNode.backgroundColor = UIColor.darkBlack()
		followButtonNode.setTitle("Follow", with: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold), with: UIColor.paceBrandColor(), for: UIControlState())
		followButtonNode.addTarget(self, action: #selector(handleFollow), forControlEvents: ASControlNodeEvent.touchUpInside)
		followButtonNode.layer.cornerRadius = 7.5
		//addSubnode(followButtonNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		profileImageNode.style.preferredSize = CGSize(width: profileImageWidth, height: profileImageWidth)
		nameTextNode.style.preferredSize = CGSize(width: 160.0, height: 22.0)
		relationTextNode.style.preferredSize = CGSize(width: 160.0, height: 35.0)
		//followButtonNode.style.preferredSize = CGSize(width: 145.0, height: 35.0)
		
		let imageAndTitlesSpec = ASStackLayoutSpec(direction: .vertical,
		                                           spacing: 10,
		                                           justifyContent: .center,
		                                           alignItems: .center,
		                                           children: [profileImageNode, nameTextNode, relationTextNode])
		
		
//		let followAndTitlesSpec = ASStackLayoutSpec(direction: .vertical,
//		                                           spacing: 15,
//		                                           justifyContent: .center,
//		                                           alignItems: .center,
//		                                           children: [imageAndTitlesSpec, followButtonNode])
		
		return imageAndTitlesSpec
		
		
	}
	
	func handleFollow() {
		
		//	TODO
	}
}

