//
//  ClubsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//


import Firebase
import UIKit

var usersName = String()
var usersImageURL = String()
var clubID = String()

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
	
	var spinner : UIActivityIndicatorView = {
		
		let spinnerView = UIActivityIndicatorView()
		spinnerView.hidesWhenStopped = true
		spinnerView.startAnimating()
		spinnerView.activityIndicatorViewStyle = .whiteLarge
		//spinnerView.translatesAutoresizingMaskIntoConstraints = false
		return spinnerView
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RoutineSetup.loadRoutineWorkouts()
		
		self.setupWeekTableView()
		navigationItem.title = "My Clubs"
		view.backgroundColor = UIColor.closeBlack()
		self.navigationBarItems()
		self.setupRightNavItem()
		clubsTableView?.register(WeekTableCell.self, forCellReuseIdentifier: weekCellID)
		//self.addSpinnerView()
		
		
		self.fetchDataFromServer()
		
	}
	
	func fetchDataFromServer() {
		
		if Reachability.isConnectedToNetwork() == true {
			
			paceAppService.retrieveUserDownloadedWorkouts { (purchasedWorkoutsArray) in
				
				self.downloadedWorkoutsArray = purchasedWorkoutsArray
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
				self.spinner.stopAnimating()
				self.clubsTableView?.reloadData()
				
			}
			
			profileSetup.retrieveUser(completion: { (userFound) in
				
				if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
					
					usersName = userName
					usersImageURL = profileImageURL
				}
				
			})
			
			
		} else {
			
			self.failurePopup(mainMessage: "🙈", detailedString: "Looks like you are not connected to the Internet. Check your connection and try again. 🙃")
			
		}

	}
	
	func addSpinnerView() {
		
		spinner.frame = CGRect(x: ((view.frame.width - 30.0) * 0.5), y: ((view.frame.height - 30.0) * 0.5), width: 30.0, height: 30.0)
		view.addSubview(spinner)
		
		
		
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
	
	private func setupRemainingNavItems() {
		
		let titleImageView = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
		titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		titleImageView.contentMode = .scaleAspectFit
		
		navigationItem.titleView = titleImageView
	}
	
	private func setupRightNavItem() {
		
		self.navigationController?.navigationBar.tintColor = UIColor.paceBrandColor()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBrandColor()
		//navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleCreateClub))
		
	}
	
	func navigationBarItems() {
		
		let titleImageView = UIImageView(image: #imageLiteral(resourceName: "home_Active"))
		titleImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		titleImageView.contentMode = .scaleAspectFit
		navigationItem.titleView = titleImageView
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
		
		clubID = clubSelected.clubID!
		let clubMessagesVC = ClubChatViewController()
		clubMessagesVC.clubModel = clubSelected
		clubMessagesVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(clubMessagesVC, animated: true)
		
	}
	
}

