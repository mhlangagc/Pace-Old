//
//  PostsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PostsCell: BaseCell {
	
	let userSendingImageNode = ASNetworkImageNode()
	let userSendingTextNode = ASTextNode()
	
	let postedImageNode = ASNetworkImageNode()
	let postedTextNode = ASTextNode()
	
	let likeButtonNode = ASButtonNode()
	let likesTextNode = ASTextNode()
	
	let userNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold), NSForegroundColorAttributeName: UIColor(fromHexString: "97A9CA")] as [String : Any]
	var userNameMutableString = NSMutableAttributedString()
	
	
	let postedTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.greyWhite()] as [String : Any]
	var postedTextMutableString = NSMutableAttributedString()
	
	
	let likeTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor(fromHexString: "C9D5EB")] as [String : Any]
	var likeTextMutableString = NSMutableAttributedString()
	
	var  messagesModel : TeamMessagesModel? {
		
		didSet {
			
			if let userSendingName = messagesModel?.userSendingName {
				
				userNameMutableString = NSMutableAttributedString(string: userSendingName, attributes: userNameAttributes)
				userSendingTextNode.attributedText = userNameMutableString
				
			}
			
			if messagesModel?.userSendingImageURL != nil {
				
				userSendingImageNode.url = NSURL(string: (messagesModel?.userSendingImageURL!)!)! as URL
				
			}
			
			
			if let postedMessage = messagesModel?.message {
				
				let paragraphStyle = NSMutableParagraphStyle()
				paragraphStyle.lineSpacing = 1.0
				postedTextMutableString = NSMutableAttributedString(string: postedMessage, attributes: postedTextAttributes)
				postedTextMutableString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, postedTextMutableString.length))
				postedTextNode.attributedText = postedTextMutableString
				
				
			}
			
			
			if messagesModel?.imageURL != nil {
				
				postedImageNode.url = NSURL(string: (messagesModel?.imageURL!)!)! as URL
				
			}
			
			likeTextMutableString = NSMutableAttributedString(string: "129", attributes: likeTextAttributes)
			likesTextNode.attributedText = likeTextMutableString
			
			
			
		}
		
	}
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = .black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		//	Profie Name
		userSendingTextNode.maximumNumberOfLines = 1
		addSubnode(userSendingTextNode)
		
		//	Profile Image
		userSendingImageNode.backgroundColor = UIColor.darkerBlack()
		userSendingImageNode.contentMode = .scaleAspectFill
		userSendingImageNode.layer.cornerRadius = 36.0 * 0.5
		userSendingImageNode.clipsToBounds = true
		userSendingImageNode.style.preferredSize = CGSize(width: 36.0, height: 36.0)
		addSubnode(userSendingImageNode)
		
		
		//	Posted Image
		postedImageNode.backgroundColor = UIColor.black
		postedImageNode.contentMode = .scaleAspectFill
		postedImageNode.clipsToBounds = true
		//addSubnode(postedImageNode)
		
		
		//	Posted Text
		addSubnode(postedTextNode)
		
		
		//	Like Button
		likeButtonNode.style.preferredSize = CGSize(width: 18.0, height: 18.0)
		likeButtonNode.setImage(UIImage(named: "like"), for: UIControlState.normal)
		addSubnode(likeButtonNode)
		
		
		//	Likes Text
		//addSubnode(likesTextNode)
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		postedTextNode.style.width = ASDimensionMakeWithPoints(constrainedSize.max.width - 85.0)
		userSendingTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width - 115, height: 20.0)
		//postedImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width * 0.7)
		
		
		// Header Spec
		let headerProfileSpec = ASStackLayoutSpec(direction: .horizontal,
		                                   spacing: 15.0,
		                                   justifyContent: .start,
		                                   alignItems: .center,
		                                   children: [userSendingImageNode, userSendingTextNode, likeButtonNode])
		
		
		let postedHeaderInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 15.0, bottom: 0.0, right: 20.0), child: headerProfileSpec)
		
		let postedTextInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 62.0, bottom: 0.0, right: 20.0), child: postedTextNode)
		
		
		// Bottom Header
		let finalSpec = ASStackLayoutSpec(direction: .vertical,
		                                     spacing: 5.0,
		                                     justifyContent: .start,
		                                     alignItems: .start,
		                                     children: [postedHeaderInset, postedTextInset])
		
		// Header + Message + Imagenode
//		let finalSpec = ASStackLayoutSpec()
//		finalSpec.direction = .vertical
//		finalSpec.justifyContent = .start
//		finalSpec.alignItems = .start
//		
//		if messagesModel?.imageURL != nil {
//			
//			finalSpec.spacing = 15.0
//			finalSpec.children = [headerProfileSpec, postedImageNode, postedTextNode, bottomHeader]
//			
//		} else { 
//			
//			finalSpec.spacing = 20.0
//			finalSpec.children =  [headerProfileSpec, postedTextNode, bottomHeader]
//			
//		}
		
		
		// ******
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 25.0, right: 0.0), child: finalSpec)
		
		
		
	}
	
	
	
}

