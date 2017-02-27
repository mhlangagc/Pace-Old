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

class GroupsViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {

	var groupCollectionNode : ASCollectionNode?

	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 5
		flowLayout.scrollDirection = .vertical
		groupCollectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: groupCollectionNode!)
		
		navigationNoLineBar()
		self.setupCollectionView()
		
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
		navigationItem.title = "Groups"
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
		
	}
	
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Groups"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleOpenSettings))
	}

	
	func handleOpenSettings() {
		
		let settingsVC = SettingsViewController()
		settingsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(settingsVC, animated: true)
	
	}

	
}

