//
//  FollowingAndFollowersViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FollowersViewController : ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
	
	var followersTableNode : ASTableNode?
	var followersTitle = String()
	
	init() {
		
		followersTableNode = ASTableNode(style:.plain)
		super.init(node: followersTableNode!)
		
		self.setupFollowersTableNode()
		self.self.setupNavigationBar()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = false
		self.setupNavigationBar()
		view.backgroundColor = .black
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.setupNavigationBar()
	}
	
	
	func setupNavigationBar() {
		
		self.title = followersTitle
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.barStyle = .black
	}

	
	func setupFollowersTableNode() {
		
		self.followersTableNode?.delegate = self
		self.followersTableNode?.dataSource = self
		self.followersTableNode?.backgroundColor = UIColor.black
		self.followersTableNode?.view.separatorStyle = .none
		self.followersTableNode?.view.showsVerticalScrollIndicator = false
		
	}
	
	
}
