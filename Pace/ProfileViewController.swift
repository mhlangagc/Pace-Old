//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

	var headerView =  ProfileHeaderView()
	var profileTableView : UITableView?
	let workoutCellID = "WorkoutCellViewID"
	
	func retrieveUser() {
		
		if let userID = FIRAuth.auth()?.currentUser?.uid {
			
			FIRDatabase.database().reference().child("Users").child(userID).observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let user = User()
					user.name = dictionary["name"] as? String
					user.profileImageUrl = dictionary["profileImageUrl"] as? String
					user.location = dictionary["location"] as? String
					user.about = dictionary["about"] as? String
					
					if let name = user.name, let location = user.location, let about = user.about, let imageUrl = user.profileImageUrl {
						
						self.setupHeaderView(userName: name, location: location, about: about, profileImageUrl: imageUrl)
						
					}
					
				}
				
			})
			
		}
		
	}
	
	var numberOfWorkoutsDownloaded = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		navigationNoLineBar()
		self.setupNavBar()
		self.setupWorkoutDetailsTableView()
		view.backgroundColor = UIColor.black
		
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.setupHeaderView(userName: "", location: "", about: "", profileImageUrl: "")
		self.retrieveUser()
		self.setupNavBar()
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
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
	}
	
	
	func setupNavBar() {
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleOpenSettings))
		self.navigationController?.navigationBar.tintColor = UIColor.paceBrandColor()
		self.navigationController?.navigationBar.barTintColor = UIColor.darkerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkerBlack()
		
	}

	
	func setupHeaderView(userName: String, location: String, about: String, profileImageUrl : String) {
		
		headerView  = ProfileHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300.0)) //375.0
		headerView.nameLabel?.text = userName
		headerView.locationLabel?.text = location
		headerView.detailsLabel?.text = about
		headerView.profileVC = self
		headerView.followButton?.isHidden = true
		headerView.profileImageView?.loadImageFromCacheWithUrlString(urlString: profileImageUrl)
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

