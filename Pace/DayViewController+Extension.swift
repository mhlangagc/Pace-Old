//
//  DayViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/27.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension DayViewController {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 16.0, width: tableView.frame.width - 20, height: 24))
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
		
		return "5 EXERCISES"
		
		
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
		
		var exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		
		if (exerciseCell == nil) {
			tableView.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
			exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		}
		
		
		if (exerciseCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: exerciseCell!.frame.size.width, height: exerciseCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			exerciseCell!.selectedBackgroundView = backgroundView
		}
		
		exerciseCell?.exerciseModel = exercisesArray?[indexPath.item]
		exerciseCell?.backgroundColor = UIColor.black
		//exerciseCell?.videoDelegate = self
		
		return exerciseCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: true)
		
	}
	
	
}
