//
//  WorkoutCompleteVIewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutCompleteVIewController : UIViewController,  UITableViewDataSource, UITableViewDelegate  {
	
	var headerView =  CompletedHeaderView()
	var workoutTableView : UITableView?
	var rateWorkoutView : RateButtonView?
	let workoutCellViewID = "workoutCellViewID"
	
	var exercisesArray : [ExercisesModel]?
	
	lazy var ExerciseSetup: ExerciseViewModel = {
		
		let exericiseSetup = ExerciseViewModel()
		return exericiseSetup
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkerBlack()
		//exercisesArray = ExerciseSetup.setupExercises()
		
		
		self.navigationController?.navigationBar.isHidden = true
		self.setupMenuBar()
		self.setupTableView()
		self.setupRatingButtonView()
		view.backgroundColor = UIColor.black
		workoutTableView?.register(WorkoutProcessCellView.self, forCellReuseIdentifier: workoutCellViewID)
		
	}
	
	func setupMenuBar() {
		
		let menuBar = WorkoutCompleteMenuBar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 90.0))
		menuBar.workoutCompleteVC = self
		view.addSubview(menuBar)
	}
	
	func setupTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 90.0, width: view.frame.width, height: view.frame.height - 80.0)
		workoutTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutTableView?.backgroundColor = .black
		workoutTableView?.allowsSelection = false
		workoutTableView?.delegate = self
		workoutTableView?.dataSource = self
		workoutTableView?.separatorStyle = .none
		workoutTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutTableView!)
		
		
	}
	
	func setupRatingButtonView() {
		
		rateWorkoutView = RateButtonView.init(frame: CGRect(x: 0, y: view.frame.height - 80.0, width: view.frame.width, height: 80.0))
		rateWorkoutView?.workoutCompletedVC = self
		view.addSubview(rateWorkoutView!)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = true
		self.setupHeaderView()
		self.workoutTableView?.reloadData()
		
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
		
		headerView  = CompletedHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 210.0))
		workoutTableView?.tableHeaderView = headerView
		
	}

	
	func handleDismiss() {
		
		self.dismiss(animated: true) { 
			
			//	TO DO
			
		}
		
	}
	
	func handleShareProgress() {
		
		shareLinkVC(linkString: "Just Nailed Cardio Blaster with Justin on Pace. Check out the app at : App link. #Boom")
		
	}
	
	func handleRateWorkout() {
		
		if let window = UIApplication.shared.keyWindow {
			
			popUpLauncher.handleShowOptions(currentView: window, dayColor: selectedDayColour)
			
		}
		
	}
	
	lazy var popUpLauncher: RatingPopUpLauncher = {
		
		let launcher = RatingPopUpLauncher()
		return launcher
		
	}()
	
	
}
