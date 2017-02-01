//
//  FeaturedCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FeaturedCell: BaseCell {
	
	var featureCollection: FeaturedCollectionCell?
	let workoutImageNode = ASImageNode()
	let featuredTageNode = ASImageNode()
	let workoutTitleNode = ASTextNode()
	
	
	let imageWidth : CGFloat = 325
	let imageHeight : CGFloat = 225
	
	let workoutNameAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 24, weight: UIFontWeightHeavy), NSForegroundColorAttributeName: UIColor.white] as [String : Any]
	var workoutNameMutableString = NSMutableAttributedString()
	
	var  exploreWorkoutModel : ExploreWorkoutModel? {
		
		didSet {
			
			if let imageDownloadedUrl = exploreWorkoutModel?.workoutImageUrl {
				
				let url = NSURL(string: imageDownloadedUrl)
				URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
					
					if error != nil {
						return
					}
					
					DispatchQueue.main.async {
						
						if let downloadedImage = UIImage(data: data!) {
							
							self.workoutImageNode.image = downloadedImage
						}
					}
					
					
				}).resume()
				
			}
			
			if let workoutName = exploreWorkoutModel?.workoutName {
				
				workoutNameMutableString = NSMutableAttributedString(string: workoutName, attributes: workoutNameAttributes)
				workoutTitleNode.attributedText = workoutNameMutableString
				
			}
			
			
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
		workoutImageNode.shouldRasterizeDescendants = true
		workoutImageNode.clipsToBounds = true
		addSubnode(workoutImageNode)
		
		featuredTageNode.image = UIImage(named: "featuredTag")
		featuredTageNode.contentMode = .scaleAspectFit
		featuredTageNode.clipsToBounds = true
		addSubnode(featuredTageNode)
		
		
		workoutTitleNode.maximumNumberOfLines = 2
		addSubnode(workoutTitleNode)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		workoutImageNode.style.preferredSize = CGSize(width: imageWidth, height: imageHeight)
		featuredTageNode.style.preferredSize = CGSize(width: 90.0, height: 22.0)
		
		let textNodeSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 10.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [featuredTageNode, workoutTitleNode])
		
		let insets = UIEdgeInsets(top: CGFloat.infinity, left: 20.0, bottom: 15.0, right: 10.0) // Infinity is used to make the inset unbounded
		let textInsetSpec = ASInsetLayoutSpec(insets: insets, child: textNodeSpec)
		
		return ASOverlayLayoutSpec(child: workoutImageNode, overlay: textInsetSpec)
		
		
	}
	
}
