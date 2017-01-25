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
	case butt = "For your Butt"
	case armsAndShoulders = "For Arms & Shoulders"
	case cardio = "Cardio & Weight Loss"
	case recovery = "For Workout Recovery"
	case mobility = "For Stretching & Relaxing"
	case sevenmin = "Short & Sweet"
	
}

class CatergoryModel: NSObject {
	
	var catergoryName : WorkoutCatergory?
	var catergoryImage : UIImage?
	
}
