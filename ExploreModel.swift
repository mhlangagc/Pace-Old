//
//  DiscoveryWorkout.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

enum PriceEnum : Double {
	
	case free  = 0.00
	case oneDollars = 9.99
	case twoDollars = 19.99
	case threeDollars = 29.99
	case fourDollars = 39.99
	case ficeFiveDollars = 49.99
	case sixDollars = 59.99
	case sevenDollars = 69.99
	case eightDollars = 79.99
	case nineDollars = 89.99
	case tenDollars = 99.99
	case fifteenFiveDollars = 149.99
	case twentyDollars = 199.99
	
}

enum WorkoutCatergory: String {
	
	case legs = "Great for Legs"
	case core = "for your core"
	case butt = "For your Butt"
	case armsAndShoulders = "For Arms & Shoulders"
	case cardio = "Cardio & Weight Loss"
	case recovery = "For Workout Recovery"
	case mobility = "For Stretching & Relaxing"
	case sevenmin = "7 min workout"
	case chest = "For your Chest"
	case home = "Home Workout"
	
}

class ExploreExerciseModel: NSObject {
	
	var exerciseID : String?
	var exerciseName : String?
	var exerciseVideoURL: String?
	var exerciseImageUrl : String?
	var distanceOrReps: Int?
	var durationOrSets: Int?
	var weight: Int?
	var exerciseTime: Int?
	var exerciseType: String?
	
}

class ExploreWorkoutModel: NSObject {
	
	var workoutID : String?
	var name : String?
	var workoutDescription: String?
	var backgroundImageUrl : String?
	var trainerID: String?
	var time: Int?
	var rating: Int?
	var numberOfReviews: Int?
	var workoutPrice : PriceEnum?
	var workoutCatergory : WorkoutCatergory?
	var teamMessages: NSSet?
	var teamMembers: NSSet?
	var workoutExercises: NSSet?
	
}



class EventModel: NSObject {
	
	var eventName : String?
	var eventDate : String?
	var daysAway : String?
	var eventImage : UIImage?
	
}


