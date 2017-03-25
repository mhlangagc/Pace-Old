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
		
		return 5
	
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		switch section {
		
		case 3:
			
			return allClubsArray.count
		
		default:
		
			return 1
		
		}
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		switch indexPath.section {
			
		case 0:
			
			let eventLabelCell = EventCollectionLabel()
			eventLabelCell.catergoryString = "Featured Clubs"
			return eventLabelCell
			
		case 1:
			
			let topClubsNode = TopClubsCollectionCell()
			topClubsNode.discoveryVC = self
			return topClubsNode
			
		case 2:
			
			let eventLabelCell = EventCollectionLabel()
			eventLabelCell.catergoryString = "All Clubs"
			return eventLabelCell
		
		case 3:
			
			let cellNode = DiscoveryWorkoutCell()
			cellNode.exploreWorkout = allClubsArray[indexPath.item]
			return cellNode
			
		default:
			
			let footerCell = FooterCell()
			footerCell.discoveryVC = self
			return footerCell
		
//
//		case 2:
//			
//			let allClubsVC  = AllClubsCollection()
//			allClubsVC.discoveryVC = self
//			return allClubsVC
			
//		case 3:
//			
//			let eventLabelCell = EventCollectionLabel()
//			return eventLabelCell
//
//		case 4:
//			
//			let eventCollection = EventCollection()
//			eventCollection.discoveryVC = self
//			return eventCollection
//			
//		case 5:
//			
//			let justAddedLabelNode = JustAddedLabel()
//			justAddedLabelNode.discoveryVC = self
//			return justAddedLabelNode
//			
//		case 6:
//			
//			let justAddedVC  = JustAddedCollection()
//			justAddedVC.discoveryVC = self
//			return justAddedVC
//			
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
			
//		default:
//			
//			let footerCell = FooterCell()
//			footerCell.discoveryVC = self
//			return footerCell
			
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

