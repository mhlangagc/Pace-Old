//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

	var headerView =  ProfileHeaderView()
	var profileTableView : UITableView?
	let workoutCellID = "WorkoutCellViewID"
	
	var localUser : UserModel?
	
	lazy var UserSetup: LocalUserViewModel = {
		
		let setupUser = LocalUserViewModel()
		return setupUser
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIApplication.shared.statusBarView?.backgroundColor = UIColor(fromHexString: "08090A")
		navigationNoLineBar()
		self.navigationBarItems()
		self.setupWorkoutDetailsTableView()
		view.backgroundColor = UIColor.black
		
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		localUser = UserSetup.createLocalUser()
		
		self.setupHeaderView()
		self.navigationBarItems()
		self.profileTableView?.reloadData()
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		profileTableView?.backgroundColor = .black
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		profileTableView?.register(WorkoutCellView.self, forCellReuseIdentifier: workoutCellID)
		view.addSubview(profileTableView!)
		
		
	}
	
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Profile"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.offWhite()
		titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		navigationItem.title = "Profile"
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleOpenSettings))
		self.navigationController?.navigationBar.tintColor = UIColor.paceBrandColor()
	}

	func setupHeaderView() {
		
		headerView  = ProfileHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300.0)) //375.0
		headerView.nameLabel?.text = localUser?.name
		headerView.locationLabel?.text = localUser?.location
		headerView.detailsLabel?.text = localUser?.trainerDescription
		headerView.profileImageView?.image = localUser?.profileImage
		headerView.profileVC = self
		headerView.followButton?.isHidden = true
		profileTableView!.tableHeaderView = headerView
		
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
	
	
	func handleOpenSettings() {
		
		let settingsVC = SettingsViewController()
		settingsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(settingsVC, animated: true)
	
	}
	
	func handleOpenFollowersView() {
		
		let followersViewController = FollowersViewController()
		followersViewController.followersTitle = "Followers"
		followersViewController.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(followersViewController, animated: true)
	
	}
	
	func handleOpenFollowingView() {
		
		//	TODO
		let followersViewController = FollowersViewController()
		followersViewController.hidesBottomBarWhenPushed = true
		followersViewController.followersTitle = "Following"
		self.navigationController?.pushViewController(followersViewController, animated: true)
	}

	
}

