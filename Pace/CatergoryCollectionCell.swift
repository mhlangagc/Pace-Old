//
//  CatergoryCollectionCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class CatergoryCollectionCell: BaseCell {
	
	var catergoryCollection: CatergoryWorkoutCollection?
	let catergoryImageNode = ASImageNode()
	let catergoryTitleNode = ASTextNode()
	
	let imageWidth : CGFloat = 220.0
	let imageHeight : CGFloat = 110.0
	
	//	Workout Name
	let catergoryNameAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 19, weight: UIFontWeightBlack),
	                             NSForegroundColorAttributeName: UIColor.white] as [String : Any]
	var catergoryMutableString = NSMutableAttributedString()
	
	
	var catergory : CatergoryModel? {
		
		didSet {
			
			if let catergoryImage  = catergory?.catergoryImage, let catergoryName = catergory?.catergoryName?.rawValue {
				
				catergoryImageNode.image = catergoryImage
				
				catergoryMutableString = NSMutableAttributedString(string: catergoryName, attributes: catergoryNameAttributes)
				
				let alignmentStyle = NSMutableParagraphStyle()
				alignmentStyle.alignment = NSTextAlignment.center
				catergoryMutableString.addAttributes([NSParagraphStyleAttributeName: alignmentStyle] as [String: Any], range: NSRange(location: 0, length: NSString(string: catergoryName).length))
				
				catergoryTitleNode.attributedText = catergoryMutableString
				
				
				
				
			}
			
		}
	}
	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		catergoryImageNode.backgroundColor = UIColor.darkBlack()
		catergoryImageNode.contentMode = .scaleAspectFill
		catergoryImageNode.layer.cornerRadius = 10.0
		catergoryImageNode.clipsToBounds = true
		addSubnode(catergoryImageNode)
		
		
		catergoryTitleNode.maximumNumberOfLines = 1
		addSubnode(catergoryTitleNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		catergoryImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		
		let insets = UIEdgeInsets(top: 42.0, left: 0.0, bottom: 42.0, right: 0.0)
		let titleTextInsetSpec = ASInsetLayoutSpec(insets: insets, child: catergoryTitleNode)
		
		return ASOverlayLayoutSpec(child: catergoryImageNode, overlay: titleTextInsetSpec)
		
		
	}
	
}

