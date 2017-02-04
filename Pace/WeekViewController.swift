//
//  WeekViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

var selectedDayColour = UIColor.paceBrandColor()

class WeekViewController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {

	var weekTableNode : ASTableNode?
	var weeklyWorkouts : [WeekRoutineModel]?
	
	lazy var WeeklyWorkoutsSetup: WeekDayViewModel = {
		
		let weeklyWorkoutsSetup = WeekDayViewModel()
		return weeklyWorkoutsSetup
		
	}()
	
	init() {
		
		weekTableNode = ASTableNode(style:.plain)
		super.init(node: weekTableNode!)
		
		self.setupWeekTableNode()
		self.setupWorkoutsDays()
//		self.uploadToFirebaseStorageUsingImage()
		
	}
	
	
//	private func uploadToFirebaseStorageUsingImage() {
//		
//		let imageName = NSUUID().uuidString
//		let ref = FIRStorage.storage().reference().child("PopularWorkoutImages").child(imageName)
//		
//		if let uploadData = UIImageJPEGRepresentation(UIImage(named: "1")!, 0.5) {
//			ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
//				
//				if error != nil {
//					print("Failed to upload image:", (error?.localizedDescription)!)
//					return
//				}
//				
//				if let imageUrl = metadata?.downloadURL()?.absoluteString {
//					self.createWorkoutWithImageUrl(imageUrl: imageUrl)
//				}
//				
//			})
//		}
//	}
//	
//	
//	private func createWorkoutWithImageUrl(imageUrl: String) {
//		
//		let ref = FIRDatabase.database().reference().child("ExploreWorkouts").child("Male").child("PopularWorkouts")
//		let childRef = ref.childByAutoId()
//		
//		let values = ["numberOfReviews": 334,
//		              "rating": 4,
//		              "trainerImageUrl": "",
//		              "trainerName": "Theodore Tyson Jr",
//		              "workoutImageURL": imageUrl,
//		              "workoutCatergory": WorkoutCatergory.home.rawValue,
//		              "workoutDescription": "If you are looking to get toned and enjoy fast paced interval training to shed far this workout is for you.",
//		              "workoutName" : "Weekend Cardio for Two",
//		              "workoutPrice" : PriceEnum.threeDollars.rawValue,
//		              "workoutTime" : 25] as [String : Any]
//	
//		childRef.updateChildValues(values) { (error, ref) in
//			if error != nil {
//				print((error?.localizedDescription)!)
//				return
//			}
//			
//		}
//	}

	
	func setupWorkoutsDays() {
		
		weeklyWorkouts = WeeklyWorkoutsSetup.setupWeekRoutine()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
		
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		UIApplication.shared.statusBarView?.backgroundColor = .black
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
	}
	
	func setupWeekTableNode() {
		
		self.weekTableNode?.delegate = self
		self.weekTableNode?.dataSource = self
		self.weekTableNode?.backgroundColor = UIColor.black
		self.weekTableNode?.view.separatorStyle = .none
		self.weekTableNode?.view.showsVerticalScrollIndicator = false
		
	}
	
}






