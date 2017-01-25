//
//  RatingsNode.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RatingsNode: ASDisplayNode {
	
	var ratingValue = 4
	
	func createRatingImageNode() -> ASImageNode {
		
		let ratingIv = ASImageNode()
		ratingIv.image = UIImage(named: "star")
		ratingIv.contentMode = .scaleAspectFit
		ratingIv.layer.masksToBounds = true
		return ratingIv
		
		
	}
	
	var star_1Node : ASImageNode?
	var star_2Node : ASImageNode?
	var star_3Node : ASImageNode?
	var star_4Node : ASImageNode?
	var star_5Node : ASImageNode?
	
	var ratingTextNode = ASTextNode()
	
	override init() {
		super.init()
		setupNodes()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupNodes() {
		
		backgroundColor = UIColor.black
		self.setupRatingNodes()
		
	}
	
	
	func setupRatingNodes() {
		
		star_1Node = createRatingImageNode()
		addSubnode(star_1Node!)
		
		star_2Node = createRatingImageNode()
		addSubnode(star_2Node!)
		
		star_3Node = createRatingImageNode()
		addSubnode(star_3Node!)
		
		star_4Node = createRatingImageNode()
		addSubnode(star_4Node!)
		
		star_5Node = createRatingImageNode()
		addSubnode(star_5Node!)
		
	}
	
	func ratingsStarsColours() {
		
		switch ratingValue {
		case 1:
			
			star_1Node?.view.tintColor = UIColor.wednesday()
			
			break
			
		case 2:
			star_1Node?.view.tintColor = UIColor.wednesday()
			star_2Node?.view.tintColor = UIColor.wednesday()
			
			break
			
		case 3:
			
			star_1Node?.view.tintColor = UIColor.wednesday()
			star_2Node?.view.tintColor = UIColor.wednesday()
			star_3Node?.view.tintColor = UIColor.wednesday()
			
			break
			
		case 4:
			
			star_1Node?.view.tintColor = UIColor.wednesday()
			star_2Node?.view.tintColor = UIColor.wednesday()
			star_3Node?.view.tintColor = UIColor.wednesday()
			star_4Node?.view.tintColor = UIColor.wednesday()
			
			break
			
		case 5:
			star_1Node?.view.tintColor = UIColor.wednesday()
			star_2Node?.view.tintColor = UIColor.wednesday()
			star_3Node?.view.tintColor = UIColor.wednesday()
			star_4Node?.view.tintColor = UIColor.wednesday()
			star_5Node?.view.tintColor = UIColor.wednesday()
			
			break
			
			
		default:
			
			break
		}

		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		star_1Node?.style.preferredSize = CGSize(width: 10.0, height: 10.0)
		star_2Node?.style.preferredSize = CGSize(width: 10.0, height: 10.0)
		star_3Node?.style.preferredSize = CGSize(width: 10.0, height: 10.0)
		star_4Node?.style.preferredSize = CGSize(width: 10.0, height: 10.0)
		star_5Node?.style.preferredSize = CGSize(width: 10.0, height: 10.0)
		
		return ASStackLayoutSpec(direction: .horizontal,
		                                           spacing: 7.1,
		                                           justifyContent: .start,
		                                           alignItems: .center,
		                                           children: [star_1Node!, star_2Node!, star_3Node!, star_4Node!, star_5Node!])
		
		
		
	}
}
