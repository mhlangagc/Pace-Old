//
//  DiscoverProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit


extension DiscoverProfileViewController {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 15.0, width: tableView.frame.width - 20, height: 24))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyBlackColor()
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 55.0
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return "\(trainerWorkoutsArray.count) CREATED WORKOUTS"
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 120.0
	
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return trainerWorkoutsArray.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var workoutCell = tableView.dequeueReusableCell(withIdentifier: workoutCellID) as? WorkoutCellView
		
		if (workoutCell == nil) {
			tableView.register(WorkoutCellView.self, forCellReuseIdentifier: workoutCellID)
			workoutCell = tableView.dequeueReusableCell(withIdentifier: workoutCellID) as? WorkoutCellView
		}
		
		
		if (workoutCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: workoutCell!.frame.size.width, height: workoutCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			workoutCell!.selectedBackgroundView = backgroundView
		}
		
		workoutCell?.workoutModel = trainerWorkoutsArray[indexPath.item]
		workoutCell?.backgroundColor = UIColor.black
		
		return workoutCell!
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let worktoutSelected = trainerWorkoutsArray[indexPath.item]
		let showWorkoutDetailsVC = WorkoutViewController()
		showWorkoutDetailsVC.exploreWorkout = worktoutSelected
		self.navigationController?.pushViewController(showWorkoutDetailsVC, animated: true)
		
		tableView.deselectRow(at: indexPath, animated: true)
		
	}

}

