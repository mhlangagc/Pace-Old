//
//  WorkoutDownloadViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class WorkoutDownloadViewController: UITableViewController {
	
	let workoutDaysCellID = "workoutDaysCellID"
	let SaveToMyRoutinesCellID = "SaveToMyRoutinesCellID"
	var workoutDetailsVC : WorkoutViewController?
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var weekDays = [WorkoutDaysModel]()
	
	lazy var weekRoutineViewModel: WorkoutDaysViewModel = {
		
		let workoutDays = WorkoutDaysViewModel()
		return workoutDays
		
	}()
	
	func createDownloadWorkout(completion: @escaping (_ completed: Bool) -> ()) {
		
		let userID = FIRAuth.auth()!.currentUser!.uid
		let workoutID = workoutDetailsVC?.exploreWorkout?.workoutID
		
		let userDownloadedWorkoutsRef = FIRDatabase.database().reference().child("fan-User-PurchasedWorkouts").child(userID)
		userDownloadedWorkoutsRef.updateChildValues([workoutID!: 1])
		
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.setupNavBar()
		self.setupWorkoutDetailsTableView()
		//self.setupSaveToRoutinesButton()
		tableView.register(WeekTableCell.self, forCellReuseIdentifier: workoutDaysCellID)
		tableView.register(SaveToMyRoutinesCell.self, forCellReuseIdentifier: SaveToMyRoutinesCellID)
		
		weekDays = weekRoutineViewModel.setupWeekRoutines()
	
	}
	
	func setupWorkoutDetailsTableView() {
		
		//let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height) //120.0
		//tableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		tableView.backgroundColor = .black
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
//		view.addSubview(tableView!)
		
	}
	
	func setupNavBar() {
		
		navigationNoLineBar()
		self.navigationItem.title = "Save Workout"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(handleCancel))
		self.navigationController?.navigationBar.tintColor = UIColor.greyWhite()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		
	}
	

	func handleSaveWorkoutToRoutine() {
		
		//	TO DO
	}
	
	func handleCancel() {
		
		self.dismiss(animated: true) {
			
			// TO DO - Saved without picking a day.
			
		}
		
		
	}
}
