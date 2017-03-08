//
//  WeekViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseStorage
import FirebaseDatabase

var selectedDayColour = UIColor.paceBrandColor()

class WeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var weekTableView : UITableView?
	let weekCellID = "RoutineCellViewID"
	let workoutCellID = "workoutCellID"
	
	lazy var RoutineSetup: RoutinesViewModel = {
		
		let routineWorkoutsSetup = RoutinesViewModel()
		return routineWorkoutsSetup
		
	}()
	
	private func uploadToFirebaseStorageUsingImage() {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child("Workout-Team-Images").child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(UIImage(named: "3")!, 0.5) {
			ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
				
				if error != nil {
					print("Failed to upload image:", (error?.localizedDescription)!)
					return
				}
				
				if let imageUrl = metadata?.downloadURL()?.absoluteString {
					self.createWorkoutWithImageUrl(imageUrl: imageUrl)
				}
				
			})
		}
	}
	
	private func createWorkoutWithImageUrl(imageUrl: String) {
		
		let userID = FIRAuth.auth()!.currentUser!.uid
		let ref = FIRDatabase.database().reference().child("Workouts-Teams")
		let childRef = ref.childByAutoId()
		
		let values = ["name" : "V Shape Upper Body",
		              "workoutDescription": "If you are looking to get toned and enjoy fast paced interval training to shed far this workout is for you.",
						"backgroundImageUrl": imageUrl,
						"trainerID" : userID,
						"time" : 35,
						"rating": 4,
						"numberOfReviews": 334,
						"workoutPrice" : PriceEnum.threeDollars.rawValue,
						"workoutCatergory": WorkoutCatergory.cardio.rawValue
		              ] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
			//	Create workout Trainer Fan
			let userPostsRef = FIRDatabase.database().reference().child("fan-workout-trainer").child(userID)
			let messageId = childRef.key
			userPostsRef.updateChildValues([messageId: 1])
			
			//	Create Featured Workout fan
			let fanFeaturedWorkoutRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("featured-workout")
			let workoutId = childRef.key
			fanFeaturedWorkoutRef.updateChildValues([workoutId: 1])
			
			//	Create the Trainer Uploading the workout - Once
			//	self.uploadToFirebaseStorageUsingTrainerImage()
			
			
		}
	}
	
	private func uploadToFirebaseStorageUsingTrainerImage() {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child("Trainer-Images").child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(UIImage(named: "logo")!, 0.5) {
			ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
				
				if error != nil {
					print("Failed to upload image:", (error?.localizedDescription)!)
					return
				}
				
				if let imageUrl = metadata?.downloadURL()?.absoluteString {
					self.createTrainerWithImageUrl(imageUrl: imageUrl)
				}
				
			})
		}
	}
	
	
	private func createTrainerWithImageUrl(imageUrl: String) {
	
		let userID = FIRAuth.auth()!.currentUser!.uid
		let ref = FIRDatabase.database().reference().child("Trainers").child(userID)
		
		let values = ["name" : "Pace",
		              "email" : "workoutteam@paceapp.fitness",
		              "about": "If you want to go fast, go alone. If you want to go far, go together.",
		              "profileImageUrl": imageUrl,
		              "location" : "Cape Town, South Africa",
		              "qualification" : "Certificate in Personal Training - ISSA",
		              "speciality" : "Weight Loss, Toning and Shaping, Muscular Development and Core Strengthening"
			] as [String : Any]
		
		ref.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
		}
	
		
	}
	
	func setupRoutineData() {
		
		let weekCreationLaunch = UserDefaults.standard.bool(forKey: "routineCreationLaunch")
		if weekCreationLaunch  {
			
			//  Not First Launch
			
			
		} else {
			
			RoutineSetup.routinesCreation(completion: { 
				
				RoutineSetup.loadRoutineWorkouts()
				
			})
			
			UserDefaults.standard.set(true, forKey: "routineCreationLaunch")
			
			// **  Save Date for Renewing
			//self.firstLaunchDate()
			
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//self.uploadToFirebaseStorageUsingImage()
		
		RoutineSetup.loadRoutineWorkouts()
		
		self.setupWeekTableView()
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
		view.backgroundColor = UIColor.black
		weekTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		weekTableView?.reloadData()
		
		self.setupRoutineData()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		
		weekTableView?.reloadData()
	
	}
	
	func setupWeekTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		weekTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		weekTableView?.backgroundColor = .black
		weekTableView?.delegate = self
		weekTableView?.dataSource = self
		weekTableView?.separatorStyle = .none
		weekTableView?.showsVerticalScrollIndicator = false
		view.addSubview(weekTableView!)
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		UIApplication.shared.statusBarView?.backgroundColor = .black
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
	
	}
	
}






