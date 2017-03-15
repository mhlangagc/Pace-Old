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
		
		return 2
		
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
		sectionHeaderView.backgroundColor = UIColor.paceBackgroundBlack()
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 15.0, width: tableView.frame.width - 20, height: 25))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyBlackColor()
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		if section == 0 {
			
			return 0.0
			
		} else {
			
			return 55.0
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			
			return nil
			
		} else {
			
			return "ALL WORKOUTS"
			
		}
		
		
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			
			//let sectionInfo = RoutineSetup.fetchedResultsController.sections![section].numberOfObjects
			return weekDays.count
			
		} else {
			
			return downloadedWorkoutsArray.count
			
		}
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			
			//	let indexPathFound = IndexPath(item: indexPath.row, section: 0)
			let thisDay = weekDays[indexPath.item]	//RoutineSetup.fetchedResultsController.object(at: indexPathFound) as WorkoutsModel
			
			var routineCell = tableView.dequeueReusableCell(withIdentifier: weekCellID) as? WeekTableCell
			
			if (routineCell == nil) {
				tableView.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
				routineCell = tableView.dequeueReusableCell(withIdentifier: weekCellID) as? WeekTableCell
			}
			
			let date = Date()
			let formatter  = DateFormatter()
			formatter.dateFormat = "EEEE"
			let todayWorkoutName = formatter.string(from: date)
			
			if todayWorkoutName.uppercased() == thisDay.dayName?.uppercased() {
				
				routineCell?.todayIndicatorView.isHidden = false
				routineCell?.dayNameLabel.textColor = UIColor.white
				routineCell?.todayIndicatorView.backgroundColor = thisDay.color	//UIColor(fromHexString: thisDay.colour)
				
			} else {
				
				routineCell?.todayIndicatorView.isHidden = true
				
			}
			
			
			if (routineCell!.selectedBackgroundView != nil) {
				
				let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: routineCell!.frame.size.width, height: routineCell!.frame.size.height))
				backgroundView.backgroundColor = UIColor.darkBlack()
				routineCell!.selectedBackgroundView = backgroundView
			}
			
			routineCell?.routineModel = thisDay
			routineCell?.backgroundColor = UIColor.black
			
			return routineCell!
		
		} else {
			
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
			
			//	Retrieve Workout
			if let workoutName = downloadedWorkoutsArray[indexPath.item].name, let workoutTime = downloadedWorkoutsArray[indexPath.item].time, let imageURL = downloadedWorkoutsArray[indexPath.item].backgroundImageUrl {
				
				workoutCell?.workoutTimeLabel.text = "\(workoutTime) mins".uppercased()
				workoutCell?.workoutName.text = workoutName
					workoutCell?.workoutImage.loadImageFromCacheWithUrlString(urlString: imageURL)
				
			}
			
			workoutCell?.backgroundColor = UIColor.black
			
			
			return workoutCell!
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if indexPath.section == 0 {
			
			return 85.0
			
		} else {
			
			return 120.0
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if indexPath.section == 0 {
			
			let daySelected = weekDays[indexPath.item]
			selectedDayColour = daySelected.color!
			
			let emptyDayVC = EmptyDayViewController()
			emptyDayVC.routineWorkoutModel = daySelected
			emptyDayVC.hidesBottomBarWhenPushed = true
			self.navigationController?.pushViewController(emptyDayVC, animated: true)
			
			weekTableView?.deselectRow(at: indexPath, animated: true)
			
			
		} else {
			
			let dayDetailsVC = DayViewController()
			dayDetailsVC.exploreWorkout = downloadedWorkoutsArray[indexPath.item]
			dayDetailsVC.hidesBottomBarWhenPushed = true
			self.navigationController?.pushViewController(dayDetailsVC, animated: true)
			
			
			
		}
		
		
		
		weekTableView?.deselectRow(at: indexPath, animated: true)
		
	}
	
}
