//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamsViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {

	var groupCollectionNode : ASCollectionNode?
	var chatGroupsArray : [TeamsModel]?
	
	
	lazy var ChatGroupSetup: GroupChatViewModel = {
		
		let groupSetup = GroupChatViewModel()
		return groupSetup
		
	}()
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.minimumInteritemSpacing  = 10
		flowLayout.minimumLineSpacing       = 10
		flowLayout.sectionInset = UIEdgeInsets(top: 30.0, left: 5.0, bottom: 20.0, right: 5.0)
		groupCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: groupCollectionNode!)
		
		navigationNoLineBar()
		self.setupCollectionView()
		
		chatGroupsArray = ChatGroupSetup.createChatGroups()
		
	}
	
	
	func setupCollectionView() {
		
		groupCollectionNode?.delegate   = self
		groupCollectionNode?.dataSource = self
		groupCollectionNode?.view.alwaysBounceVertical = true
		groupCollectionNode?.view.allowsSelection = true
		groupCollectionNode?.view.showsVerticalScrollIndicator = false
		groupCollectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		titleLabel.text = "Community"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	}

	
}

