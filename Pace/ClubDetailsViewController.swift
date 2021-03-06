//
//  ClubDetailsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import LBTAComponents
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ClubDetailsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var headerView =  ClubDetailsHeaderView()
	var workoutDetailsTableView : UITableView?
	let ClubDetailsCellID = "ClubDetailsCellID"
	var members = [User]()
	var club : ClubModel?
	var userRunningArray = [RunsModel]()
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavigationBar()
		view.backgroundColor = UIColor.closeBlack()
		self.setupWorkoutDetailsTableView()
		self.setupHeaderView()
		
		paceAppService.retrieveClubMembers(clubID: (self.club?.clubID)!) { (membersRetrived) in
			
			self.members = membersRetrived
			self.workoutDetailsTableView?.reloadData()
			
		}
		
		
	}
	
	
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		workoutDetailsTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutDetailsTableView?.backgroundColor = .closeBlack()
		workoutDetailsTableView?.delegate = self
		workoutDetailsTableView?.dataSource = self
		workoutDetailsTableView?.separatorStyle = .none
		workoutDetailsTableView?.register(ClubDetailsCell.self, forCellReuseIdentifier: ClubDetailsCellID)
		workoutDetailsTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutDetailsTableView!)
		
	}

	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
		//	Right Bar
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "create").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleInviteFriends), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
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
	
	var totalDistance = [Double]()
	var clubPace = [Double]()
	
	func calculateClubStats() {
		
		for eachRun in userRunningArray {
			
			totalDistance.append(Double(Float(eachRun.distance!)!).roundToPlaces(places: 2))
			clubPace.append(Double(Float(eachRun.pace!)!).roundToPlaces(places: 2))
		
		}
		
		headerView.kmNumberLabel?.text = "\(totalDistance.reduce(0, +))"
		headerView.totalRunsNumberLabel?.text = "\(userRunningArray.count)"
		headerView.paceNumberLabel?.text = "\((clubPace.reduce(0, +)/Double(userRunningArray.count)).roundToPlaces(places: 2))"
		
	}
	
	func setupHeaderView() {
		
		headerView  = ClubDetailsHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 350.0))
		
		headerView.workoutName?.text = (self.club?.name)!
		headerView.workoutsImageView?.loadImageFromCacheWithUrlString(urlString: (self.club?.backgroundImageUrl)!)
		
		self.calculateClubStats()
		headerView.descriptionText?.text = (self.club?.clubDescription)!
		
		workoutDetailsTableView?.tableHeaderView = headerView
		
	}
	
	
	let messageComposer = MessageComposer()
	
	func handleInviteFriends() {
		
		if (messageComposer.canSendText()) {
			
			let messageComposeVC = messageComposer.configuredMessageComposeViewController()
			present(messageComposeVC, animated: true, completion: nil)
			
		} else {
			
			print("Cannot Send Text Message")
			
		}
		
		
	}
	
}
