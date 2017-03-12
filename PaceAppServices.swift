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
	
	//	User Retrieval
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
	
	//	Dicovery Workouts and Trainer Retrieva
	func retrieveMaleFeaturedWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		
		let fanExploreWorkoutsRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("featured-workout")
		
		fanExploreWorkoutsRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			
			workoutRef.observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let featuredWorkout = ExploreWorkoutModel()
					
					featuredWorkout.workoutID = workoutId
					featuredWorkout.name = dictionary["name"] as? String
					featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
					featuredWorkout.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					featuredWorkout.time = dictionary["time"] as? Int
					featuredWorkout.rating = dictionary["rating"] as? Int
					featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
					featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
					featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
					featuredWorkout.trainerID = dictionary["trainerID"] as? String
					
					workoutsArray.append(featuredWorkout)
					
					completion(workoutsArray)
					
					
				}
				
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
		
	}
	
	func retrieveMaleFreeWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		
		let fanExploreWorkoutsRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("free-workout")
		
		fanExploreWorkoutsRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			workoutRef.observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let featuredWorkout = ExploreWorkoutModel()
					
					featuredWorkout.workoutID = workoutId
					featuredWorkout.name = dictionary["name"] as? String
					featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
					featuredWorkout.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					featuredWorkout.time = dictionary["time"] as? Int
					featuredWorkout.rating = dictionary["rating"] as? Int
					featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
					featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
					featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
					featuredWorkout.trainerID = dictionary["trainerID"] as? String
					
					workoutsArray.append(featuredWorkout)
					
					completion(workoutsArray)
					
				}
				
				
			}, withCancel: nil)
			
			
		}, withCancel: nil)
		
	}
	
	func retrieveMalePopularWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		
		let fanExploreWorkoutsRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("popular-workout")
		
		fanExploreWorkoutsRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			workoutRef.observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let featuredWorkout = ExploreWorkoutModel()
					
					featuredWorkout.workoutID = workoutId
					featuredWorkout.name = dictionary["name"] as? String
					featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
					featuredWorkout.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					featuredWorkout.time = dictionary["time"] as? Int
					featuredWorkout.rating = dictionary["rating"] as? Int
					featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
					featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
					featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
					featuredWorkout.trainerID = dictionary["trainerID"] as? String
					
					workoutsArray.append(featuredWorkout)
					
					completion(workoutsArray)
					
					
				}
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
	}
	
	func retrieveTeamsFromWorkouts(completion: @escaping (_ result: [TeamsModel]) -> Void) {
		
		var teamsArray = [TeamsModel]()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		FIRDatabase.database().reference().child("fan-User-PurchasedWorkouts").child(userID).observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId).observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let workoutTeam = TeamsModel()
					
					workoutTeam.workoutID = workoutId
					workoutTeam.workoutName = dictionary["name"] as? String
					workoutTeam.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					workoutTeam.trainerID = dictionary["trainerID"] as? String
					
					teamsArray.append(workoutTeam)
					
					completion(teamsArray)
					
					
				}
				
			}, withCancel: nil)
			
			
		}, withCancel: nil)
		
		
	}
	
	func retrieveWorkoutExercises(exploreWorkout: ExploreWorkoutModel, completion: @escaping (_ result: [ExploreExerciseModel]) -> Void) {
		
		var exercises = [ExploreExerciseModel]()
		
		let fanExploreExercisesRef = FIRDatabase.database().reference().child("fan-Workout-Exercises").child((exploreWorkout.workoutID!))
		
		fanExploreExercisesRef.observe(.childAdded, with: { (snapshot) in
			
			let exerciseId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Exercises").child(exerciseId)
			workoutRef.observeSingleEvent(of: .value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let workoutExercise = ExploreExerciseModel()
					
					workoutExercise.exerciseID = exerciseId
					workoutExercise.exerciseName = dictionary["exerciseName"] as? String
					workoutExercise.distanceOrReps = dictionary["distanceOrReps"] as? Int
					workoutExercise.durationOrSets = dictionary["durationOrSets"] as? Int
					workoutExercise.weight = dictionary["weight"] as? Int
					workoutExercise.exerciseTime = dictionary["exerciseTime"] as? Int
					workoutExercise.exerciseType = dictionary["exerciseType"] as? String
					workoutExercise.exerciseImageUrl = dictionary["exerciseImageURL"] as? String
					workoutExercise.exerciseVideoURL = dictionary["exerciseVideoURL"] as? String
					
					exercises.append(workoutExercise)
					
					completion(exercises)
					
					
				}
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
		
	}
	
	
	func retrieveUserDownloadedWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		
		let fanUserDownloadedRef = FIRDatabase.database().reference().child("fan-User-PurchasedWorkouts").child(userID)
		
		fanUserDownloadedRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			workoutRef.observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let featuredWorkout = ExploreWorkoutModel()
					
					featuredWorkout.workoutID = workoutId
					featuredWorkout.name = dictionary["name"] as? String
					featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
					featuredWorkout.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					featuredWorkout.time = dictionary["time"] as? Int
					featuredWorkout.rating = dictionary["rating"] as? Int
					featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
					featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
					featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
					featuredWorkout.trainerID = dictionary["trainerID"] as? String
					
					workoutsArray.append(featuredWorkout)
					
					
					completion(workoutsArray)
					
					
				}
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
	}

	func retrieveUserDownloadedWorkoutIDs(completion: @escaping (_ result: [String]) -> Void) {
		
		var workoutIDArray = [String]()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		let fanUserDownloadedRef = FIRDatabase.database().reference().child("fan-User-PurchasedWorkouts").child(userID)
		
		fanUserDownloadedRef.observe(.childAdded, with: { (snapshot) in
			
			workoutIDArray.append(snapshot.key)
			completion(workoutIDArray)
			
		}, withCancel: nil)
		
	}
	
	
	func retrieveTrainer(exploreWorkout: ExploreWorkoutModel, completion: @escaping (_ result: User) -> Void) {
		
		if let trainerID = exploreWorkout.trainerID {
			
			FIRDatabase.database().reference().child("Trainers").child(trainerID).observeSingleEvent(of: .value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let workoutTrainer = User()
					
					workoutTrainer.userID = trainerID
					workoutTrainer.name = dictionary["name"] as? String
					workoutTrainer.location = dictionary["location"] as? String
					workoutTrainer.profileImageUrl = dictionary["profileImageUrl"] as? String
					workoutTrainer.speciality = dictionary["speciality"] as? String
					
					completion(workoutTrainer)
					
					
				}
				
			}, withCancel: nil)
			
		}
		
	}

	
	//	Team Interface

	
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
