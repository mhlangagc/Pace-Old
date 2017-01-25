//
//  WeekViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension WeekViewController {
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		
		return 1
		
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		
		return (weeklyWorkouts?.count)!
		
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		
		let weekTableCell = WeekTableNodeCell()
		weekTableCell.routineModel = weeklyWorkouts?[indexPath.item]
		return weekTableCell
		
	}
	
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		
		let daySelected = weeklyWorkouts?[indexPath.item]
		selectedDayColour = (daySelected?.color)!
		
		let dayDetailsVC = DayViewController()
		dayDetailsVC.routineWorkoutModel = daySelected
		dayDetailsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(dayDetailsVC, animated: true)
		
		tableNode.deselectRow(at: indexPath, animated: true)
		
	}
}
