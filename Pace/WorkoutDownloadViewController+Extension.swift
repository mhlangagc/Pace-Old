//
//  WorkoutDownloadViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension WorkoutDownloadViewController {
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 0.0, y: 25.0, width: tableView.frame.width, height: 20))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyBlackColor()
		sectionHeaderLabel.textAlignment = .center
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		if section == 0 {
			
			return 0.0
			
		} else {
			
			return 70.0
		
		}
		
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			
			return nil
			
		} else  {
			
			return "or pick a workout day"
			
		}
		
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if indexPath.section == 0 {
			
			return 70.0
			
		} else {
			
			return 85.0
			
		}
	}
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
		
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			
			return 1
			
		} else {
			
			return weekDays.count
			
		}
		
		
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			
			let saveToMyWorkoutsCell = tableView.dequeueReusableCell(withIdentifier: SaveToMyRoutinesCellID) as? SaveToMyRoutinesCell
			
			if (saveToMyWorkoutsCell!.selectedBackgroundView != nil) {
				
				let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: saveToMyWorkoutsCell!.frame.size.width, height: saveToMyWorkoutsCell!.frame.size.height))
				backgroundView.backgroundColor = UIColor.darkerBlack()
				saveToMyWorkoutsCell!.selectedBackgroundView = backgroundView
				
			}
			
			return saveToMyWorkoutsCell!
			
		} else {
			
			let routineCell = tableView.dequeueReusableCell(withIdentifier: workoutDaysCellID) as? WeekTableCell
			
			if (routineCell!.selectedBackgroundView != nil) {
				
				let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: routineCell!.frame.size.width, height: routineCell!.frame.size.height))
				backgroundView.backgroundColor = UIColor.darkerBlack()
				routineCell!.selectedBackgroundView = backgroundView
				
			}
			
			routineCell?.dayNameLabel.text = weekDays[indexPath.item].dayName
			routineCell?.workoutNameText.text = weekDays[indexPath.item].workoutName
			routineCell?.workoutNameText.textColor = weekDays[indexPath.item].color
			routineCell?.todayIndicatorView.isHidden = true
			routineCell?.activityIndicator.isHidden = true
			
			routineCell?.backgroundColor = UIColor.black
			
			return routineCell!
		}
		
		
	}
	
	//  TableView Delegation
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: true)
		
	}

	
}
