//
//  CatergoryWorkoutCollection.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class EventCollection: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var catergoryCollection : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var eventsArray : [EventModel]?
	
	lazy var ExploreEventSetup: ExploreViewModel = {
		
		let exploreEventSetup = ExploreViewModel()
		return exploreEventSetup
		
	}()
	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 20.0, right: 20.0)
		catergoryCollection = ASCollectionNode(collectionViewLayout: flowLayout)
		addSubnode(catergoryCollection!)
		
		self.setupCollectionNodes()
		
		eventsArray = ExploreEventSetup.setupEvents()
		
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
		catergoryCollection?.view.backgroundColor = UIColor.clear
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		catergoryCollection?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 400)
		return ASStackLayoutSpec(direction: .horizontal,
		                         spacing: 0,
		                         justifyContent: .start,
		                         alignItems: .center,
		                         children: [catergoryCollection!])
		
	}
	
	
}

extension EventCollection {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (eventsArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let eventCellNode = EventCollectionCell()
		eventCellNode.event = eventsArray?[indexPath.item]
		eventCellNode.eventCollection = self
		return eventCellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		//	TO DO
		//discoveryVC?.showWorkoutCatergoryView()
		
	}
}

