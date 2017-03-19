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
	var joinButtonView : JoinButtonView?
	let exerciseCellID = "ExerciseCellViewID"
	var trainer = User()
	
	var exercisesArray = [ExploreExerciseModel]()
	var downloadedWorkoutIDArray = [String]()
	var club : ClubModel?
	
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()
	
	override var prefersStatusBarHidden: Bool {
		
		return false
		
	}
	
	
	func userClubCreation(completion: @escaping (_ completed: Bool) -> ()) {
		
		let userID = FIRAuth.auth()!.currentUser!.uid
		let clubID = self.club?.clubID
		
		let userDownloadedWorkoutsRef = FIRDatabase.database().reference().child("fan-User-JoinedClubs").child(userID)
		userDownloadedWorkoutsRef.updateChildValues([clubID!: 1])
		
		let purchasedWorkoutsUserRef = FIRDatabase.database().reference().child("fan-Club-Members").child(clubID!)
		purchasedWorkoutsUserRef.updateChildValues([userID: 1])
		
	}
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupWorkoutDetailsTableView()
		self.setupNavigationBar()
		self.setupJoinButton()
		view.backgroundColor = UIColor.paceBackgroundBlack()
		workoutDetailsTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
		self.setupHeaderView()
		
		paceAppService.retrieveClubTrainer(club: self.club!) { (trainer) in
			
			self.trainer = trainer
			
			if let trainerName = trainer.name, let trainerImageUrl = trainer.profileImageUrl {
				
				self.headerView.profileNameButton?.setTitle("Created by \(trainerName)", for: UIControlState.normal)
				self.headerView.profileImageView?.loadImageFromCacheWithUrlString(urlString: trainerImageUrl)
				
			}
			
		}
		
//		paceAppService.retrieveWorkoutExercises(exploreWorkout: club!) { (exerciseArrayFound) in
//			
//			self.exercisesArray = exerciseArrayFound
//			self.workoutDetailsTableView?.reloadData()
//			
//		}
		
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
			
			if eachID == club?.clubID {
				
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
		
		headerView.workoutName?.text = (self.club?.name)!
		headerView.workoutsImageView?.loadImageFromCacheWithUrlString(urlString: (self.club?.backgroundImageUrl)!)
		headerView.memberNumberLabel?.text = "345 Members"
		
		headerView.kmNumberLabel?.text = "\((self.club?.distance)!)"
		headerView.totalRunsNumberLabel?.text = "\((self.club?.totalRuns)!)"
		headerView.paceNumberLabel?.text = "\((self.club?.paceMins)!):\((self.club?.paceSeconds)!)"
		headerView.descriptionText?.text = (self.club?.clubDescription)!
		
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	func setupJoinButton() {
		
		joinButtonView = JoinButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 144.0, width: view.frame.width, height: 80.0))
		joinButtonView?.workoutVC = self
		joinButtonView?.joinButton?.setTitle("Join", for: UIControlState.normal)
		joinButtonView?.joinButton?.setTitleColor(.black, for: UIControlState.normal)
		joinButtonView?.joinButton?.backgroundColor = UIColor.paceBrandColor()
		view.addSubview(joinButtonView!)
		
	}
	
	func joinClub() {
		
//		self.userClubCreation(completion: { (completed) in
//			
//			print("Club Joined")
//			
//			self.joinButtonView?.joinButton?.setTitle("Club Joined", for: UIControlState.normal)
//			self.joinButtonView?.joinButton?.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
//			self.joinButtonView?.joinButton?.backgroundColor = UIColor.headerBlack()
//			
//		})
		
	}
	
	
	func setupGetButton() {
		
//		getButtonView = GetButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 144.0, width: view.frame.width, height: 80.0))
//		getButtonView?.workoutDetailsVC = self
//		
//		let price = self.exploreWorkout?.workoutPrice?.rawValue
//		if price == 0.0 {
//			
//			getButtonView?.getButton?.setTitle("FREE", for: UIControlState.normal)
//			
//		} else {
//			
//			getButtonView?.getButton?.setTitle("R\(price!)", for: UIControlState.normal)
//		}
//		
//		view.addSubview(getButtonView!)
		
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



