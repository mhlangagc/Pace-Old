//
//  DiscoverProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DiscoverProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
	
	var headerView =  ProfileHeaderView()
	var profileTableView : UITableView?
	let workoutCellID = "WorkoutCellViewID"
	var trainer : User?
	var trainerWorkoutsArray = [ExploreWorkoutModel]()
	
	func retrieveTrainerWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		let trainerID = trainer?.userID
		
		let fanWorkoutTrainerRef = FIRDatabase.database().reference().child("fan-workout-trainer").child(trainerID!)
		
		fanWorkoutTrainerRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			workoutRef.observeSingleEvent(of: .value, with: { (snapShot) in
				
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationNoLineBar()
		view.backgroundColor = UIColor.black
		
		self.retrieveTrainerWorkouts { (workoutsFound) in
			
			self.trainerWorkoutsArray = workoutsFound
			self.profileTableView?.reloadData()
			
			self.setupWorkoutDetailsTableView()
			self.setupHeaderView()
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareVC"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShareProfile))
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black

	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height - 64)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		profileTableView?.backgroundColor = .black
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		profileTableView?.register(WorkoutCellView.self, forCellReuseIdentifier: workoutCellID)
		view.addSubview(profileTableView!)
		
		
	}
	
	func setupHeaderView() {
		
		headerView  = ProfileHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300.0)) //365.0
		headerView.discoverProfileVC = self
		
		headerView.nameLabel?.text = (trainer?.name)!
		headerView.profileImageView?.loadImageFromUrlString(urlString: (trainer?.profileImageUrl)!)
		headerView.locationLabel?.text = (trainer?.location)!
		headerView.detailsLabel?.text = (trainer?.speciality)!
		profileTableView?.tableHeaderView = headerView
		
	}
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func sizeHeaderToFit() {
		
		headerView.setNeedsLayout()
		headerView.layoutIfNeeded()
		
		let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = headerView.frame
		frame.size.height = height
		headerView.frame = frame
	}

	func handleOpenSettings() {
		
		//	TODO
		print("Open Settings")
		
	}
	
	func handleOpenFollowersView() {
		
		//	TODO
		print("Show Followers")
		
	}
	
	func handleOpenFollowingView() {
		
		//	TODO
		print("Show Following")
	}
	
	func handleFollowButton() {
		
		//	TODO
		print("Follow")
	
	}
	
	func handleShareProfile() {
		
		shareLinkVC(linkString: "You've got to check out this trainer on Pace. Download the app here : AppLink")
		
	}
	
	
}
