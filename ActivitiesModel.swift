//
//  ActivitiesModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import Foundation

class ActivitiesModel : NSObject {
	
	var dayName : String?
	var workoutName: String?
	var dayColor : UIColor?
	var sleepHours : Int?
	var sleepMins: Int?
	var steps: Int?
	var workoutMins: Int?
	
}

class ActivityNewsModel: NSObject {
	
	var trainerName : String?
	var workoutName: String?
	var trainerImage : UIImage?
	var workoutImage : UIImage?
	
}
