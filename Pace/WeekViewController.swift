//
//  WeekViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var selectedDayColour = UIColor.paceBrandColor()

class WeekViewController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {

	var weekTableNode : ASTableNode?
	var weeklyWorkouts : [WeekRoutineModel]?
	
	lazy var WeeklyWorkoutsSetup: WeekDayViewModel = {
		
		let weeklyWorkoutsSetup = WeekDayViewModel()
		return weeklyWorkoutsSetup
		
	}()
	
	init() {
		
		weekTableNode = ASTableNode(style:.plain)
		super.init(node: weekTableNode!)
		
		self.setupWeekTableNode()
		self.setupWorkoutsDays()
		
	}
	
	func setupWorkoutsDays() {
		
		weeklyWorkouts = WeeklyWorkoutsSetup.setupWeekRoutine()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
		
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		UIApplication.shared.statusBarView?.backgroundColor = .black
		navigationItem.title = "My Routine"
		self.navigationController?.navigationBar.isHidden = true
	}
	
	func setupWeekTableNode() {
		
		self.weekTableNode?.delegate = self
		self.weekTableNode?.dataSource = self
		self.weekTableNode?.backgroundColor = UIColor.black
		self.weekTableNode?.view.separatorStyle = .none
		self.weekTableNode?.view.showsVerticalScrollIndicator = false
		
	}
	
}






