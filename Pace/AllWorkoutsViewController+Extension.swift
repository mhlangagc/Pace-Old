//
//  AllWorkoutsViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension AllWorkoutsViewController {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return 7	//(workoutsPassed?.count)!
		
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		let workoutDetailCellNode = WorkoutsCell()
		//workoutDetailCellNode.exploreWorkout = workoutsPassed?[indexPath.item]
		return workoutDetailCellNode
		
	}
	
	
}

