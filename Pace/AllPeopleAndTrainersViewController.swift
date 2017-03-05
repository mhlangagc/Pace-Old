//
//  AllPeopleAndTrainersViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//


import UIKit
import AsyncDisplayKit

class AllPeopleViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {
	
	var collectionNode : ASCollectionNode?
	
	var allTrainersArray : [UserModel]?
	
	lazy var ExploreWorkoutSetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 10.0
		flowLayout.minimumLineSpacing       = 15.0
		flowLayout.scrollDirection = .vertical
		flowLayout.sectionInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 10.0, right: 10.0)
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: collectionNode!)
		
		self.setupCollectionView()
		
		//allTrainersArray = ExploreWorkoutSetup.suggestedTrainers()
		
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Suggested Trainers"
		navigationNoLineBar()
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationNoLineBar()
		
	}
	
	
	
}




