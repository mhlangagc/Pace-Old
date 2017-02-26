//
//  WorkoutViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/26.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class WorkoutViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  WorkoutDetailsHeaderView()
	var workoutDetailsTableView : UITableView?
	var getButtonView : GetButtonView?
	let exerciseCellID = "ExerciseCellViewID"
	
	var exercisesArray : [ExercisesModel]?
	
	lazy var ExerciseSetup: ExerciseViewModel = {
		
		let exericiseSetup = ExerciseViewModel()
		return exericiseSetup
		
	}()
	
	static var exploreWorkout : ExploreWorkoutModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//exercisesArray = ExerciseSetup.setupExercises()
		
		self.setupWorkoutDetailsTableView()
		self.setupNavigationBar()
		self.setupGetButton()
		view.backgroundColor = UIColor.black
		workoutDetailsTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		self.workoutDetailsTableView?.reloadData()
		
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
		
		self.setupHeaderView()
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
	
	func setupHeaderView() {
		
		headerView  = WorkoutDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 515.0))
		headerView.workoutDetailVC = self
		
		headerView.workoutName?.text = (WorkoutViewController.exploreWorkout?.workoutName)!
		headerView.workoutsImageView?.loadImageFromUrlString(urlString: (WorkoutViewController.exploreWorkout?.workoutImageUrl)!)
		headerView.workoutTimeLabel?.text = "\((WorkoutViewController.exploreWorkout?.workoutMins)!) min workout".uppercased()
		headerView.profileNameButton?.setTitle("Created by \((WorkoutViewController.exploreWorkout?.trainerName)!)", for: UIControlState.normal)
		headerView.profileImageView?.loadImageFromUrlString(urlString: (WorkoutViewController.exploreWorkout?.trainerImageUrl)!)
		headerView.descriptionText?.text = (WorkoutViewController.exploreWorkout?.workoutDescription)!
		headerView.reviewLabel?.text = "\((WorkoutViewController.exploreWorkout?.numberOfReviews)!) Reviews"
		headerView.ratingView?.ratingValue = (WorkoutViewController.exploreWorkout?.rating)!
		
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	
	func setupGetButton() {
		
		getButtonView = GetButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 144.0, width: view.frame.width, height: 80.0))
		getButtonView?.workoutDetailsVC = self
		
		let price = WorkoutViewController.exploreWorkout?.workoutPrice?.rawValue
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
		
		//let exploreProfileVC = DiscoverProfileViewController()
		//self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
	}
	
	
	func handleShareWorkout() {
		
		shareLinkVC(linkString: "You've got to check out this workout on Pace. Download the app here : AppLink")
		
	}

}



