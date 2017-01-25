//
//  WorkoutViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutProcessViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var touchBarView =  TouchBarHeaderView()
	var workoutTableView : UITableView?
	var musicPlayerView : MusicPlayerView?
	let workoutCellViewID = "workoutCellViewID"
	
	var exercisesArray : [ExerciseModel]?
	
	lazy var ExerciseSetup: ExerciseViewModel = {
		
		let exericiseSetup = ExerciseViewModel()
		return exericiseSetup
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		exercisesArray = ExerciseSetup.setupExercises()
		
		self.navigationController?.navigationBar.isHidden = true
		self.setupMenuBar()
		self.setUpWorkoutTableView()
		self.setupPlayerView()
		view.backgroundColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = .black
		workoutTableView?.register(WorkoutProcessCellView.self, forCellReuseIdentifier: workoutCellViewID)
		
	}
	
	func setupMenuBar() {
		
		let menuBar = WorkoutProcessMenuBar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0))
		menuBar.workoutProcessVC = self
		view.addSubview(menuBar)
	}
	
	func setUpWorkoutTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 70.0, width: view.frame.width, height: view.frame.height - 150.0)
		workoutTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutTableView?.backgroundColor = .black
		workoutTableView?.delegate = self
		workoutTableView?.dataSource = self
		workoutTableView?.separatorStyle = .none
		workoutTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutTableView!)
		
		
	}
	
	func setupPlayerView() {
		
		musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: view.frame.height - 85.0, width: view.frame.width, height: 85.0))
		view.addSubview(musicPlayerView!)
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
		
		touchBarView.setNeedsLayout()
		touchBarView.layoutIfNeeded()
		
		let height = touchBarView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = touchBarView.frame
		frame.size.height = height
		touchBarView.frame = frame
	}
	
	func setupHeaderView() {
		
		touchBarView  = TouchBarHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80.0))
		workoutTableView?.tableHeaderView = touchBarView
		
	}
	
	func handleDismiss() {
		
		self.dismiss(animated: true) { 
			//	DO DO
		}
		
	}
	
	
	func handleEndWorkout() {
		
		let vc = WorkoutCompleteVIewController()
		self.navigationController?.pushViewController(vc, animated: true)
		
	}
	
	
}
