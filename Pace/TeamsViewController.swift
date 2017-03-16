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
	var teamWorkoutsArray = [TeamsModel]()
	var usersUsingWorkoutArray = [User]()
	var trainer = User()
	
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
				
			}
			
		})
		
		teamsSetup.retrieveTeamsFromWorkouts { (workoutTeamsArray) in
			
			self.teamWorkoutsArray = workoutTeamsArray
			self.groupCollectionNode?.reloadData()
			self.setupCollectionView()
			
		}
		
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
		titleLabel.text = "Teams"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	}

	
}

