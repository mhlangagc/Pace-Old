//
//  TrainersAndFriendsCollectionNode.swift
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

class TrainersAndFriendsCollectionNode: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
	
	var catergoryCollection : ASCollectionNode?
	var exploreVC : ExploreViewController?
	
	var suggestedTrainersArray : [User]?
	
	func retrieveTrainers(completion: @escaping (_ result: [User]) -> Void) {
		
		var trainersArray = [User]()
		
		
		FIRDatabase.database().reference().child("Trainers").observe(FIRDataEventType.childAdded, with: { (snapShot) in
			
			let trainerID = snapShot.key
			
			if let dictionary = snapShot.value as? [String: AnyObject] {
				
				let workoutTrainer = User()
				
				workoutTrainer.userID = trainerID
				workoutTrainer.name = dictionary["name"] as? String
				workoutTrainer.location = dictionary["location"] as? String
				workoutTrainer.profileImageUrl = dictionary["profileImageUrl"] as? String
				workoutTrainer.speciality = dictionary["speciality"] as? String
				
				trainersArray.append(workoutTrainer)
				
				completion(trainersArray)
				
				
			}

			
		}, withCancel: nil)
		
//		FIRDatabase.database().reference().child("Trainers").observe(FIRDataEventType.childAdded, with: { (snapShot) in
//			
//			
//		}, withCancel: nil)
		
		
	}
	
	override init() {
		super.init()
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .horizontal
		flowLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 18.0, right: 15.0)
		catergoryCollection = ASCollectionNode(collectionViewLayout: flowLayout)
		catergoryCollection?.backgroundColor = .black
		addSubnode(catergoryCollection!)
		
		self.retrieveTrainers { (workoutTeamsArray) in
			
			self.suggestedTrainersArray = workoutTeamsArray
			
			self.catergoryCollection?.reloadData()
			self.setupCollectionNodes()
			
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	func setupCollectionNodes() {
		
		backgroundColor = UIColor.paceBrandColor()
		
		catergoryCollection?.delegate   = self
		catergoryCollection?.dataSource = self
		catergoryCollection?.view.leadingScreensForBatching = 1.0
		catergoryCollection?.view.alwaysBounceHorizontal = true
		catergoryCollection?.view.allowsSelection = true
		catergoryCollection?.view.backgroundColor = UIColor.black
		
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		catergoryCollection?.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 240)
		return ASStackLayoutSpec(direction: .horizontal,
		                         spacing: 0,
		                         justifyContent: .start,
		                         alignItems: .center,
		                         children: [catergoryCollection!])
		
	}
	
	
}

extension TrainersAndFriendsCollectionNode {
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		
		return (suggestedTrainersArray?.count)!
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		
		
		let profileCell = FollowProfileCell()
		profileCell.followCollection = self
		profileCell.trainerModel = suggestedTrainersArray?[indexPath.item]
		return profileCell
		
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
		
		if let selectedUser = suggestedTrainersArray?[indexPath.item] {
			
			exploreVC?.handleShowProfile(userSelected: selectedUser)
			
		}
		
		
	}
}

