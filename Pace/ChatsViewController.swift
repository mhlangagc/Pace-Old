//
//  PostViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ChatsViewController : ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDelegateFlowLayout, ASCollectionDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var clubModel: ClubModel?
	var imageContainerViewTopAnchor: NSLayoutConstraint?

	var messagesArray = [TeamMessagesModel]()
	var imageUrl: String?
	
	var userName: String?
	var userImageURL : String?
	
	var collectionNode : ASCollectionNode?
	var trainer = User()
	var exploreWorkout : ExploreWorkoutModel?
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 8
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		collectionNode?.backgroundColor = UIColor.closeBlack()
		super.init(node: collectionNode!)
		navigationNoLineBar()
		
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.leadingScreensForBatching = 1.0
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.keyboardDismissMode = .interactive
		//collectionNode?.view.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0.0, bottom: 64, right: 0.0)
		collectionNode?.view.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 64, right: 0.0)
		collectionNode?.view.showsVerticalScrollIndicator = false
		collectionNode?.view.backgroundColor = UIColor.closeBlack()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		fatalError("Storyboards are incompatible with truth and beauty")
	
	}
	
}
