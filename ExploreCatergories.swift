//
//  ExploreCatergories.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/30.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

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

class EventModel: NSObject {
	
	var eventName : String?
	var eventDate : String?
	var daysAway : String?
	var eventImage : UIImage?
	
}
