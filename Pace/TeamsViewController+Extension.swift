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
		
		return (teamWorkoutsArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let teamNode = TeamCell()
		teamNode.teamModel = teamWorkoutsArray?[indexPath.item]
		return teamNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
//		let flowLayout = UICollectionViewFlowLayout()
//		flowLayout.scrollDirection = .vertical
//		let communityPteamWorkoutsArrayostsVC = CommunityPostsViewController(collectionViewLayout: flowLayout)
//		communityPostsVC.chatModel = teamWorkoutsArray?[indexPath.item]
//		communityPostsVC.hidesBottomBarWhenPushed = true
//		self.navigationController?.pushViewController(communityPostsVC, animated: true)
//		collectionNode.deselectItem(at: indexPath, animated: true)
		
		
	}
	

}

