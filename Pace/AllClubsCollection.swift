//
//  PopularCollection.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AllClubsCollection: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var allClubsCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var allClubsArray = [ExploreWorkoutModel]()
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveFreeWorkouts = PaceAppServices()
		return retrieveFreeWorkouts
		
	}()
	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumLineSpacing       = 15
		flowLayout.minimumInteritemSpacing = 15
		flowLayout.scrollDirection = .vertical
		flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 15.0, right: 15.0)
		allClubsCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		allClubsCollectionNode?.backgroundColor = .black
		addSubnode(allClubsCollectionNode!)
		
		paceAppService.retrieveMaleFreeWorkouts { (freeWorkoutsArray) in
			
			self.allClubsArray = freeWorkoutsArray
			self.allClubsCollectionNode?.reloadData()
			
			self.setupCollectionNodes()
		}

		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		allClubsCollectionNode?.delegate   = self
		allClubsCollectionNode?.dataSource = self
		allClubsCollectionNode?.view.leadingScreensForBatching = 1.0
		allClubsCollectionNode?.view.alwaysBounceHorizontal = true
		allClubsCollectionNode?.view.allowsSelection = true
		allClubsCollectionNode?.view.backgroundColor = UIColor.black
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		allClubsCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 290)
		
		return ASStackLayoutSpec(direction: .horizontal,
		                         spacing: 0,
		                         justifyContent: .start,
		                         alignItems: .center,
		                         children: [allClubsCollectionNode!])
	}
	
	
}

extension AllClubsCollection {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return allClubsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let cellNode = DiscoveryWorkoutCell()
		cellNode.exploreWorkout = allClubsArray[indexPath.item]
		return cellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
//		let clubSelected = freeWorkoutsArray[indexPath.item]
//		discoveryVC?.handleShowClubView(clubSelected: clubSelected)
		
	}
	
}
