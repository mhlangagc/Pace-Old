//
//  WeekViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension WeekViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return (weeklyWorkoutsArray?.count)!
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var routineCell = tableView.dequeueReusableCell(withIdentifier: weekCellID) as? WeekTableCell
		let todayFromArray = weeklyWorkoutsArray?[indexPath.item]
		
		if (routineCell == nil) {
			tableView.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
			routineCell = tableView.dequeueReusableCell(withIdentifier: weekCellID) as? WeekTableCell
		}
		
		let date = Date()
		let formatter  = DateFormatter()
		formatter.dateFormat = "EEEE"
		let todayWorkoutName = formatter.string(from: date)
		
		if todayWorkoutName.uppercased() == todayFromArray?.dayName?.uppercased() {
			
			routineCell?.todayIndicatorView.isHidden = false
			routineCell?.weekNameText.textColor = UIColor.white
			routineCell?.todayIndicatorView.backgroundColor = todayFromArray?.color
			
		} else {
			
			routineCell?.todayIndicatorView.isHidden = true
			
		}

		
		
		if (routineCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: routineCell!.frame.size.width, height: routineCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			routineCell!.selectedBackgroundView = backgroundView
		}
		
		routineCell?.routineModel = todayFromArray
		routineCell?.backgroundColor = UIColor.black
		
		return routineCell!
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 85.0
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let daySelected = weeklyWorkoutsArray?[indexPath.item]
		selectedDayColour = (daySelected?.color)!
		
		let dayDetailsVC = DayViewController()
		dayDetailsVC.routineWorkoutModel = daySelected
		dayDetailsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(dayDetailsVC, animated: true)
		
		weekTableView?.deselectRow(at: indexPath, animated: true)
		
		
	}
	
}
