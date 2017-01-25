//
//  PopularCollection.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class NewToPaceCollection: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var newWorkoutsCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var popularWorkoutsArray : [ExploreModel]?
	
	lazy var ExploreWorkoutSetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumLineSpacing       = 15
		flowLayout.minimumInteritemSpacing = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 15.0, right: 15.0)
		newWorkoutsCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		addSubnode(newWorkoutsCollectionNode!)
		
		self.setupCollectionNodes()
		
		popularWorkoutsArray = ExploreWorkoutSetup.setupNewToPaceWorkout()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		newWorkoutsCollectionNode?.delegate   = self
		newWorkoutsCollectionNode?.dataSource = self
		newWorkoutsCollectionNode?.view.leadingScreensForBatching = 1.0
		newWorkoutsCollectionNode?.view.alwaysBounceHorizontal = true
		newWorkoutsCollectionNode?.view.allowsSelection = true
		newWorkoutsCollectionNode?.view.backgroundColor = UIColor.black
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		newWorkoutsCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 265)
		
		return ASStackLayoutSpec(direction: .horizontal,
		                         spacing: 0,
		                         justifyContent: .start,
		                         alignItems: .center,
		                         children: [newWorkoutsCollectionNode!])
	}
	
	
}

extension NewToPaceCollection {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (popularWorkoutsArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let cellNode = DiscoveryWorkoutCell()
		cellNode.exploreWorkout = popularWorkoutsArray?[indexPath.item]
		return cellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let worktoutSelected = popularWorkoutsArray?[indexPath.item]
		WorkoutViewController.exploreWorkout = worktoutSelected
		discoveryVC?.handleShowWorkoutView()
		
	}
	
}
