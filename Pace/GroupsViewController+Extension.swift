//
//  ProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension GroupsViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (chatGroupsArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let groupsNode = GroupCell()
		groupsNode.chatGroupModel = chatGroupsArray?[indexPath.item]
		return groupsNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let chatVC = ChatViewController()
		chatVC.chatModel = chatGroupsArray?[indexPath.item]
		chatVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(chatVC, animated: true)
		collectionNode.deselectItem(at: indexPath, animated: true)
		
		
	}
	

}

