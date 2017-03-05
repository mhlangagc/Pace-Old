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
	var teamWorkoutsArray : [TeamsModel]?
	
	func retrieveTeamsFromWorkouts(completion: @escaping (_ result: [TeamsModel]) -> Void) {
		
		var teamsArray = [TeamsModel]()
		
		FIRDatabase.database().reference().child("WorkoutAndTeam").child("Male").observe(FIRDataEventType.childAdded, with: { (snapShot) in
			
			let workoutID = snapShot.key
			
			if let dictionary = snapShot.value as? [String: AnyObject] {
	
				let workoutTeam = TeamsModel()
				
				workoutTeam.workoutID = workoutID
				workoutTeam.workoutName = dictionary["name"] as? String
				workoutTeam.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
				workoutTeam.trainerID = dictionary["trainerID"] as? String
				
				teamsArray.append(workoutTeam)
				
				print(workoutTeam)
				
				completion(teamsArray)
				
				
			}
			
		}, withCancel: nil)
		
		
	}
	
	init() {
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.minimumInteritemSpacing  = 10
		flowLayout.minimumLineSpacing       = 10
		flowLayout.sectionInset = UIEdgeInsets(top: 30.0, left: 5.0, bottom: 20.0, right: 5.0)
		groupCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		super.init(node: groupCollectionNode!)
		
		self.retrieveTeamsFromWorkouts { (workoutTeamsArray) in
			
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
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
		
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

