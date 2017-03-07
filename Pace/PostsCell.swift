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
	
	
	let likeTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.darkBlack()] as [String : Any]
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
		
		userSendingImageNode.backgroundColor = UIColor.darkerBlack()
		userSendingImageNode.contentMode = .scaleAspectFill
		userSendingImageNode.layer.cornerRadius = 15.0
		userSendingImageNode.clipsToBounds = true
		addSubnode(userSendingImageNode)
		
		userSendingTextNode.maximumNumberOfLines = 2
		addSubnode(userSendingTextNode)
		
		optionsButtonNode.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		optionsButtonNode.tintColor = UIColor.darkBlack()
		addSubnode(optionsButtonNode)
		
		postedImageNode.backgroundColor = UIColor.black
		postedImageNode.contentMode = .scaleAspectFill
		postedImageNode.clipsToBounds = true
		addSubnode(postedImageNode)
		
		addSubnode(postedTextNode)
		
		likeButtonNode.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		likeButtonNode.tintColor = UIColor.greyBlackColor()
		addSubnode(likeButtonNode)
		
		addSubnode(likesTextNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		userSendingImageNode.style.preferredSize = CGSize(width: 30.0, height: 30.0)
		userSendingTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width - 110, height: 24.0)
		optionsButtonNode.style.preferredSize = CGSize(width: 22.0, height: 5.0)
		postedTextNode.style.width = ASDimensionMakeWithPoints(constrainedSize.max.width - 80.0)
		likeButtonNode.style.preferredSize = CGSize(width: 20.0, height: 18.0)
		likesTextNode.style.preferredSize = CGSize(width: 128, height: 20)
		postedImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width * 0.7)
		
		// ******
		
		let headerSpec = ASStackLayoutSpec(direction: .horizontal,
		                                     spacing: 20.0,
		                                     justifyContent: .start,
		                                     alignItems: .center,
		                                     children: [userSendingImageNode, userSendingTextNode, optionsButtonNode])
		
		let headerInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 10.0, bottom: 5.0, right: 20.0), child: headerSpec)
		
		
		// ******
		
		
		let messageTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 62.0, bottom: 5.0, right: 20.0), child: postedTextNode)
		
		
		// ******
		
		let subHeaderSpec = ASStackLayoutSpec()
		subHeaderSpec.direction = .vertical
		subHeaderSpec.spacing = 25.0
		subHeaderSpec.justifyContent = .start
		subHeaderSpec.alignItems = .center
		if messagesModel?.imageURL != nil {
			
			subHeaderSpec.children = [headerInsetSpec, postedImageNode, messageTextInsetSpec]
			
		} else {
			
			subHeaderSpec.children =  [headerInsetSpec, messageTextInsetSpec]
			
		}
		
		// ******
		
		let bottomHeader = ASStackLayoutSpec(direction: .horizontal,
		                               spacing: 20.0,
		                               justifyContent: .start,
		                               alignItems: .center,
		                               children: [likeButtonNode, likesTextNode])
		
		let bottomHeaderInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0), child: bottomHeader)
		
		// ******
		
		return ASStackLayoutSpec(direction: .vertical,
		                                     spacing: 10.0,
		                                     justifyContent: .start,
		                                     alignItems: .center,
		                                     children: [subHeaderSpec, bottomHeaderInsetSpec])
		
		//let finalInsets = UIEdgeInsets(top: CGFloat.infinity, left: 20.0, bottom: 25.0, right: 10.0) // Infinity is used to
		//return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15.0, left: 0, bottom: 15.0, right: 0), child: finalLayoutSpec)
		
		
	}
	
	
	
}

