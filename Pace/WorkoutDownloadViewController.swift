//
//  WorkoutDownloadViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutDownloadViewController: UITableViewController {
	
	let workoutDaysCellID = "workoutDaysCellID"
	let SaveToMyRoutinesCellID = "SaveToMyRoutinesCellID"
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	var weekDays = [WorkoutDaysModel]()
	
	lazy var weekRoutineViewModel: WorkoutDaysViewModel = {
		
		let workoutDays = WorkoutDaysViewModel()
		return workoutDays
		
	}()
	
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
	
//	func setupSaveToRoutinesButton() {
//		
//		if let window = UIApplication.shared.keyWindow {
//			
//			saveToMyWorkoutsView = SaveToMyRoutinesView.init(frame: CGRect(x: 0, y: window.frame.height - 115.0, width: window.frame.width, height: 70.0))
//			saveToMyWorkoutsView?.workoutDownloadVC = self
//			view.addSubview(saveToMyWorkoutsView!)
//			
//		}
//		
//	}
	
	func handleSaveWorkoutToRoutine() {
		
		//	TO DO
	}
	
	func handleCancel() {
		
		self.dismiss(animated: true) {
			
			// TO DO - Saved without picking a day.
			
		}
		
		
	}
}
