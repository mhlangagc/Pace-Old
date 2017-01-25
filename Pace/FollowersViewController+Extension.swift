//
//  FollowersViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit


extension FollowersViewController {
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		
		return 1
		
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		
		return 14
		
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		
		return FollowerFollowingCellNode()
		
	}
	
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		
		let exploreProfileVC = DiscoverProfileViewController()
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
		
		tableNode.deselectRow(at: indexPath, animated: true)
		
	}
}
