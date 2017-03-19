//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamsViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {

	var groupCollectionNode : ASCollectionNode?
	var clubsArray = [ClubModel]()
	var usersUsingWorkoutArray = [User]()
	var trainer = User()
	
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
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.minimumInteritemSpacing  = 10
		flowLayout.minimumLineSpacing       = 10
		flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 20.0, right: 5.0)
		groupCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		super.init(node: groupCollectionNode!)
		
		profileSetup.retrieveUser(completion: { (userFound) in
			
			if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
				
				self.userName = userName
				self.userImageURL = profileImageURL
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
				
			}
			
		})
		
		//self.createClub()
		
//		teamsSetup.retrieveUserClubs { (clubsArray) in
//			
//			self.clubsArray = clubsArray
//			self.groupCollectionNode?.reloadData()
//			self.setupCollectionView()
//			
//		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
	
		fatalError("Storyboards are incompatible with truth and beauty")
	
	}
	
	func setupCollectionView() {
		
		groupCollectionNode?.delegate   = self
		groupCollectionNode?.dataSource = self
		groupCollectionNode?.view.alwaysBounceVertical = true
		groupCollectionNode?.view.allowsSelection = true
		groupCollectionNode?.view.showsVerticalScrollIndicator = false
		groupCollectionNode?.view.backgroundColor = UIColor.black
		
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .black
		self.navigationBarItems()
		navigationNoLineBar()
		
		
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationBarItems()
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBackgroundBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.paceBackgroundBlack()
		
		
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

	
}

