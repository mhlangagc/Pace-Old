//
//  WorkoutProcessViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension WorkoutProcessViewController {
	
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
		
		
		if (exerciseCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: exerciseCell!.frame.size.width, height: exerciseCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			exerciseCell!.selectedBackgroundView = backgroundView
		}
		
		exerciseCell?.exerciseModel = exercisesArray?[indexPath.item]
		exerciseCell?.backgroundColor = UIColor.black
		
		return exerciseCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: true)
		
	}

	
	
}
