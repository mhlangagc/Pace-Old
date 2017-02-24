//
//  WorkoutViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutProcessViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var menuBar : WorkoutProcessMenuBar?
	var touchBarView =  TouchBarHeaderView()
	var workoutTableView : UITableView?
	var musicPlayerView : MusicPlayerView?
	let workoutCellViewID = "workoutCellViewID"
	
	var exercisesArray : [ExerciseModel]?
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		
		return UIStatusBarStyle.lightContent
	}
	
	lazy var goButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("GO", for: UIControlState.normal)
		button.setTitleColor(UIColor.white, for: UIControlState.normal)
		button.layer.cornerRadius = 190 * 0.5
		button.layer.masksToBounds = true
		button.layer.borderWidth = 20.0
		button.backgroundColor = UIColor.black
		button.titleLabel?.font = UIFont.systemFont(ofSize: 41, weight: UIFontWeightBold)
		textSpacing(button.titleLabel!, spacing: 0.7)
		button.layer.borderColor = selectedDayColour.cgColor
		button.addTarget(self, action: #selector(handleGo), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	
	}()
	
	lazy var ExerciseSetup: ExerciseViewModel = {
		
		let exericiseSetup = ExerciseViewModel()
		return exericiseSetup
		
	}()
	
	override func viewDidLoad() {              
		super.viewDidLoad()
		
		exercisesArray = ExerciseSetup.setupExercises()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		self.navigationController?.navigationBar.isHidden = true
		self.setupMenuBar()
		self.setUpWorkoutTableView()
		self.setupGoButton()
		self.setupPlayerView()
		view.backgroundColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = .black
		workoutTableView?.register(WorkoutProcessCellView.self, forCellReuseIdentifier: workoutCellViewID)
		
	}
	
	func setupMenuBar() {
		
		menuBar = WorkoutProcessMenuBar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 75.0))
		menuBar?.workoutProcessVC = self
		view.addSubview(menuBar!)
		
	}
	
	func setUpWorkoutTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 70.0, width: view.frame.width, height: view.frame.height - 150.0)
		workoutTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutTableView?.backgroundColor = .black
		workoutTableView?.layer.opacity = 0.0
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
//		self.setupHeaderView()
		self.workoutTableView?.reloadData()
		
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func setupGoButton() {
		
		view.addSubview(goButton)
		
		goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		goButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		goButton.heightAnchor.constraint(equalToConstant: 190).isActive = true
		goButton.widthAnchor.constraint(equalToConstant: 190).isActive = true
		
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
	
	func handleGo() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10, initialSpringVelocity: 15, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
			
			self.goButton.layer.contentsScale = 0.4
			self.goButton.layer.opacity = 0.0
			
		}) { (completed) in
			
			self.goButton.isEnabled = false
			self.workoutTableView?.layer.opacity = 1.0
			self.menuBar?.timerLabel.layer.opacity = 1.0
			self.menuBar?.endButton.setImage(UIImage(named: "more"), for: UIControlState.normal)
			self.menuBar?.endButton.addTarget(self, action: #selector(self.handleEndWorkout), for: UIControlEvents.touchUpInside)
		}
		
	}
	
	
	func handleEndWorkout() {
		
		if let window = UIApplication.shared.keyWindow {
			
			popUpLauncher.showEndWorkoutPopUp(currentView: window)
			
		}
		
	}
	
	lazy var popUpLauncher: EndWorkoutPopupLauncher = {
		
		let launcher = EndWorkoutPopupLauncher()
		launcher.workoutProcessVC = self
		return launcher
		
	}()
	
	func handleCancelWorkout() {
		
		self.dismiss(animated: true) { 
			
			//	 TO DO
			
		}
		
	}
	
	func endWorkout() {
		
		let vc = WorkoutCompleteVIewController()
		self.navigationController?.pushViewController(vc, animated: true)
		
	}
	
	
}
