//
//  FeaturedCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TopCell: BaseCell {
	
	var featureCollection: TopClubsCollectionCell?
	let workoutImageNode = ASNetworkImageNode()
	let lockImageNode = ASImageNode()
	let clubNameTextNode = ASTextNode()
	let clubDetailsTextNode = ASTextNode()

	
	let imageWidth : CGFloat = 335
	let imageHeight : CGFloat = 210
	
	let workoutNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack), NSForegroundColorAttributeName: UIColor.white] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()
	
	
	let clubDetailsAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold),
	                           NSForegroundColorAttributeName: UIColor.greyBlackColor()] as [String : Any]
	var clubDetailsMutableString = NSMutableAttributedString()
	
	var  exploreClubModel : ClubModel? {
		
		didSet {
			
			workoutImageNode.url = NSURL(string: (exploreClubModel?.backgroundImageUrl!)!)! as URL
			
			if let workoutName = exploreClubModel?.name {
				
				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
				clubNameTextNode.attributedText = workoutNameMutableString
				
			}
			
			clubDetailsMutableString = NSMutableAttributedString(string: "347 Members    •    459km    •   4k Runs", attributes: clubDetailsAttributes)
			clubDetailsTextNode.attributedText = clubDetailsMutableString
			
			
		}
	}

	
	override func setupNodes() {
		super.setupNodes()
		
		backgroundColor = UIColor.black
		self.setupImageAndText()
		
	}
	
	func setupImageAndText() {
		
		workoutImageNode.backgroundColor = UIColor.darkerBlack()
		workoutImageNode.contentMode = .scaleAspectFill
		workoutImageNode.layer.cornerRadius = 10.0
		workoutImageNode.clipsToBounds = true
		addSubnode(workoutImageNode)
		
		lockImageNode.image = UIImage(named: "lock")
		lockImageNode.layer.cornerRadius = 15.0
		lockImageNode.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
		lockImageNode.layer.masksToBounds = true
		lockImageNode.contentMode = .scaleAspectFit
		addSubnode(lockImageNode)
		
		clubNameTextNode.maximumNumberOfLines = 1
		addSubnode(clubNameTextNode)
		
		addSubnode(clubDetailsTextNode)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		workoutImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		lockImageNode.style.preferredSize = CGSize(width: 30, height: 30)
		clubNameTextNode.style.preferredSize = CGSize(width: imageWidth, height: 26)
		clubDetailsTextNode.style.preferredSize = CGSize(width: imageWidth, height: 20)
		
		let lockImageNodeSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: imageWidth - 45.0, bottom: imageHeight - 45.0, right: 15.0), child: lockImageNode)
		let imagesOverlaySpec = ASOverlayLayoutSpec(child: workoutImageNode, overlay: lockImageNodeSpec)
		
		
		let layoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 20,
		                                   justifyContent: .start,
		                                   alignItems: .start,
		                                   children: [imagesOverlaySpec, clubNameTextNode])
		
		let finalLayoutSpec = ASStackLayoutSpec(direction: .vertical,
		                                   spacing: 15,
		                                   justifyContent: .start,
		                                   alignItems: .start,
		                                   children: [layoutSpec, clubDetailsTextNode])
		
		
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 25.0, left: 0.0, bottom: 30.0, right: 0.0), child: finalLayoutSpec)
		
		
	}
	
}
