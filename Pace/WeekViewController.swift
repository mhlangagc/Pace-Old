//
//  WeekViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

var selectedDayColour = UIColor.paceBrandColor()

class WeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  WeekHeaderView()
	var weekTableView : UITableView?
	let weekCellID = "RoutineCellViewID"
	var weeklyWorkoutsArray : [WeekRoutineModel]?
	
	lazy var WeeklyWorkoutsSetup: WeekDayViewModel = {
		
		let weeklyWorkoutsSetup = WeekDayViewModel()
		return weeklyWorkoutsSetup
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		weeklyWorkoutsArray = WeeklyWorkoutsSetup.setupWeekRoutine()
		
		self.setupWeekTableView()
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
		view.backgroundColor = UIColor.black
		weekTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		
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
		//self.setupHeaderView()
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
		
		headerView  = WeekHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 335.0))
		headerView.myRoutineVC = self
		weekTableView?.tableHeaderView = headerView
		
	}
	
	func closeHeaderView() {
		
//		headerView.setNeedsLayout()
//		headerView.layoutIfNeeded()
//		headerView.isHidden = true
//		headerView.frame.offsetBy(dx: 0.0, dy: -335.0)
		
	}
	
	
	func handleOpenDiscovery() {
		
		
		
	}
	
}






