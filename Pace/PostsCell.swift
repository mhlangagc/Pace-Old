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
	
	let postedImageNode = ASNetworkImageNode()
	let postedTextNode = ASTextNode()
	
	let likeButtonNode = ASButtonNode()
	let likesTextNode = ASTextNode()
	
	let userNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold), NSForegroundColorAttributeName: UIColor(fromHexString: "C9D5EB")] as [String : Any]
	var userNameMutableString = NSMutableAttributedString()
	
	
	let postedTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor(fromHexString: "7788A4")] as [String : Any]
	var postedTextMutableString = NSMutableAttributedString()
	
	
	let likeTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor(fromHexString: "C9D5EB")] as [String : Any]
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
		
		backgroundColor = UIColor(fromHexString: "0C0E10")
		layer.cornerRadius = 13.0
		layer.masksToBounds = true
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		//	Profie Name
		userSendingTextNode.maximumNumberOfLines = 1
		userSendingTextNode.style.preferredSize = CGSize(width: 260, height: 20.0)
		addSubnode(userSendingTextNode)
		
		//	Profile Image
		userSendingImageNode.backgroundColor = UIColor.darkerBlack()
		userSendingImageNode.contentMode = .scaleAspectFill
		userSendingImageNode.layer.cornerRadius = 20.0
		userSendingImageNode.clipsToBounds = true
		userSendingImageNode.style.preferredSize = CGSize(width: 40.0, height: 40.0)
		addSubnode(userSendingImageNode)
		
		
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
		
		//	Likes Text
		addSubnode(likesTextNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		likesTextNode.style.preferredSize = CGSize(width: constrainedSize.max.width - 80, height: 20)
		postedTextNode.style.width = ASDimensionMakeWithPoints(constrainedSize.max.width - 80.0)
		postedImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width * 0.7)
		
		
		// Header Spec
		let headerProfileSpec = ASStackLayoutSpec(direction: .horizontal,
		                                   spacing: 20.0,
		                                   justifyContent: .end,
		                                   alignItems: .center,
		                                   children: [userSendingTextNode, userSendingImageNode])
		
		// Bottom Header
		let bottomHeader = ASStackLayoutSpec(direction: .horizontal,
		                                     spacing: 18.0,
		                                     justifyContent: .start,
		                                     alignItems: .center,
		                                     children: [likeButtonNode, likesTextNode])
		
		// Header + Message + Imagenode
		let finalSpec = ASStackLayoutSpec()
		finalSpec.direction = .vertical
		finalSpec.justifyContent = .start
		finalSpec.alignItems = .start
		
		if messagesModel?.imageURL != nil {
			
			finalSpec.spacing = 15.0
			finalSpec.children = [headerProfileSpec, postedImageNode, postedTextNode, bottomHeader]
			
		} else { 
			
			finalSpec.spacing = 20.0
			finalSpec.children =  [headerProfileSpec, postedTextNode, bottomHeader]
			
		}
		
		
		// ******
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 27.0, bottom: 20.0, right: 13.0), child: finalSpec)
		
		
		
	}
	
	
	
}

