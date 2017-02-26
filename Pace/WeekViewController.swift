//
//  WeekViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseStorage
import FirebaseDatabase

var selectedDayColour = UIColor.paceBrandColor()

class WeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var weekTableView : UITableView?
	let weekCellID = "RoutineCellViewID"
	let workoutCellID = "workoutCellID"
	
	lazy var RoutineSetup: RoutinesViewModel = {
		
		let routineWorkoutsSetup = RoutinesViewModel()
		return routineWorkoutsSetup
		
	}()
	
	func setupRoutineData() {
		
		let weekCreationLaunch = UserDefaults.standard.bool(forKey: "routineCreationLaunch")
		if weekCreationLaunch  {
			
			//  Not First Launch
			
			
		} else {
			
			RoutineSetup.routinesCreation(completion: { 
				
				RoutineSetup.loadRoutineWorkouts()
				
			})
			
			UserDefaults.standard.set(true, forKey: "routineCreationLaunch")
			
			// **  Save Date for Renewing
			//self.firstLaunchDate()
			
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		RoutineSetup.loadRoutineWorkouts()
		
		self.setupWeekTableView()
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
		view.backgroundColor = UIColor.black
		weekTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		weekTableView?.reloadData()
		
		self.setupRoutineData()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		
		weekTableView?.reloadData()
	
	}
	
	func setupWeekTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		weekTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		weekTableView?.backgroundColor = .black
		weekTableView?.delegate = self
		weekTableView?.dataSource = self
		weekTableView?.separatorStyle = .none
		weekTableView?.showsVerticalScrollIndicator = false
		view.addSubview(weekTableView!)
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		UIApplication.shared.statusBarView?.backgroundColor = .black
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
	
	}
	
}






