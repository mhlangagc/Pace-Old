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
	
	//	########### Workout Creation with Image
	private func uploadToFirebaseStorageUsingImage(image: UIImage, storageReferenceName: String, completion: @escaping (_ imageUrl: String) -> ()) {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child(storageReferenceName).child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(image, 0.5) {
			ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
				
				if error != nil {
					print("Failed to upload image:", (error?.localizedDescription)!)
					return
				}
				
				if let imageUrl = metadata?.downloadURL()?.absoluteString {
					completion(imageUrl)
				}
				
			})
	
		}
	
	}
	
	private func createWorkoutWithImageUrl() {
		
		let userID = FIRAuth.auth()!.currentUser!.uid
		let ref = FIRDatabase.database().reference().child("Workouts-Teams")
		let childRef = ref.childByAutoId()
		
		let values = ["name" : "Weekend Cardio for Two",
		              "workoutDescription": "If you are looking to get toned and enjoy fast paced interval training to shed far this workout is for you.",
						"backgroundImageUrl": "https://firebasestorage.googleapis.com/v0/b/pace-c9c8e.appspot.com/o/PopularWorkoutImages%2FBD454C4E-850E-47A5-BE4F-411C32DD6BA6?alt=media&token=bb2825a8-81cd-43a8-9bd4-d910a7a7fc5b",
						"trainerID" : userID,
						"time" : 30,
						"rating": 5,
						"numberOfReviews": 334,
						"workoutPrice" : PriceEnum.threeDollars.rawValue,
						"workoutCatergory": WorkoutCatergory.home.rawValue
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
			let fanFeaturedWorkoutRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("popular-workout")
			let workoutId = childRef.key
			fanFeaturedWorkoutRef.updateChildValues([workoutId: 1])
			
			//	Create the Trainer Uploading the workout - Once
			//	self.uploadToFirebaseStorageUsingTrainerImage()
			
			
		}
	}
	
	//	########### Exercise Creation
	private func handleVideoSelectedForUrl(url: NSURL, exericiseImage: UIImage) {
		
		let filename = NSUUID().uuidString + ".mp4"
		
		//	Get a localised URL to user 
		
		FIRStorage.storage().reference().child("Exercises").child(filename).putFile(url as URL, metadata: nil, completion: { (metadata, error) in
			
			if error != nil {
				print("Failed upload of video:", (error?.localizedDescription)!)
				return
			}
			
			if let videoUrl = metadata?.downloadURL()?.absoluteString {
				
				self.uploadToFirebaseStorageUsingImage(image: exericiseImage, storageReferenceName: "Exercise-Images", completion: { (imageUrl) in
					
					// "imageWidth": (thumbnailImage?.size.width)!, "imageHeight": (thumbnailImage?.size.height)!,
					
					let properties = ["exerciseImageURL": imageUrl,
					                  "exerciseVideoURL": videoUrl] as [String: Any]
					
					self.createExerciseWithProperties(properties: properties as [String : Any])
					
				})

			}
			
			
		
		})
		
	}
	
	private func createExerciseWithProperties(properties: [String: Any]) {
		
		let workoutID = "-KegY3GxO2C58L405kZA"	//Workout being uploaded to
		let ref = FIRDatabase.database().reference().child("Exercises")
		let childRef = ref.childByAutoId()
		
		var values = ["exerciseName": "Machine Low Row",
		              "distanceOrReps" : 2,
		              "durationOrSets" : 20,
		              "exerciseTime" : 20,
		              "weight" : 0,
		              "exerciseType" : ExerciseType.cardio.rawValue] as [String: Any]
		
		properties.forEach({values[$0] = $1})	// Apend the Above Values
		
		childRef.updateChildValues(values) { (error, ref) in
			if error != nil {
				
				print((error?.localizedDescription)!)
				return
			
			}
			
			let workoutExerciseRef = FIRDatabase.database().reference().child("fan-Workout-Exercises").child(workoutID)
			workoutExerciseRef.updateChildValues([childRef.key: 1])
		}

	}
	
	//	###########	Trainer Upload	##############
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
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveFeaturedWorkouts = PaceAppServices()
		return retrieveFeaturedWorkouts
		
	}()
	
	var downloadedWorkoutsArray = [ExploreWorkoutModel]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//self.createWorkoutWithImageUrl()
		//self.uploadToFirebaseStorageUsingImage()
		
		//	Create Exercise with Video
//		if let path = Bundle.main.path(forResource: "MachineLowRow", ofType:"mp4") {
//			
//			self.handleVideoSelectedForUrl(url: URL(fileURLWithPath: path) as NSURL, exericiseImage: UIImage(named: "MachineLowRow")!)
//		}
		
		
		
		RoutineSetup.loadRoutineWorkouts()
		
		self.setupWeekTableView()
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
		view.backgroundColor = UIColor.black
		weekTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		self.setupRoutineData()
		
		paceAppService.retrieveUserDownloadedWorkouts { (purchasedWorkoutsArray) in
			
			self.downloadedWorkoutsArray = purchasedWorkoutsArray
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			self.weekTableView?.reloadData()
			
		}
		
		
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






