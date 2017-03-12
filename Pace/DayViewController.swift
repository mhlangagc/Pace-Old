//
//  DayViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/27.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class DayViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  DayHeaderViewController()
	var workoutDetailsTableView : UITableView?
	var startButtonView : StartButtonView?
	let exerciseCellID = "ExerciseCellViewID"
	var routineWorkoutModel : WorkoutDaysModel?
	
	var exercisesArray : [ExercisesModel]?
	
	lazy var ExerciseSetup: ExerciseViewModel = {
		
		let exericiseSetup = ExerciseViewModel()
		return exericiseSetup
		
	}()

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//exercisesArray = ExerciseSetup.setupExercises()
		
		self.setupWorkoutDetailsTableView()
		self.setupNavigationBar()
		self.setupStartButton()
		view.backgroundColor = UIColor.black
		workoutDetailsTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
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
		self.setupHeaderView()
		self.workoutDetailsTableView?.reloadData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationItem.title = routineWorkoutModel?.dayName
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more"), style: .done, target: self, action: #selector(handleMore))
		//	self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(handleClose))
		self.navigationController?.navigationBar.tintColor = UIColor.white
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
		
		headerView  = DayHeaderViewController.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 330.0))
		//headerView.workoutsImageView?.image = routineWorkoutModel?.backgroundImage
		headerView.workoutName?.text = routineWorkoutModel?.workoutName
//		headerView.profileImageView?.image = routineWorkoutModel?.creatingTrainerImage
//		if let trainerName = routineWorkoutModel?.creatingTrainer {
//			headerView.profileNameButton?.setTitle("by \(trainerName)", for: UIControlState.normal)
//		}
		
		headerView.dayDetailVC = self
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	/*
	//	WeekTableCell Delegate Methods
	let videoCellHeight: CGFloat = 270.0
	
	func didBeginVideo(cell: ExerciseCellView) {
		
		print((workoutDetailsTableView?.contentOffset.y)!)
		print(cell.frame.origin.y)
		
		let editingOffset = (workoutDetailsTableView?.contentOffset.y)! - cell.frame.origin.y as CGFloat
		let visibleCells = workoutDetailsTableView?.visibleCells as! [ExerciseCellView]
		
		for cell in visibleCells {
			
			UIView.animate(withDuration: 0.3, animations: {
				
				cell.transform = CGAffineTransform(translationX: 0, y: editingOffset + 50.0)
				self.headerView.transform = CGAffineTransform(translationX: 0, y: editingOffset)
				self.startButtonView?.transform = CGAffineTransform(translationX: 0, y: -editingOffset)
				
				if cell !== cell {
					
					cell.alpha = 0.3
					
				}
			})
			
			
		}
		
	}
 
	func didEndBeginVideoView(cell: ExerciseCellView) {
		
		
		let visibleCell = workoutDetailsTableView?.visibleCells as! [ExerciseCellView]
		
		for cell: ExerciseCellView in visibleCell {
			
			UIView.animate(withDuration: 0.3, animations: {
				
				cell.transform = CGAffineTransform.identity
				self.headerView.transform = CGAffineTransform.identity
				self.startButtonView?.transform = CGAffineTransform.identity
				
				if cell !== cell {
					
					cell.alpha = 1.0
				}
				
				
			})
			
		}
		
		
	}
	*/
	
	func setupStartButton() {
		
		startButtonView = StartButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 134.0, width: view.frame.width, height: 70.0))
		startButtonView?.dayDetailsVC = self
		startButtonView?.startButton?.backgroundColor = selectedDayColour
		view.addSubview(startButtonView!)
	}
	
	
	func handleOpenProfile() {
		
		//let exploreProfileVC = DiscoverProfileViewController()
//		DiscoverProfileViewController.userProfileModel
		//self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
	}
	
	func startWorkout() {
		
		let workoutProcessViewController = WorkoutProcessViewController()
		let navBar = UINavigationController(rootViewController: workoutProcessViewController)
		self.navigationController?.present(navBar, animated: true, completion: {
			
			//	TO DO
			
		})
		
	}
	
	
	func handleMore() {
		
		if let window = UIApplication.shared.keyWindow {
			
			popUpLauncher.handleShowOptions(currentView: window, dayColor: selectedDayColour)
			
		}
		
	}
	
	lazy var popUpLauncher: PreferencesPopUpLauncher = {
		
		let launcher = PreferencesPopUpLauncher()
		return launcher
		
	}()
	
	
	func handleClose() {
		
		
		if let navController = self.navigationController {
			
			navController.popViewController(animated: true)
			
		}
		
	}
	
	
}

