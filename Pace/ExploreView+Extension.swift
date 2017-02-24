//
//  ExploreView+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension ExploreViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return 8
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		switch indexPath.item {
		case 0:
			
			let featuredNode = FeaturedCollectionCell()
			featuredNode.discoveryVC = self
			//featuredNode.featuredWorkoutsArray = retrieveFeaturedWorkouts()
			return featuredNode
			
		case 1:
			
			let popularLabelNode = PopularLabel()
			popularLabelNode.discoveryVC = self
			return popularLabelNode
			
		case 2:
			
			let newToPaceVC  = NewToPaceCollection()
			newToPaceVC.discoveryVC = self
			return newToPaceVC
			
		case 3:
			
			let eventLabelCell = EventCollectionLabel()
			return eventLabelCell
			
		case 4:
			
			let eventCollection = EventCollection()
			eventCollection.discoveryVC = self
			return eventCollection
			
			
		case 5:
			
			let justAddedLabelNode = JustAddedLabel()
			justAddedLabelNode.discoveryVC = self
			return justAddedLabelNode
			
		case 6:
			
			let justAddedVC  = JustAddedCollection()
			justAddedVC.discoveryVC = self
			return justAddedVC
			
		default:
			
			let footerCell = FooterCell()
			footerCell.discoveryVC = self
			return footerCell
			
//		case 7:
//			
//			let trainersAndFriendsLabel = TrainersAndFriendsLabelCell()
//			trainersAndFriendsLabel.discoveryVC = self
//			return trainersAndFriendsLabel
//			
//		case 8:
//			
//			let followCollectionNode = TrainersAndFriendsCollectionNode()
//			followCollectionNode.exploreVC = self
//			return followCollectionNode
//			
//		default:
//			
//			
//			let footerCell = FooterCell()
//			footerCell.discoveryVC = self
//			return footerCell
			
			
		}
		
	}

	
}

