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
	
	
	//  self.uploadToFirebaseStorageUsingImage()
	
	private func uploadToFirebaseStorageUsingImage() {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child("PopularWorkoutImages").child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(UIImage(named: "1")!, 0.5) {
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
		
		let ref = FIRDatabase.database().reference().child("WorkoutAndTeam").child("Male")
		let childRef = ref.childByAutoId()
		
		let values = ["name" : "Weekend Cardio for Two",
		              "workoutDescription": "If you are looking to get toned and enjoy fast paced interval training to shed far this workout is for you.",
						"backgroundImageUrl": imageUrl,
						"trainerID" : "",
						"time" : 25,
						"rating": 4,
						"numberOfReviews": 334,
						"workoutPrice" : PriceEnum.threeDollars.rawValue,
						"workoutCatergory": WorkoutCatergory.home.rawValue
		              ] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
//			let workoutMessagesRef = FIRDatabase.database().reference().child("workout-messages").child(fromId) // Child should be the postID
//			
//			let messageId = childRef.key
//			userMessagesRef.updateChildValues([messageId: 1])
//			
//			let recipientUserMessagesRef = FIRDatabase.database().reference().child("user-messages").child(toId)
//			recipientUserMessagesRef.updateChildValues([messageId: 1])
			
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






