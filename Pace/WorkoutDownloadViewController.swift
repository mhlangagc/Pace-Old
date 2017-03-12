//
//  WorkoutDownloadViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class WorkoutDownloadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var saveToMyWorkoutsView : SaveToMyRoutinesView?
	var workoutDaysTableView : UITableView?
	let workoutDaysCellID = "workoutDaysCellID"
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.setupNavBar()
		self.setupWorkoutDetailsTableView()
		self.setupSaveToRoutinesButton()
		workoutDaysTableView?.register(WeekTableCell.self, forCellReuseIdentifier: workoutDaysCellID)
	
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height - 120.0)
		workoutDaysTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutDaysTableView?.backgroundColor = .black
		workoutDaysTableView?.delegate = self
		workoutDaysTableView?.dataSource = self
		workoutDaysTableView?.separatorStyle = .none
		workoutDaysTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutDaysTableView!)
		
	}
	
	func setupNavBar() {
		
		navigationNoLineBar()
		self.navigationItem.title = "Choose a day"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(handleCancel))
		self.navigationController?.navigationBar.tintColor = UIColor.greyWhite()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		
	}
	
	func setupSaveToRoutinesButton() {
		
		if let window = UIApplication.shared.keyWindow {
			
			saveToMyWorkoutsView = SaveToMyRoutinesView.init(frame: CGRect(x: 0, y: window.frame.height - 115.0, width: window.frame.width, height: 70.0))
			saveToMyWorkoutsView?.workoutDownloadVC = self
			view.addSubview(saveToMyWorkoutsView!)
			
		}
		
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
