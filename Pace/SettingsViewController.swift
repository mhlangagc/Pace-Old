//
//  SettingsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SettingsViewController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
	
	var settingsTableNode : ASTableNode?
	
	var topSettingsArray : [SettingsModel]?
	var trainerJoinArray : [SettingsModel]?
	var middleSectionArray : [SettingsModel]?
	var bottomSectionArray : [SettingsModel]?
	var logoutArray : [SettingsModel]?
	
	lazy var SettingsSetup: SettingsViewModel = {
		
		let settingsSetup = SettingsViewModel()
		return settingsSetup
		
	}()
	
	init() {
		
		settingsTableNode = ASTableNode(style:.grouped)
		super.init(node: settingsTableNode!)
		
		self.setupSettingsNode()
		
		topSettingsArray = SettingsSetup.createTopSettings()
		trainerJoinArray = SettingsSetup.createJoinTheTrainers()
		middleSectionArray = SettingsSetup.createMiddleSettings()
		bottomSectionArray = SettingsSetup.createBottomSettings()
		logoutArray = SettingsSetup.createLogout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = false
		navigationLineBar()
		self.title = "Settings"
		view.backgroundColor = .black
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.title = "Settings"
		navigationNoLineBar()
		
	}

	func setupSettingsNode() {
		
		self.settingsTableNode?.delegate = self
		self.settingsTableNode?.dataSource = self
		self.settingsTableNode?.backgroundColor = UIColor.black
		self.settingsTableNode?.view.separatorStyle = .none
		self.settingsTableNode?.view.showsVerticalScrollIndicator = false
		
	}
	
}
