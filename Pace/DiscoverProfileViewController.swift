//
//  DiscoverProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscoverProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
	
	var headerView =  ProfileHeaderView()
	var profileTableView : UITableView?
	let workoutCellID = "WorkoutCellViewID"
	
	static var userProfileModel : UserModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationNoLineBar()
		self.setupWorkoutDetailsTableView()
		view.backgroundColor = UIColor.black
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupHeaderView()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareVC"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShareProfile))
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black

		self.profileTableView?.reloadData()
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height - 64)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		profileTableView?.backgroundColor = .black
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		profileTableView?.register(WorkoutCellView.self, forCellReuseIdentifier: workoutCellID)
		view.addSubview(profileTableView!)
		
		
	}
	
	func setupHeaderView() {
		
		headerView  = ProfileHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300.0)) //365.0
		headerView.discoverProfileVC = self
		
		headerView.nameLabel?.text = (DiscoverProfileViewController.userProfileModel?.name)!
		headerView.detailsLabel?.text = (DiscoverProfileViewController.userProfileModel?.trainerDescription)!
		headerView.locationLabel?.text = (DiscoverProfileViewController.userProfileModel?.location)!
		headerView.profileImageView?.image = DiscoverProfileViewController.userProfileModel?.profileImage
		
		
		profileTableView?.tableHeaderView = headerView
		
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
		
		//	TODO
		print("OPen Settings")
		
	}
	
	func handleOpenFollowersView() {
		
		//	TODO
		print("Show Followers")
		
	}
	
	func handleOpenFollowingView() {
		
		//	TODO
		print("Show Following")
	}
	
	func handleFollowButton() {
		
		//	TODO
		print("Follow")
	
	}
	
	func handleShareProfile() {
		
		shareLinkVC(linkString: "You've got to check out this trainer on Pace. Download the app here : AppLink")
		
	}
	
	
}
