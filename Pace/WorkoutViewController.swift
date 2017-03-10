//
//  WorkoutViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/26.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import LBTAComponents
import Firebase
import FirebaseAuth
import FirebaseDatabase

class WorkoutViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  WorkoutDetailsHeaderView()
	var workoutDetailsTableView : UITableView?
	var getButtonView : GetButtonView?
	let exerciseCellID = "ExerciseCellViewID"
	var trainer = User()
	
	var exercisesArray = [ExploreExerciseModel]()
	var exploreWorkout : ExploreWorkoutModel?
	
	func retrieveWorkoutExercises(completion: @escaping (_ result: [ExploreExerciseModel]) -> Void) {
		
		var exercises = [ExploreExerciseModel]()
		
		let fanExploreExercisesRef = FIRDatabase.database().reference().child("fan-Workout-Exercises").child((exploreWorkout?.workoutID!)!)
		
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

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupWorkoutDetailsTableView()
		self.setupNavigationBar()
		self.setupGetButton()
		view.backgroundColor = UIColor.black
		workoutDetailsTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
		
		self.setupHeaderView()
		self.retrieveTrainer { (workoutTrainer) in
			
			if let trainerName = workoutTrainer.name, let trainerImageUrl = workoutTrainer.profileImageUrl {
				
				self.headerView.profileNameButton?.setTitle("Created by \(trainerName)", for: UIControlState.normal)
				self.headerView.profileImageView?.loadImageFromUrlString(urlString: trainerImageUrl)
				
			}
			
		}
		
		self.retrieveWorkoutExercises { (exerciseArrayFound) in
			
			self.exercisesArray = exerciseArrayFound
			self.workoutDetailsTableView?.reloadData()
			
		}
		
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height - 144.0)
		workoutDetailsTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutDetailsTableView?.backgroundColor = .black
		workoutDetailsTableView?.delegate = self
		workoutDetailsTableView?.dataSource = self
		workoutDetailsTableView?.separatorStyle = .none
		workoutDetailsTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutDetailsTableView!)
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareVC"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShareWorkout))
		self.navigationController?.navigationBar.barTintColor = UIColor.darkerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkerBlack()
		
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
	
	func retrieveTrainer(completion: @escaping (_ result: User) -> Void) {
		
		if let trainerID = self.exploreWorkout?.trainerID {
			
			FIRDatabase.database().reference().child("Trainers").child(trainerID).observeSingleEvent(of: .value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let workoutTrainer = User()
					
					workoutTrainer.userID = trainerID
					workoutTrainer.name = dictionary["name"] as? String
					workoutTrainer.location = dictionary["location"] as? String
					workoutTrainer.profileImageUrl = dictionary["profileImageUrl"] as? String
					workoutTrainer.speciality = dictionary["speciality"] as? String
					
					self.trainer = workoutTrainer
					
					completion(self.trainer)
					
					
				}
				
			}, withCancel: nil)
			
		}
		
		
		
		
	}
	
	func setupHeaderView() {
		
		headerView  = WorkoutDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 515.0))
		headerView.workoutDetailVC = self
		
		headerView.workoutName?.text = (self.exploreWorkout?.name)!
		headerView.workoutsImageView?.loadImageFromUrlString(urlString: (self.exploreWorkout?.backgroundImageUrl)!)
		headerView.workoutTimeLabel?.text = "\((self.exploreWorkout?.time)!) min workout".uppercased()
		headerView.descriptionText?.text = (self.exploreWorkout?.workoutDescription)!
		headerView.reviewLabel?.text = "\((self.exploreWorkout?.numberOfReviews)!) Reviews"
		headerView.ratingView?.ratingValue = (self.exploreWorkout?.rating)!
		
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	
	func setupGetButton() {
		
		getButtonView = GetButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 144.0, width: view.frame.width, height: 80.0))
		getButtonView?.workoutDetailsVC = self
		
		let price = self.exploreWorkout?.workoutPrice?.rawValue
		if price == 0.0 {
			
			getButtonView?.getButton?.setTitle("FREE", for: UIControlState.normal)
			
		} else {
			
			getButtonView?.getButton?.setTitle("R\(price!)", for: UIControlState.normal)
		}
		
		view.addSubview(getButtonView!)
		
	}

	lazy var popUpLauncher: GetPopupLauncher = {
		
		let launcher = GetPopupLauncher()
		return launcher
		
	}()
	
	func launchGetPopUp() {
		
		if let window = UIApplication.shared.keyWindow {
			
			popUpLauncher.showGetPopUp(currentView: window)
		}
		
	}
	
	func handleTryWorkout() {
		
//		let workoutProcessViewController = WorkoutProcessViewController()
//		self.navigationController?.present(UINavigationController(rootViewController: workoutProcessViewController), animated: true, completion: {
//			
//			//	TO DO
//			
//		})
		
	}
	
	func handleOpenProfile() {
		
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.trainer = trainer
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
	}
	
	
	func handleShareWorkout() {
		
		shareLinkVC(linkString: "You've got to check out this workout on Pace. Download the app here : AppLink")
		
	}

}



