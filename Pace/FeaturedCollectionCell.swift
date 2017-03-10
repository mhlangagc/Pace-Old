//
//  FeaturedWorkoutsCell.swift
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

class FeaturedCollectionCell: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var featuredCollectionNode : ASCollectionNode?
	var discoveryVC : ExploreViewController?
	
	var featuredWorkoutsArray = [ExploreWorkoutModel]()
	
	func retrieveMaleFeaturedWorkouts(completion: @escaping (_ result: [ExploreWorkoutModel]) -> Void) {
		
		var workoutsArray = [ExploreWorkoutModel]()
		
		let fanExploreWorkoutsRef = FIRDatabase.database().reference().child("fan-Explore-Workouts").child("male").child("featured-workout")
		
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
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 22.5, left: 20.0, bottom: 22.5, right: 20.0)
		self.featuredCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		self.featuredCollectionNode?.backgroundColor = .black
		self.addSubnode(self.featuredCollectionNode!)
		
		
		
		self.retrieveMaleFeaturedWorkouts { (featuredWorkoutsArray) in
			
			self.featuredWorkoutsArray = featuredWorkoutsArray
			self.featuredCollectionNode?.reloadData()
			
			self.setupCollectionNodes()
		}
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.black
		
		featuredCollectionNode?.delegate   = self
		featuredCollectionNode?.dataSource = self
		featuredCollectionNode?.view.leadingScreensForBatching = 5.0
		featuredCollectionNode?.view.alwaysBounceHorizontal = true
		featuredCollectionNode?.view.allowsSelection = true
		featuredCollectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		featuredCollectionNode?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 270)
		return ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [featuredCollectionNode!])
		
	}


}

extension FeaturedCollectionCell {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return featuredWorkoutsArray.count
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let featuredCellNode = FeaturedCell()
		featuredCellNode.featureCollection = self
		//featuredCellNode.workoutImageNode.url = NSURL(string: featuredWorkoutsArray[indexPath.item].workoutImageUrl!)! as URL
		featuredCellNode.exploreWorkoutModel = featuredWorkoutsArray[indexPath.item]
		return featuredCellNode
	
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		let worktoutSelected = featuredWorkoutsArray[indexPath.item]
		discoveryVC?.handleShowWorkoutView(workoutSelected: worktoutSelected)
		
	}
}
