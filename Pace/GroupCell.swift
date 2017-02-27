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
	let groupMemberNumberNode = ASTextNode()
	let messageCountNode = ASDisplayNode()
	
	let imageSize : CGFloat = 85
	
	let groupTitleNodeAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 13.5, weight: UIFontWeightBold),
	                             NSForegroundColorAttributeName: UIColor.greyWhite(),
	                             NSKernAttributeName: 0.54] as [String : Any]
	var groupTitleMutableString = NSMutableAttributedString()
	
	
	let groupMemberAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold),
	                           NSForegroundColorAttributeName: UIColor.darkBlack()] as [String : Any]
	var groupMemberMutableString = NSMutableAttributedString()
	
	var  chatGroupModel : SettingsModel? {
		
		didSet {
			
			if let settingsName  = settingsModel?.setting {
				
				settingsTitle.attributedText = NSMutableAttributedString(string: settingsName, attributes: settingsAttributes)
				
			}
			
			
			if let detailSetting  = settingsModel?.settingDetail {
				
				settingDetailString = NSMutableAttributedString(string: detailSetting, attributes: detailAttributes)
				
				let alignmentStyleRight = NSMutableParagraphStyle()
				alignmentStyleRight.alignment = NSTextAlignment.right
				settingDetailString.addAttributes([NSParagraphStyleAttributeName: alignmentStyleRight] as [String: Any], range: NSRange(location: 0, length: NSString(string: detailSetting).length))
				
				settingsRightSubTitle.attributedText = settingDetailString
				
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
		messageCountNode.borderColor = UIColor.black.cgColor
		messageCountNode.borderWidth = 2.5
		messageCountNode.cornerRadius = 25.0 * 0.5
		addSubnode(messageCountNode)
		
		groupImageNode.image = UIImage(named: "3")
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
		
		messageCountNode.style.preferredSize = CGSize(width: 40, height: 40);
		messageCountNode.style.layoutPosition = CGPoint(x: 150, y: 0);
		groupImageNode.style.preferredSize = CGSize(width: imageSize, height: imageSize)
		groupTitleNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		groupMemberNumberNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 115.0)
		
		let imageAndTitle = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 10,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [groupImageNode, groupTitleNode, ])
		
		let finalLayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 5,
		                                   justifyContent: .center,
		                                   alignItems: .center,
		                                   children: [imageAndTitle, groupMemberNumberNode])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12.0, left: 0.0, bottom: 8.0, right: 0.0), child: finalLayoutSpec)
		
		
	}


	

}
