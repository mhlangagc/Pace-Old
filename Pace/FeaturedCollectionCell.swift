//
//  FeaturedWorkoutsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FeaturedCollectionCell: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var featuredCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var featuredWorkoutsArray = [ExploreWorkoutModel]()

	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 22.5, left: 20.0, bottom: 22.5, right: 20.0)
		featuredCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		addSubnode(featuredCollectionNode!)
		
		self.setupCollectionNodes()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		featuredCollectionNode?.delegate   = self
		featuredCollectionNode?.dataSource = self
		featuredCollectionNode?.view.alwaysBounceHorizontal = true
		featuredCollectionNode?.view.allowsSelection = true
		featuredCollectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		featuredCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 270)
		return ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [featuredCollectionNode!])
		
	}


}

extension FeaturedCollectionCell {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return featuredWorkoutsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let featuredCellNode = FeaturedCell()
		featuredCellNode.featureCollection = self
		print(featuredWorkoutsArray[indexPath.item].workoutName!)
		featuredCellNode.exploreWorkoutModel = featuredWorkoutsArray[indexPath.item]
		return featuredCellNode
	
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let worktoutSelected = featuredWorkoutsArray[indexPath.item]
		WorkoutViewController.exploreWorkout = worktoutSelected
		discoveryVC?.handleShowWorkoutView()
		
	}
}
