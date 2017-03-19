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
	var joinButton : StartButtonView?
	let exerciseCellID = "ExerciseCellViewID"
	var trainer = User()
	
	var exercisesArray = [ExploreExerciseModel]()
	var downloadedWorkoutIDArray = [String]()
	var exploreWorkout : ExploreWorkoutModel?
	
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()
	
	override var prefersStatusBarHidden: Bool {
		
		return false
		
	}
	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupWorkoutDetailsTableView()
		self.setupNavigationBar()
		self.setupJoinButton()
		view.backgroundColor = UIColor.paceBackgroundBlack()
		workoutDetailsTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
		self.setupHeaderView()
		
		paceAppService.retrieveTrainer(exploreWorkout: exploreWorkout!) { (workoutTrainer) in
			
			self.trainer = workoutTrainer
			
			if let trainerName = workoutTrainer.name, let trainerImageUrl = workoutTrainer.profileImageUrl {
				
				self.headerView.profileNameButton?.setTitle("Created by \(trainerName)", for: UIControlState.normal)
				self.headerView.profileImageView?.loadImageFromCacheWithUrlString(urlString: trainerImageUrl)
				
			}
			
		}
		
		paceAppService.retrieveWorkoutExercises(exploreWorkout: exploreWorkout!) { (exerciseArrayFound) in
			
			self.exercisesArray = exerciseArrayFound
			self.workoutDetailsTableView?.reloadData()
			
		}
		
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height - 144.0)
		workoutDetailsTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutDetailsTableView?.backgroundColor = .paceBackgroundBlack()
		workoutDetailsTableView?.delegate = self
		workoutDetailsTableView?.dataSource = self
		workoutDetailsTableView?.separatorStyle = .none
		workoutDetailsTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutDetailsTableView!)
		
		
		
	}
	
	func checkIfWorkoutIsDownloaded() {
		
		for eachID in downloadedWorkoutIDArray {
			
			if eachID == exploreWorkout?.workoutID {
				
				self.setupJoinButton()
				
			} else {
				
				self.setupGetButton()
				
			}
			
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		//		paceAppService.retrieveUserDownloadedWorkoutIDs { (IDs) in
		//
		//			self.downloadedWorkoutIDArray = IDs
		//			self.checkIfWorkoutIsDownloaded()
		//		}
		
		
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
	
	func setupHeaderView() {
		
		headerView  = WorkoutDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 635.0))
		headerView.workoutDetailVC = self
		
		headerView.workoutName?.text = (self.exploreWorkout?.name)!
		headerView.workoutsImageView?.loadImageFromCacheWithUrlString(urlString: (self.exploreWorkout?.backgroundImageUrl)!)
		headerView.workoutTimeLabel?.text = "\((self.exploreWorkout?.time)!) min workout".uppercased()
		headerView.descriptionText?.text = (self.exploreWorkout?.workoutDescription)!
		headerView.memberNumberLabel?.text = "345 Members" //"\((self.exploreWorkout?.numberOfReviews)!) Reviews"
		headerView.ratingView?.ratingValue = (self.exploreWorkout?.rating)!
		
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	func setupJoinButton() {
		
		joinButton = StartButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 144.0, width: view.frame.width, height: 80.0))
		//startButtonView?.dayDetailsVC = self
		joinButton?.startButton?.setTitle("Join", for: UIControlState.normal)
		joinButton?.startButton?.setTitleColor(.black, for: UIControlState.normal)
		joinButton?.startButton?.backgroundColor = UIColor.paceBrandColor()
		view.addSubview(joinButton!)
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

	func handleDownloadWorkout() {
		
		let workoutDownloadVC = WorkoutDownloadViewController()
		workoutDownloadVC.workoutDetailsVC = self
		let navVC = UINavigationController(rootViewController: workoutDownloadVC)
		self.present(navVC, animated: true, completion: nil)
		
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



