//
//  ClubsViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase

extension ClubsViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
		
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
		sectionHeaderView.backgroundColor = UIColor.closeBlack()
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 15.0, width: tableView.frame.width - 20, height: 25))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyBlackColor()
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		if section == 0 {
			
			return 55.0
			
		} else {
			
			return 0.0
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			
			return "MY CLUBS"
			
		} else {
			
			return "GYM WORKOUTS"
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			
			return 1
			
		} else {
			
			return downloadedWorkoutsArray.count
			
		}
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			
			var clubCell = tableView.dequeueReusableCell(withIdentifier: clubCellID) as? ClubsTableViewCell
			
			if (clubCell == nil) {
				tableView.register(ClubsTableViewCell.self, forCellReuseIdentifier: clubCellID)
				clubCell = tableView.dequeueReusableCell(withIdentifier: clubCellID) as? ClubsTableViewCell
			}
			
			if (clubCell!.selectedBackgroundView != nil) {
				
				let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: clubCell!.frame.size.width, height: clubCell!.frame.size.height))
				backgroundView.backgroundColor = .red //UIColor.closeBlack()
				clubCell!.selectedBackgroundView = backgroundView
			}
			
			clubCell?.backgroundColor = .red
			
			return clubCell!

			
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
			
			workoutCell?.backgroundColor = UIColor.closeBlack()
			
			
			return workoutCell!
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if indexPath.section == 0 {
			
			return 210.0
			
		} else {
			
			return 0.0
			
		}
		
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if indexPath.section == 0 {
			
			//	to do
			
			
		} else {
			
			let dayDetailsVC = DayViewController()
			dayDetailsVC.exploreWorkout = downloadedWorkoutsArray[indexPath.item]
			dayDetailsVC.hidesBottomBarWhenPushed = true
			self.navigationController?.pushViewController(dayDetailsVC, animated: true)
			
		}
		
		
		
		clubsTableView?.deselectRow(at: indexPath, animated: true)
		
	}
	
}
