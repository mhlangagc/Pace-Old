//
//  CompletedRunViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/23.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import HealthKit

class CompletedRunViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  WorkoutDetailsHeaderView()
	var workoutCompletedTableView : UITableView?
	var trainer = User()
	var club : ClubModel?
	let exerciseCellID = "exerciseCellID"
	
	
	lazy var paceAppService: PaceAppServices = {
		
		let postWorkoutToClubDetails = PaceAppServices()
		return postWorkoutToClubDetails
		
	}()
	
	override var prefersStatusBarHidden: Bool {
		
		return false
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavigationBar()
		view.backgroundColor = UIColor.closeBlack()
		workoutCompletedTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
		self.setupHeaderView()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareVC"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShareWorkout))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(handleDoneWorkout))
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
		
		headerView  = WorkoutDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 667.0))
		workoutCompletedTableView?.tableHeaderView = headerView
		
	}
	
	func handleDoneWorkout() {
		
		self.dismiss(animated: true) { 
			
			//	post data to Club
			
		}
		
	}

	func handleShareWorkout() {
		
		shareLinkVC(linkString: "You've got to check out this workout on Pace. Download the app here : AppLink")
		
	}
	
}

extension CompletedRunViewController {

	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 0
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 0
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		
		if (exerciseCell == nil) {
			tableView.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
			exerciseCell = tableView.dequeueReusableCell(withIdentifier: exerciseCellID) as? ExerciseCellView
		}
		
		return exerciseCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: false)
		
	}


}
