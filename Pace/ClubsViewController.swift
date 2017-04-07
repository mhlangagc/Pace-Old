//
//  ClubsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//


import Firebase
import UIKit

class ClubsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var clubsTableView : UITableView?
	let weekCellID = "RoutineCellViewID"
	let workoutCellID = "workoutCellID"
	let clubCellID = "clubCellID"
	
	var clubsArray = [ClubModel]()
	var usersUsingWorkoutArray = [User]()
	var trainer = User()
	
	lazy var RoutineSetup: RoutinesViewModel = {
		
		let routineWorkoutsSetup = RoutinesViewModel()
		return routineWorkoutsSetup
		
	}()
	
	
	//	########### Club Creation
	private func createClub() {
		
		
		let userID = FIRAuth.auth()!.currentUser!.uid
		let ref = FIRDatabase.database().reference().child("Clubs")
		let childRef = ref.childByAutoId()
		
		let values = ["name" : "Sea Point Two Oceaners",
		              "clubDescription": "If you are looking to get toned and enjoy fast paced interval training to shed far this workout is for you.",
		              "backgroundImageUrl": "https://firebasestorage.googleapis.com/v0/b/pace-c9c8e.appspot.com/o/PopularWorkoutImages%2F428CD808-78A5-4F77-8B03-AFA70970F58B?alt=media&token=53b01402-4d29-425d-ab03-ca5c39331c1f",
		              "trainerID" : userID,
		              "distance" : 301,
		              "totalRuns": 89,
		              "paceMins": 5,
		              "paceSeconds": 45
			] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
			//	Create workout Trainer Fan
			let trainerClubRef = FIRDatabase.database().reference().child("fan-User-CreatedClubs").child(userID)
			let messageId = childRef.key
			trainerClubRef.updateChildValues([messageId: 1])
			
			//	Create Featured Workout fan
			let fanFeaturedClubRef = FIRDatabase.database().reference().child("fan-Explore-Clubs").child("featured-clubs")
			let workoutId = childRef.key
			fanFeaturedClubRef.updateChildValues([workoutId: 1])
			
			//	Create the Trainer Uploading the workout - Once
			//	self.uploadToFirebaseStorageUsingTrainerImage()
			
			
		}
	}
	
	func retrieveUsersUsingWorkout(workoutID: String, completion: @escaping (_ result: [User]) -> Void) {
		
		var userArray = [User]()
		
		FIRDatabase.database().reference().child("fan-PurchasedWorkout-Users").child(workoutID).observe(.childAdded, with: { (snapshot) in
			
			let userId = snapshot.key
			
			FIRDatabase.database().reference().child("Users").child(userId).observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let userWorkout = User()
					
					userWorkout.name = dictionary["name"] as? String
					userWorkout.profileImageUrl = dictionary["profileImageUrl"] as? String
					userWorkout.location = dictionary["location"] as? String
					userWorkout.about = dictionary["about"] as? String
					
					userArray.append(userWorkout)
					
					completion(userArray)
					
				}
				
			}, withCancel: nil)
			
			
		}, withCancel: nil)
		
		
	}
	
	lazy var teamsSetup: PaceAppServices = {
		
		let teamSetup = PaceAppServices()
		return teamSetup
		
	}()
	
	lazy var profileSetup: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	var userName = String()
	var userImageURL = String()

	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveDownloadedWorkouts = PaceAppServices()
		return retrieveDownloadedWorkouts
		
	}()
	
	var downloadedWorkoutsArray = [ExploreWorkoutModel]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RoutineSetup.loadRoutineWorkouts()
		
		self.setupWeekTableView()
		navigationItem.title = "My Clubs"
		view.backgroundColor = UIColor.closeBlack()
		self.navigationBarItems()
		self.setupRightNavItem()
		clubsTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		
		paceAppService.retrieveUserDownloadedWorkouts { (purchasedWorkoutsArray) in
			
			self.downloadedWorkoutsArray = purchasedWorkoutsArray
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			self.clubsTableView?.reloadData()
			
		}
		
		profileSetup.retrieveUser(completion: { (userFound) in
			
			if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
				
				self.userName = userName
				self.userImageURL = profileImageURL
			}
			
		})
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationItem.title = "My Clubs"
		navigationNoLineBar()
		self.navigationBarItems()
		self.setupRightNavItem()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	private func setupRightNavItem() {
		
		self.navigationController?.navigationBar.tintColor = UIColor.paceBrandColor()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBrandColor()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleCreateClub))
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "My Clubs"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	}
	
	func setupWeekTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		clubsTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		clubsTableView?.backgroundColor = UIColor.closeBlack()
		clubsTableView?.delegate = self
		clubsTableView?.dataSource = self
		clubsTableView?.separatorStyle = .none
		clubsTableView?.showsVerticalScrollIndicator = false
		view.addSubview(clubsTableView!)
		
	}
	
	func handleCreateClub() {
		
		let createClubVC = CreateClubViewController()
		let navBarVC = UINavigationController(rootViewController: createClubVC)
		self.present(navBarVC, animated: true, completion: nil)
		
	}
	
	func handleClubSelection(clubSelected: ClubModel) {
		
		let clubMessagesVC = ClubChatViewController()
		clubMessagesVC.userName = userName
		clubMessagesVC.userImageURL = userImageURL
		clubMessagesVC.clubModel = clubSelected
		clubMessagesVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(clubMessagesVC, animated: true)
		
	}
	
}

