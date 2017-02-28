//
//  ProfileSettingsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileSettingsCell: BaseCell {
	
	let profileImage = ASNetworkImageNode()
	let profileTitle = ASTextNode()
	let editTitle = ASTextNode()
	
	var settingsVC: SettingsViewController?
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	
	let profileTitleAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack),
	                          NSForegroundColorAttributeName: UIColor.offWhite() ] as [String : Any]
	
	let editProfileAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold),
	                        NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	
	var  userModel : User? {
		
		didSet {
			
			if let userName  = userModel?.name, let profileImageURL = userModel?.profileImageUrl {
				
				profileTitle.attributedText = NSMutableAttributedString(string: userName, attributes: profileTitleAttributes)
				profileImage.url = NSURL(string: profileImageURL)! as URL
			}
			
			
			editTitle.attributedText = NSMutableAttributedString(string: "Edit Profile", attributes: editProfileAttributes)
			
		}
	}
	
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		
		self.setupSettingsDetails()
		
	}
	
	func setupSettingsDetails() {
		
		profileImage.cornerRadius = 80.0 * 0.5
		profileImage.layer.masksToBounds = true
		addSubnode(profileImage)
		addSubnode(profileTitle)
		addSubnode(editTitle)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		profileImage.style.preferredSize = CGSize(width: 80, height: 80)
		profileTitle.style.preferredSize = CGSize(width: 230, height: 35.0)
		editTitle.style.preferredSize = CGSize(width: 230.0, height: 28.0)
		
		let verticalTextSpec = ASStackLayoutSpec(direction: .vertical,
		                                 spacing: 10.0,
		                                 justifyContent: .start,
		                                 alignItems: .start,
		                                 children: [profileTitle, editTitle])
		
		
		let finalLayoutSpec = ASStackLayoutSpec(direction: .horizontal,
		                                         spacing: 20.0,
		                                         justifyContent: .center,
		                                         alignItems: .center,
		                                         children: [profileImage, verticalTextSpec])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 25.0, left: 20.0, bottom: 25.0, right: 20.0), child: finalLayoutSpec)
		
	}
	
	
}
