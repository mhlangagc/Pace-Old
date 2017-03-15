//
//  CatergoryCollectionCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class EventCollectionCell: BaseCell {
	
	var eventCollection: EventCollection?
	let eventImageNode = ASImageNode()
	let eventTitleNode = ASTextNode()
	let eventDateNode = ASTextNode()
	let daysRemainingTextNode = ASTextNode()
	
	let imageWidth : CGFloat = 330.0
	let imageHeight : CGFloat = 300.0
	
	
	let eventNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 19, weight: UIFontWeightBold),
	                           NSForegroundColorAttributeName: UIColor(fromHexString: "C9D5EB")] as [String : Any]
	var eventMutableString = NSMutableAttributedString()
	
	
	
	
	let eventDateAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold),
	                           NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var eventDateMutableString = NSMutableAttributedString()
	
	
	
	let daysRemaingAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 11, weight: UIFontWeightMedium),
	                           NSForegroundColorAttributeName: UIColor.paceBrandColor()] as [String : Any]
	var daysRemaingMutableString = NSMutableAttributedString()
	
	
	
	var event : EventModel? {
		
		didSet {
			
			if let eventImage  = event?.eventImage, let eventName = event?.eventName, let eventDate = event?.eventDate, let daysRemaining = event?.daysAway {
				
				eventImageNode.image = eventImage
				
				
				
				eventMutableString = NSMutableAttributedString(string: eventName, attributes: eventNameAttributes)
				let alignmentStyle = NSMutableParagraphStyle()
				alignmentStyle.alignment = NSTextAlignment.left
				eventMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyle] as [String: Any], range: NSRange(location: 0, length: NSString(string: eventName).length))
				
				eventTitleNode.attributedText = eventMutableString
				
				
				
				eventDateMutableString = NSMutableAttributedString(string: eventDate, attributes: eventDateAttributes)
				eventDateNode.attributedText = eventDateMutableString
				
				
				
				daysRemaingMutableString = NSMutableAttributedString(string: daysRemaining, attributes: daysRemaingAttributes)
				let rightAlignmentStyle = NSMutableParagraphStyle()
				rightAlignmentStyle.alignment = NSTextAlignment.right
				daysRemaingMutableString.addAttributes([NSParagraphStyleAttributeName: rightAlignmentStyle] as [String: Any], range: NSRange(location: 0, length: NSString(string: daysRemaining).length))
				daysRemainingTextNode.attributedText = daysRemaingMutableString
				
			}
			
		}
	}
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		eventImageNode.backgroundColor = UIColor.black
		eventImageNode.contentMode = .scaleAspectFill
		eventImageNode.layer.cornerRadius = 10.0
		eventImageNode.clipsToBounds = true
		addSubnode(eventImageNode)
		
		
		eventTitleNode.maximumNumberOfLines = 1
		addSubnode(eventTitleNode)
		
		
		eventDateNode.maximumNumberOfLines = 1
		addSubnode(eventDateNode)
		
		
		daysRemainingTextNode.maximumNumberOfLines = 1
		addSubnode(daysRemainingTextNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		eventImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		
		eventTitleNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: imageWidth - 10)
		eventDateNode.style.preferredSize = CGSize(width: 200, height: 18)
		daysRemainingTextNode.style.preferredSize = CGSize(width: 90, height: 13)
		
		let toplayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 18,
		                                   justifyContent: .start,
		                                   alignItems: .start,
		                                   children: [eventImageNode, eventTitleNode])
		
		let bottomLayoutSpec = ASStackLayoutSpec(direction: .horizontal,
		                                   spacing: 35,
		                                   justifyContent: .end,
		                                   alignItems: .center,
		                                   children: [eventDateNode, daysRemainingTextNode])
		
		
		let layoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 10,
		                                   justifyContent: .start,
		                                   alignItems: .start,
		                                   children: [toplayoutSpec, bottomLayoutSpec])
		
		
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 18.0, left: 0.0, bottom: 37.0, right: 15.0), child: layoutSpec)
		
		
	}
	
}

