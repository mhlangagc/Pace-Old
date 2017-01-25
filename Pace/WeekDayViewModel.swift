//
//  WeekDayViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class WeekDayViewModel : NSObject {
	
	func setupWeekRoutine() -> [WeekRoutineModel] {
		
		let sunday = WeekRoutineModel()
		sunday.dayName = "Sunday"
		sunday.workoutName = "Cardio"
		sunday.color = UIColor.sunday()
		sunday.isOccupied = false
		sunday.isCompleted = false
		sunday.isRecovery = false
		sunday.backgroundImage = UIImage(named: "featuredWorkout")
		sunday.creatingTrainer = "Ell Marshall"
		sunday.creatingTrainerImage = UIImage(named: "trainer")
		
		
		let monday = WeekRoutineModel()
		monday.dayName = "Monday"
		monday.workoutName = "Leg Day"
		monday.color = UIColor.monday()
		monday.isOccupied = false
		monday.isCompleted = false
		monday.isRecovery = false
		monday.backgroundImage = UIImage(named: "legs")
		monday.creatingTrainer = "Maria Sharapova"
		monday.creatingTrainerImage = UIImage(named: "maria")
		
		
		let tuesday = WeekRoutineModel()
		tuesday.dayName = "Tuesday"
		tuesday.workoutName = "Recovery Day"
		tuesday.color = UIColor.tuesday()
		tuesday.isOccupied = false
		tuesday.isCompleted = false
		tuesday.isRecovery = true
		tuesday.backgroundImage = UIImage(named: "butt")
		tuesday.creatingTrainer = "Ell Marshall"
		tuesday.creatingTrainerImage = UIImage(named: "trainer")
		
		
		let wednesday = WeekRoutineModel()
		wednesday.dayName = "Wednesday"
		wednesday.workoutName = "Cardio"
		wednesday.color = UIColor.wednesday()
		wednesday.isOccupied = false
		wednesday.isCompleted = false
		wednesday.isRecovery = false
		wednesday.backgroundImage = UIImage(named: "20")
		wednesday.creatingTrainer = "Mila George"
		wednesday.creatingTrainerImage = UIImage(named: "cynthia")
		
		
		let thursday = WeekRoutineModel()
		thursday.dayName = "Thursday"
		thursday.workoutName = "Recovery Day"
		thursday.color = UIColor.thursday()
		thursday.isOccupied = false
		thursday.isCompleted = false
		thursday.isRecovery = true
		thursday.backgroundImage = UIImage(named: "21")
		thursday.creatingTrainer = "Justin Margolis"
		thursday.creatingTrainerImage = UIImage(named: "justin")
		
		
		let friday = WeekRoutineModel()
		friday.dayName = "Friday"
		friday.workoutName = "Core & Back"
		friday.color = UIColor.friday()
		friday.isOccupied = false
		friday.isCompleted = false
		friday.isRecovery = false
		friday.backgroundImage = UIImage(named: "22")
		friday.creatingTrainer = "Maria Sharapova"
		friday.creatingTrainerImage = UIImage(named: "maria")
		
		
		let saturday = WeekRoutineModel()
		saturday.dayName = "Saturday"
		saturday.workoutName = "Recovery Day"
		saturday.color = UIColor.saturday()
		saturday.isOccupied = false
		saturday.isCompleted = false
		saturday.isRecovery = true
		saturday.backgroundImage = UIImage(named: "23")
		saturday.creatingTrainer = "Simon Nicholson"
		saturday.creatingTrainerImage = UIImage(named: "simon")
		
		return [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
		
	}
	
	override init() {
		super.init()
		
	}
	
}

