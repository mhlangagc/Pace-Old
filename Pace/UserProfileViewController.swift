//
//  UserProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserProfileViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var profileTableView : UITableView?
	let runsCellID = "runsCellID"
	var profileHeaderView =  ProfileTabHeaderView()
	var user : User?
	var userRunsArray = [RunsModel]()
	
	lazy var paceServices: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.grouped)
		profileTableView?.backgroundColor = UIColor.closeBlack()
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		view.addSubview(profileTableView!)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		profileTableView?.register(RunsCellView.self, forCellReuseIdentifier: runsCellID)
		self.navigationController?.navigationBar.isHidden = false
		view.backgroundColor = .closeBlack()
		self.setupWorkoutDetailsTableView()
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
		paceServices.observeUserRuns(userID: (user?.userID)!, completion: { (userRuns) in
			
			self.userRunsArray = userRuns
			
			self.profileTableView?.reloadData()
			
			
		})
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupHeaderView()
		self.profileTableView?.reloadData()
		self.navigationController?.navigationBar.isHidden = false
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = user?.name
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func sizeHeaderToFit() {
		
		profileHeaderView.setNeedsLayout()
		profileHeaderView.layoutIfNeeded()
		
		let height = profileHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = profileHeaderView.frame
		frame.size.height = height
		profileHeaderView.frame = frame
	}
	
	func setupHeaderView() {
		
		profileHeaderView  = ProfileTabHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380.0))
		profileHeaderView.editProfileNameButton?.isHidden = true
		self.profileHeaderView.profileNameLabel?.text = self.user?.name
		self.profileHeaderView.profileImageView?.loadImageFromUrlString(urlString: (self.user?.profileImageUrl)!)
		profileTableView?.tableHeaderView = profileHeaderView
		
	}
	
	
	func handleOpenSettings() {
		
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
		
	}
	
}
