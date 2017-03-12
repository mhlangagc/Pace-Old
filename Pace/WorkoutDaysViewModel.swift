//
//  WeekRoutineViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutDaysViewModel {
	
	func setupWeekRoutines() -> [WorkoutDaysModel] {
		
		let sunday = WorkoutDaysModel()
		sunday.dayName = "Sun"
		sunday.workoutName = "-"
		sunday.color = UIColor.sunday()
		
		let monday = WorkoutDaysModel()
		monday.dayName = "Mon"
		monday.workoutName = "-"
		monday.color = UIColor.monday()
		
		let tuesday = WorkoutDaysModel()
		tuesday.dayName = "Tue"
		tuesday.workoutName = "-"
		tuesday.color = UIColor.tuesday()
		
		let wednesday = WorkoutDaysModel()
		wednesday.dayName = "Wed"
		wednesday.workoutName = "-"
		wednesday.color = UIColor.wednesday()
		
		let thursday = WorkoutDaysModel()
		thursday.dayName = "Thu"
		thursday.workoutName = "-"
		thursday.color = UIColor.paceBrandColor()
		
		let friday = WorkoutDaysModel()
		friday.dayName = "Fri"
		friday.workoutName = "-"
		friday.color = UIColor.friday()
		
		let saturday = WorkoutDaysModel()
		saturday.dayName = "Sat"
		saturday.workoutName = "-"
		saturday.color = UIColor.saturday()
		
		return [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
		
	}

	
}
