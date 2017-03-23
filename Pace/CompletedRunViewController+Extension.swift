//
//  CompletedRunViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/23.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension CompletedRunViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 0
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 0
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		
		if (exerciseCell == nil) {
			tableView.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
			exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		}
		
		return exerciseCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: false)
		
	}
	
}

