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
	
	let userSendingImageNode = ASImageNode()
	let userSendingTextNode = ASTextNode()
	let optionsButtonNode = ASButtonNode()
	
	let postedImageNode = ASNetworkImageNode()
	let postedTextNode = ASTextNode()
	
	let likeButtonNode = ASButtonNode()
	let likesTextNode = ASTextNode()
	
	
	let imageWidth : CGFloat = 325
	let imageHeight : CGFloat = 225
	
	let userNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var userNameMutableString = NSMutableAttributedString()
	
	
	let postedTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.greyWhite()] as [String : Any]
	var postedTextMutableString = NSMutableAttributedString()
	
	
	let likeTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var likeTextMutableString = NSMutableAttributedString()
	
	var  messagesModel : TeamMessagesModel? {
		
		didSet {
			
			
			userSendingImageNode.image = UIImage(named: "cynthia")
			
			if let userSendingName = messagesModel?.userSending {
				
				userNameMutableString = NSMutableAttributedString(string: userSendingName, attributes: userNameAttributes)
				userSendingTextNode.attributedText = userNameMutableString
				
			}
			
			
			if let postedMessage = messagesModel?.message {
				
				postedTextMutableString = NSMutableAttributedString(string: postedMessage, attributes: postedTextAttributes)
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
		
		backgroundColor = UIColor.black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		//	Profile Image
		userSendingImageNode.backgroundColor = UIColor.darkerBlack()
		userSendingImageNode.contentMode = .scaleAspectFill
		userSendingImageNode.layer.cornerRadius = 15.0
		userSendingImageNode.clipsToBounds = true
		userSendingImageNode.style.preferredSize = CGSize(width: 30.0, height: 30.0)
		addSubnode(userSendingImageNode)
		
		//	Profie Name
		userSendingTextNode.maximumNumberOfLines = 1
		userSendingTextNode.style.preferredSize = CGSize(width: 180, height: 24.0)
		addSubnode(userSendingTextNode)
		
		//	Option Button
		optionsButtonNode.setImage(UIImage(named: "more"), for: UIControlState.normal)
		optionsButtonNode.style.preferredSize = CGSize(width: 22.0, height: 5.0)
		addSubnode(optionsButtonNode)
		
		//	Posted Image
		postedImageNode.backgroundColor = UIColor.black
		postedImageNode.contentMode = .scaleAspectFill
		postedImageNode.clipsToBounds = true
		addSubnode(postedImageNode)
		
		//	Posted Text
		
		addSubnode(postedTextNode)
		
		//	Like Button
		likeButtonNode.style.preferredSize = CGSize(width: 20.0, height: 18.0)
		likeButtonNode.setImage(UIImage(named: "like"), for: UIControlState.normal)
		addSubnode(likeButtonNode)
		
		addSubnode(likesTextNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		likesTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width - 80, height: 20)
		postedTextNode.style.width = ASDimensionMakeWithPoints(constrainedSize.max.width - 80.0)
		postedImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width * 0.7)
		
		
		// Header Spec
		let headerProfileSpec = ASStackLayoutSpec(direction: .horizontal,
		                                   spacing: 20.0,
		                                   justifyContent: .start,
		                                   alignItems: .center,
		                                   children: [userSendingImageNode, userSendingTextNode])
		
		let headerSpec = ASStackLayoutSpec(direction: .horizontal,
		                                     spacing: 50.0,
		                                     justifyContent: .start,
		                                     alignItems: .center,
		                                     children: [headerProfileSpec, optionsButtonNode])
		
		let headerInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 10.0, right: 20.0), child: headerSpec)
		
		
		// Posted Message Node
		
		let messageTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0), child: postedTextNode)
		
		
		// Header + Message + Imagenode
		
		let subHeaderSpec = ASStackLayoutSpec()
		subHeaderSpec.direction = .vertical
		subHeaderSpec.justifyContent = .start
		subHeaderSpec.alignItems = .center
		if messagesModel?.imageURL != nil {
			
			subHeaderSpec.spacing = 5.0
			subHeaderSpec.children = [headerInsetSpec, postedImageNode, messageTextInsetSpec]
			
		} else {
			
			subHeaderSpec.spacing = 10.0
			subHeaderSpec.children =  [headerInsetSpec, messageTextInsetSpec]
			
		}
		
		// Bottom Header
		
		let bottomHeader = ASStackLayoutSpec(direction: .horizontal,
		                               spacing: 20.0,
		                               justifyContent: .start,
		                               alignItems: .center,
		                               children: [likeButtonNode, likesTextNode])
		
		let bottomHeaderInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 20.0, bottom: 10.0, right: 20.0), child: bottomHeader)
		
		// ******
		
		return ASStackLayoutSpec(direction: .vertical,
		                                     spacing: 10.0,
		                                     justifyContent: .start,
		                                     alignItems: .start,
		                                     children: [subHeaderSpec, bottomHeaderInsetSpec])
		
		//let finalInsets = UIEdgeInsets(top: CGFloat.infinity, left: 20.0, bottom: 25.0, right: 10.0) // Infinity is used to
		//return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 0, bottom: 15.0, right: 0), child: finalLayoutSpec)
		
		
	}
	
	
	
}

