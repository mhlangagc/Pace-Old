//
//  PaceAppServices.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/31.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PaceAppServices : NSObject {
	
	func retrieveUser(completion: @escaping (User) -> ()) {
		
		if let userID = FIRAuth.auth()?.currentUser?.uid {
			
			FIRDatabase.database().reference().child("Users").child(userID).observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let user = User()
					user.name = dictionary["name"] as? String
					user.profileImageUrl = dictionary["profileImageUrl"] as? String
					user.location = dictionary["location"] as? String
					user.about = dictionary["about"] as? String
					
					completion(user)
					
				}
				
			})
			
		}
		
	}
	
	
	func retrieveFeaturedWorkouts() -> [ExploreWorkoutModel] {
		
		var workoutArray = [ExploreWorkoutModel]()
		
		FIRDatabase.database().reference().child("ExploreWorkouts").child("FeaturedWorkouts").observe(FIRDataEventType.childAdded, with: { (snapShot) in
			
			let exploreID = snapShot.key
			
			if let dictionary = snapShot.value as? [String: AnyObject] {
				
				let featuredWorkout = ExploreWorkoutModel()
				
				featuredWorkout.workoutName = dictionary["workoutName"] as? String
				featuredWorkout.workoutMins = dictionary["workoutMins"] as? Int
				featuredWorkout.workoutImageUrl = dictionary["workoutImageUrl"] as? String
				
				featuredWorkout.trainerName = dictionary["trainerName"] as? String
				featuredWorkout.trainerImageUrl = dictionary["trainerImageUrl"] as? String
				
				featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
				featuredWorkout.rating = dictionary["rating"] as? Int
				featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
				featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
				featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
				
				featuredWorkout.exploreID = exploreID
				
				
				workoutArray.append(featuredWorkout)
				
				DispatchQueue.main.async {
					
					// Completion Function
					
					
				}
				
			}
			
		}, withCancel: nil)
		
		return workoutArray
		
	}
}
