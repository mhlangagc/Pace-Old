//
//  PostViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension PostViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		
		return 1
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return messagesArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let postCellNode = PostsCell()
		postCellNode.messagesModel = messagesArray[indexPath.item]
		return postCellNode
		
	
	}
	
	
}

