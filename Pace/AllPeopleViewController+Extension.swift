//
//  AllPeopleViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension AllPeopleViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (allTrainersArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let workoutDetailCellNode = FollowProfileCell()
		print(indexPath.item)
		workoutDetailCellNode.trainerModel = allTrainersArray?[indexPath.item]
		return workoutDetailCellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		print(indexPath.item)
		let exploreProfileVC = DiscoverProfileViewController()
		DiscoverProfileViewController.userProfileModel = allTrainersArray?[indexPath.item]
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
	}
	
}

