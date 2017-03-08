//
//  NewWorkoutsCollection.swift
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

class JustAddedCollection: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var newWorkoutsCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var popularWorkoutsArray = [ExploreWorkoutModel]()
	
	func retrieveMalePopularWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		
		let fanExploreWorkoutsRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("popular-workout")
		
		fanExploreWorkoutsRef.observe(.childAdded, with: { (snapshot) in
			
			let workoutId = snapshot.key
			
			let workoutRef = FIRDatabase.database().reference().child("Workouts-Teams").child(workoutId)
			workoutRef.observeSingleEvent(of: .value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					let featuredWorkout = ExploreWorkoutModel()
					
					featuredWorkout.workoutID = workoutId
					featuredWorkout.name = dictionary["name"] as? String
					featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
					featuredWorkout.backgroundImageUrl = dictionary["backgroundImageUrl"] as? String
					featuredWorkout.time = dictionary["time"] as? Int
					featuredWorkout.rating = dictionary["rating"] as? Int
					featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
					featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
					featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
					featuredWorkout.trainerID = dictionary["trainerID"] as? String
					
					workoutsArray.append(featuredWorkout)
					
					completion(workoutsArray)
					
					
				}
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
	}

	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumLineSpacing       = 15
		flowLayout.minimumInteritemSpacing = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 15.0, right: 15.0)
		newWorkoutsCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		newWorkoutsCollectionNode?.backgroundColor = .black
		addSubnode(newWorkoutsCollectionNode!)
		
		self.retrieveMalePopularWorkouts { (freeWorkoutsArray) in
			
			self.popularWorkoutsArray = freeWorkoutsArray
			self.newWorkoutsCollectionNode?.reloadData()
			
			self.setupCollectionNodes()
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		newWorkoutsCollectionNode?.delegate   = self
		newWorkoutsCollectionNode?.dataSource = self
		newWorkoutsCollectionNode?.view.leadingScreensForBatching = 1.0
		newWorkoutsCollectionNode?.view.alwaysBounceHorizontal = true
		newWorkoutsCollectionNode?.view.allowsSelection = true
		newWorkoutsCollectionNode?.view.backgroundColor = UIColor.black
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		newWorkoutsCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 275)
		
		return ASStackLayoutSpec(direction: .horizontal,
		                                  spacing: 0,
		                                  justifyContent: .start,
		                                  alignItems: .center,
		                                  children: [newWorkoutsCollectionNode!])
		//return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: stackSpec)
	}
	
	
}

extension JustAddedCollection {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return popularWorkoutsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let cellNode = DiscoveryWorkoutCell()
		cellNode.exploreWorkout = popularWorkoutsArray[indexPath.item]
		return cellNode
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let workoutSelected = popularWorkoutsArray[indexPath.item]
		WorkoutViewController.exploreWorkout = workoutSelected
		discoveryVC?.handleShowWorkoutView()
		
	}
	
}

