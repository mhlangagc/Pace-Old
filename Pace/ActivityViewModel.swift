//
//  ActivityViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ActivityViewModel : NSObject {
	
	func setupPlaceholderActivity() -> [ActivitiesModel] {
		
		let today = ActivitiesModel()
		today.dayName = "Today"
		today.workoutName = "Wednesday Abs"
		today.dayColor = UIColor.sunday()
		today.steps = 23275
		today.sleepHours = 3
		today.sleepMins = 44
		today.workoutMins = 0
		
		let yesterday = ActivitiesModel()
		yesterday.dayName = "Yesterday"
		yesterday.workoutName = "Total Toning Abs"
		yesterday.dayColor = UIColor.tuesday()
		yesterday.steps = 16583
		yesterday.sleepHours = 6
		yesterday.sleepMins = 19
		yesterday.workoutMins = 34
		
		let monday = ActivitiesModel()
		monday.dayName = "Monday"
		monday.workoutName = "Legs & Bum day"
		monday.dayColor = UIColor.monday()
		monday.steps = 4569
		monday.sleepHours = 8
		monday.sleepMins = 13
		monday.workoutMins = 92
		
		
		let sunday = ActivitiesModel()
		sunday.dayName = "Sunday"
		sunday.workoutName = "Recovery Day"
		sunday.dayColor = UIColor.sunday()
		sunday.steps = 3679
		sunday.sleepHours = 5
		sunday.sleepMins = 33
		sunday.workoutMins = 0
		
		
		let saturday = ActivitiesModel()
		saturday.dayName = "Saturday"
		saturday.workoutName = "Recovery Day"
		saturday.dayColor = UIColor.saturday()
		saturday.steps = 1356
		saturday.sleepHours = 10
		saturday.sleepMins = 22
		saturday.workoutMins = 0
		
		
		let friday = ActivitiesModel()
		friday.dayName = "Friday"
		friday.workoutName = "Belly Buster"
		friday.dayColor = UIColor.friday()
		friday.steps = 15369
		friday.sleepHours = 5
		friday.sleepMins = 23
		friday.workoutMins = 56
		
		return [today, yesterday, monday, sunday, saturday, friday]
		
	}
	
	func setupPlaceHolderNews() -> [ActivityNewsModel] {
	
		let news_1 = ActivityNewsModel()
		news_1.trainerName = "Mila Pollock"
		news_1.workoutName = "Boxing Abs"
		news_1.trainerImage = UIImage(named: "mila")
		news_1.workoutImage = UIImage(named: "22")
		
		let news_2 = ActivityNewsModel()
		news_2.trainerName = "Justin Margolis"
		news_2.workoutName = "Killer Arms & Shoulders"
		news_2.trainerImage = UIImage(named: "justin")
		news_2.workoutImage = UIImage(named: "21")
		
		
		let news_3 = ActivityNewsModel()
		news_3.trainerName = "Simon Nicholson"
		news_3.workoutName = "For Recovery"
		news_3.trainerImage = UIImage(named: "simon")
		news_3.workoutImage = UIImage(named: "23")
		
		let news_4 = ActivityNewsModel()
		news_4.trainerName = "Cynthia George"
		news_4.workoutName = "Love Handles"
		news_4.trainerImage = UIImage(named: "cynthia")
		news_4.workoutImage = UIImage(named: "20")
		
		
		return [news_1, news_2, news_3, news_4]
	}
	
	override init() {
		super.init()
		
	}
	
}

