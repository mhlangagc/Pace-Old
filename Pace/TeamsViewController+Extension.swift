//
//  ProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit


extension TeamsViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		
		return 1
	
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return clubsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let clubNode = ClubCell()
		clubNode.clubModel = clubsArray[indexPath.item]
		
		self.retrieveUsersUsingWorkout(workoutID: clubsArray[indexPath.item].clubID!, completion: { (usersFound) in
			
			clubNode.numberOfUsers = usersFound.count
			
		})
		
		return clubNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
//		let flowLayout = UICollectionViewFlowLayout()
//		flowLayout.scrollDirection = .vertical
		let teamMessagesVC = PostViewController()
		teamMessagesVC.userName = self.userName
		teamMessagesVC.userImageURL = self.userImageURL
		teamMessagesVC.teamModel = clubsArray[indexPath.item]
		teamMessagesVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(teamMessagesVC, animated: true)
		collectionNode.deselectItem(at: indexPath, animated: true)
		
		
	}
	

}

