//
//  ExerciseModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

enum ExerciseType : String {
	
	case cardio  = "Cardio"
	case stretch = "Stretch"
	case strength = "Strength"
}

class ExercisesModel : NSObject {
	
	var exerciseName: String?
	var exerciseType: ExerciseType?
	var exerciseImage : UIImage?
	var distanceOrReps: NSNumber?
	var durationOrSets: NSNumber?
	var exerciseTime: NSNumber?
	
	var weight: NSNumber?
	//var workout: WorkoutModel?
	
}

