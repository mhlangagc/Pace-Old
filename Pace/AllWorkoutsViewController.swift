//
//  AllWorkoutsView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AllWorkoutsViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {
	
	var collectionNode : ASCollectionNode?
	
	//var workoutsPassed : [ExploreModel]?
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 1
		flowLayout.minimumLineSpacing       = 8
		flowLayout.scrollDirection = .vertical
		flowLayout.sectionInset = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 10.0, right: 0.0)
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: collectionNode!)
		
		self.setupCollectionView()
		
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.leadingScreensForBatching = 1.0
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = false
		navigationNoLineBar()
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		navigationNoLineBar()
		
	}
	
}

