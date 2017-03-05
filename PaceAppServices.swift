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
				
				featuredWorkout.workoutID = exploreID
				featuredWorkout.name = dictionary["workoutName"] as? String
				featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
				featuredWorkout.backgroundImageUrl = dictionary["workoutImageURL"] as? String
				featuredWorkout.time = dictionary["workoutTime"] as? Int
				featuredWorkout.rating = dictionary["rating"] as? Int
				featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
				featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
				featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
				
				
				workoutArray.append(featuredWorkout)
				
				
			}
			
		}, withCancel: nil)
		
		return workoutArray
		
	}
	
	func retrieveTeamsFromWorkouts(completion: @escaping (_ result: [TeamsModel]) -> Void) {
		
		var teamsArray = [TeamsModel]()
		
		FIRDatabase.database().reference().child("WorkoutAndTeam").child("Male").observe(FIRDataEventType.childAdded, with: { (snapShot) in
			
			let workoutID = snapShot.key
			
			if let dictionary = snapShot.value as? [String: AnyObject] {
				
				let workoutTeam = TeamsModel()
				
				workoutTeam.workoutID = workoutID
				workoutTeam.workoutName = dictionary["name"] as? String
				workoutTeam.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
				workoutTeam.trainerID = dictionary["trainerID"] as? String
				
				teamsArray.append(workoutTeam)
				
				completion(teamsArray)
				
				
			}
			
		}, withCancel: nil)
		
		
	}

	
	func handleSendMessageToTeam(message: String, teamID: String) {
		
		let ref = FIRDatabase.database().reference().child("TeamMessages")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		let values = ["message" : message,
		              "userSending": userID,
		              "timeStamp": Int(NSDate().timeIntervalSince1970),
		              "teamID": teamID] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
			let userPostsRef = FIRDatabase.database().reference().child("fan-user-messages").child(userID)
			let messageId = childRef.key
			userPostsRef.updateChildValues([messageId: 1])
			
			let workoutTeamMessagesRef = FIRDatabase.database().reference().child("fan-team-messages").child(teamID)
			workoutTeamMessagesRef.updateChildValues([messageId: 1])
			

		}

	}
	
}
