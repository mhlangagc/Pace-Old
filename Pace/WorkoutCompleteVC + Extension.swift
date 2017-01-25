//
//  WorkoutCompleteVC + Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension WorkoutCompleteVIewController {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 42))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 22.0, width: tableView.frame.width - 20, height: 24))
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
		
		return "EXERCISES DONE"
		
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 120.0
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return (exercisesArray?.count)!
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var exerciseCell = tableView.dequeueReusableCell(withIdentifier: workoutCellViewID) as? WorkoutProcessCellView
		
		if (exerciseCell == nil) {
			tableView.register(WorkoutProcessCellView.self, forCellReuseIdentifier: workoutCellViewID)
			exerciseCell = tableView.dequeueReusableCell(withIdentifier: workoutCellViewID) as? WorkoutProcessCellView
		}
		
		exerciseCell?.exerciseModel = exercisesArray?[indexPath.item]
		exerciseCell?.timerButton.isHidden = true
		exerciseCell?.backgroundColor = UIColor.black
		
		return exerciseCell!
		
	}
	
	
}
