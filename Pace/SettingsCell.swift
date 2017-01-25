//
//  SettingsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SettingsCell: BaseCell {
	
	let settingsTitle = ASTextNode()
	let settingsRightSubTitle = ASTextNode()
	
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
	
	
	let settingsAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold),
	                         NSForegroundColorAttributeName: UIColor.offWhite() ] as [String : Any]
	
	let detailAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold),
	                             NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	
	var settingDetailString = NSMutableAttributedString()
	
	var  settingsModel : SettingsModel? {
		
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
		
		self.setupSettingsDetails()
		
	}
	
	func setupSettingsDetails() {
		
		addSubnode(settingsTitle)
		addSubnode(settingsRightSubTitle)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
	
		settingsTitle.style.preferredSize = CGSize(width: 200, height: 21.0)
		settingsRightSubTitle.style.preferredSize = CGSize(width: 100.0, height: 21.0)
		
		let textSpec = ASStackLayoutSpec(direction: .horizontal,
		                                         spacing: 10.0,
		                                         justifyContent: .center,
		                                         alignItems: .center,
		                                         children: [settingsTitle, settingsRightSubTitle])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 17.0, left: 10.0, bottom: 17.0, right: 20.0), child: textSpec)
		
	}
	
	
}

