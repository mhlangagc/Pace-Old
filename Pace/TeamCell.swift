//
//  ChatCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TeamCell: BaseCell {
	
	let groupImageNode = ASNetworkImageNode()
	let groupTitleNode = ASTextNode()
	var groupMemberNumberNode = ASTextNode()
	let messageCountNode = ASDisplayNode()
	
	let imageSize : CGFloat = 100
	
	
	//	Group Title
	let groupTitleNodeAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold),
	                             NSForegroundColorAttributeName: UIColor.greyWhite(),
	                             NSKernAttributeName: 0.0] as [String : Any]
	var groupTitleMutableString = NSMutableAttributedString()
	
	
	
	// Member Number
	var groupMemberAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold),
	                           NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var groupMemberMutableString = NSMutableAttributedString()

	var  teamModel : TeamsModel? {
		
		didSet {
			
			groupImageNode.url = NSURL(string: (teamModel?.backgroundImageUrl!)!)! as URL
			
			if let groupName  = teamModel?.workoutName {
				
				groupTitleMutableString = NSMutableAttributedString(string: groupName, attributes: groupTitleNodeAttributes)
				
				let alignmentStyleCenter = NSMutableParagraphStyle()
				alignmentStyleCenter.alignment = NSTextAlignment.center
				groupTitleMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleCenter] as [String: Any], range: NSRange(location: 0, length: NSString(string: groupName).length))
				
				groupTitleNode.attributedText = groupTitleMutableString
				
			}
			
			
//			if let groupUserNumber  = "2k Members" { //teamModel?.numberOfMembers
//				
//				groupMemberMutableString = NSMutableAttributedString(string: "\(groupUserNumber) Members", attributes: groupMemberAttributes)
//				
//				let alignmentStyleCenter = NSMutableParagraphStyle()
//				alignmentStyleCenter.alignment = NSTextAlignment.center
//				groupMemberMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleCenter] as [String: Any], range: NSRange(location: 0, length: NSString(string: "\(groupUserNumber) Members").length))
//				
//				groupMemberNumberNode.attributedText = groupMemberMutableString
//			}
			
			groupMemberMutableString = NSMutableAttributedString(string: "2k Members", attributes: groupMemberAttributes)
			
			let alignmentStyleCenter = NSMutableParagraphStyle()
			alignmentStyleCenter.alignment = NSTextAlignment.center
			groupMemberMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleCenter] as [String: Any], range: NSRange(location: 0, length: NSString(string: "2k Members").length))
			
			groupMemberNumberNode.attributedText = groupMemberMutableString
			
		}
	}
	
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupGroupCellDetails()
		
	}
	
	func setupGroupCellDetails() {
		
		
		messageCountNode.backgroundColor = UIColor.paceBrandColor()
		messageCountNode.cornerRadius = 20.0 * 0.5
		addSubnode(messageCountNode)
		
		
		groupImageNode.backgroundColor = UIColor.darkBlack()
		groupImageNode.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
		groupImageNode.layer.cornerRadius = 100.0 * 0.5
		groupImageNode.clipsToBounds = true
		addSubnode(groupImageNode)
		
		groupTitleNode.maximumNumberOfLines = 2
		addSubnode(groupTitleNode)
		
		groupMemberNumberNode.maximumNumberOfLines = 1
		addSubnode(groupMemberNumberNode)
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		groupImageNode.style.preferredSize = CGSize(width: imageSize, height: imageSize)
		groupTitleNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		groupMemberNumberNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		
		
		let imageAndTitle = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 15,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [groupImageNode, groupTitleNode])
		
		let finalLayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 8,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [imageAndTitle, groupMemberNumberNode])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 0.0, bottom: 22.0, right: 0.0), child: finalLayoutSpec)
		
		
	}


	

}
