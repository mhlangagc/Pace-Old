//
//  WorkoutDownloadViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension WorkoutDownloadViewController {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 85.0
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 7
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		//	let indexPathFound = IndexPath(item: indexPath.row, section: 0)
		//	let thisDay = RoutineSetup.fetchedResultsController.object(at: indexPathFound) as WorkoutsModel
		
		var routineCell = tableView.dequeueReusableCell(withIdentifier: workoutDaysCellID) as? WeekTableCell
		
		if (routineCell == nil) {
			tableView.register(WeekTableCell.self, forCellReuseIdentifier: workoutDaysCellID)
			routineCell = tableView.dequeueReusableCell(withIdentifier: workoutDaysCellID) as? WeekTableCell
		}
		
		routineCell?.dayNameLabel.text = "Sun"
		routineCell?.workoutNameText.text = "-"
		routineCell?.todayIndicatorView.isHidden = true
		routineCell?.activityIndicator.isHidden = true
		
		if (routineCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: routineCell!.frame.size.width, height: routineCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkerBlack()
			routineCell!.selectedBackgroundView = backgroundView
		
		}
		
		routineCell?.backgroundColor = UIColor.black
		
		return routineCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: true)
		
	}

	
}
