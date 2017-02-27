//
//  ChatCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class GroupCell: BaseCell {
	
	let groupImageNode = ASNetworkImageNode()
	let groupTitleNode = ASTextNode()
	var groupMemberNumberNode = ASTextNode()
	let messageCountNode = ASDisplayNode()
	
	let imageSize : CGFloat = 85
	
	let groupTitleNodeAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 13.5, weight: UIFontWeightSemibold),
	                             NSForegroundColorAttributeName: UIColor.white,
	                             NSKernAttributeName: 0.54] as [String : Any]
	var groupTitleMutableString = NSMutableAttributedString()
	
	
	
	
	var groupMemberAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold),
	                           NSForegroundColorAttributeName: UIColor.greyWhite()] as [String : Any]
	var groupMemberMutableString = NSMutableAttributedString()
	
	
	
	var  chatGroupModel : ChatGroupModel? {
		
		didSet {
			
			if let groupName  = chatGroupModel?.groupWorkout {
				
				groupTitleMutableString = NSMutableAttributedString(string: groupName, attributes: groupTitleNodeAttributes)
				
				let alignmentStyleCenter = NSMutableParagraphStyle()
				alignmentStyleCenter.alignment = NSTextAlignment.center
				groupTitleMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleCenter] as [String: Any], range: NSRange(location: 0, length: NSString(string: groupName).length))
				
				groupTitleNode.attributedText = groupTitleMutableString
				
			}
			
			
			if let groupUserNumber  = chatGroupModel?.groupUsers?.count {
				
				print(groupUserNumber)
				
				groupMemberMutableString = NSMutableAttributedString(string: "3k Members", attributes: groupMemberAttributes)
				
				let alignmentStyleCenter = NSMutableParagraphStyle()
				alignmentStyleCenter.alignment = NSTextAlignment.center
				groupMemberMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleCenter] as [String: Any], range: NSRange(location: 0, length: NSString(string: "3k Members").length))
				
				groupMemberNumberNode.attributedText = groupMemberMutableString
				
			}
			
			
			if let groupImage = chatGroupModel?.groupImage {
				
				groupImageNode.image = groupImage
				
			}
			
			
		}
	}
	
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupGroupCellDetails()
		
	}
	
	func setupGroupCellDetails() {
		
		
		messageCountNode.backgroundColor = UIColor.paceBrandColor()
		messageCountNode.cornerRadius = 10.0 * 0.5
		addSubnode(messageCountNode)
		
		
		groupImageNode.backgroundColor = UIColor.darkBlack()
		groupImageNode.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
		groupImageNode.layer.cornerRadius = 85.0 * 0.5
		groupImageNode.shouldRasterizeDescendants = true
		groupImageNode.clipsToBounds = true
		addSubnode(groupImageNode)
		
		groupTitleNode.maximumNumberOfLines = 2
		addSubnode(groupTitleNode)
		
		groupMemberNumberNode.maximumNumberOfLines = 1
		addSubnode(groupMemberNumberNode)
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		messageCountNode.style.preferredSize = CGSize(width: 10, height: 10)
		
		groupImageNode.style.preferredSize = CGSize(width: imageSize, height: imageSize)
		groupTitleNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		groupMemberNumberNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		
		
		let imageAndTitle = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 10,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [groupImageNode, groupTitleNode])
		
		let finalLayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 5,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [imageAndTitle, groupMemberNumberNode])
		
		let absoluteLayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                        spacing: 5,
		                                        justifyContent: .center,
		                                        alignItems: .center,
		                                        children: [finalLayoutSpec, messageCountNode])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12.0, left: 0.0, bottom: 8.0, right: 0.0), child: absoluteLayoutSpec)
		
		
	}


	

}
