//
//  CatergoryWorkoutCollection.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class CatergoryWorkoutCollection: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var catergoryCollection : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var catergoryArray : [CatergoryModel]?
	
	lazy var ExploreCatergorySetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 10.0, right: 20.0)
		catergoryCollection = ASCollectionNode(collectionViewLayout: flowLayout)
		addSubnode(catergoryCollection!)
		
		self.setupCollectionNodes()
		
		catergoryArray = ExploreCatergorySetup.setupWorkoutCatergory()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		catergoryCollection?.delegate   = self
		catergoryCollection?.dataSource = self
		catergoryCollection?.view.leadingScreensForBatching = 1.0
		catergoryCollection?.view.alwaysBounceHorizontal = true
		catergoryCollection?.view.allowsSelection = true
		catergoryCollection?.view.backgroundColor = UIColor.black
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		catergoryCollection?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 175)
		return ASStackLayoutSpec(direction: .horizontal,
		                         spacing: 0,
		                         justifyContent: .start,
		                         alignItems: .center,
		                         children: [catergoryCollection!])
		
	}
	
	
}

extension CatergoryWorkoutCollection {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (catergoryArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let catergoryCellNode = CatergoryCollectionCell()
		catergoryCellNode.catergory = catergoryArray?[indexPath.item]
		catergoryCellNode.catergoryCollection = self
		return catergoryCellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		//	TO DO
		discoveryVC?.showWorkoutCatergoryView()
		
	}
}

