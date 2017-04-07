//
//  FeaturedWorkoutsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TopClubsCollectionCell: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var featuredCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var featuredClubsArray = [ClubModel]()
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveFeaturedWorkouts = PaceAppServices()
		return retrieveFeaturedWorkouts
		
	}()

	override init() {
		super.init()
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 22.5, left: 20.0, bottom: 22.5, right: 20.0)
		self.featuredCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		self.featuredCollectionNode?.backgroundColor = .clear
		self.featuredCollectionNode?.view.showsHorizontalScrollIndicator = false
		self.addSubnode(self.featuredCollectionNode!)
		
		
		
		paceAppService.retrieveFeaturedClubs { (featuredClubs) in
		
			self.featuredClubsArray = featuredClubs
			self.featuredCollectionNode?.reloadData()
			self.setupCollectionNodes()
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		
		}
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.clear
		
		featuredCollectionNode?.delegate   = self
		featuredCollectionNode?.dataSource = self
		featuredCollectionNode?.view.leadingScreensForBatching = 5.0
		featuredCollectionNode?.view.alwaysBounceHorizontal = true
		featuredCollectionNode?.view.allowsSelection = true
		featuredCollectionNode?.view.backgroundColor = UIColor.clear
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		featuredCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 330)
		return ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [featuredCollectionNode!])
		
	}


}

extension TopClubsCollectionCell {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return featuredClubsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let featuredCellNode = TopClubCell()
		featuredCellNode.featureCollection = self
		//featuredCellNode.workoutImageNode.url = NSURL(string: featuredWorkoutsArray[indexPath.item].workoutImageUrl!)! as URL
		featuredCellNode.exploreClubModel = featuredClubsArray[indexPath.item]
		return featuredCellNode
	
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let clubSelected = featuredClubsArray[indexPath.item]
		discoveryVC?.handleShowClubView(clubSelected: clubSelected)
		
	}
}
