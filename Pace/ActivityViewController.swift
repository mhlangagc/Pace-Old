//
//  ActivityViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ActivityViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var activityControlMenuBar : ActivityMenuBar?
	var newsAndActivityCollection : UICollectionView?
	let activityCellID = "ActivityCellID"
	let newsCellID = "NewsCellID"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = true
		
		self.setupSegmentedControl()
		self.setupCollectionView()
		self.viewConstraints()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = true
	}
	
	func scrollToMenuIndex(menuIndex: Int) {
		
		let indexPath = NSIndexPath(item: menuIndex, section: 0) as IndexPath
		newsAndActivityCollection?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
		
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		let index = targetContentOffset.pointee.x / view.frame.width
		let indexPath = NSIndexPath(item: Int(index), section: 0) as IndexPath
		activityControlMenuBar?.menuBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
		
	}
	
	func setupSegmentedControl() {
		
		activityControlMenuBar = ActivityMenuBar()
		activityControlMenuBar?.activityController = self
		activityControlMenuBar?.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityControlMenuBar!)
		
	}
	
	func setupCollectionView() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 1
		flowLayout.minimumLineSpacing       = 1
		flowLayout.scrollDirection = .horizontal
		newsAndActivityCollection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		newsAndActivityCollection?.delegate   = self
		newsAndActivityCollection?.dataSource = self
		newsAndActivityCollection?.alwaysBounceVertical = false
		newsAndActivityCollection?.alwaysBounceHorizontal = false
		newsAndActivityCollection?.allowsSelection = false
		newsAndActivityCollection?.isPagingEnabled = true
		newsAndActivityCollection?.backgroundColor = UIColor.black
		newsAndActivityCollection?.translatesAutoresizingMaskIntoConstraints = false
		
		newsAndActivityCollection?.register(ActivityCollectionCell.self, forCellWithReuseIdentifier: activityCellID)
		newsAndActivityCollection?.register(NewsCollectionCell.self, forCellWithReuseIdentifier: newsCellID)
		
		view.addSubview(newsAndActivityCollection!)
		
	}
	
	
	
	func viewConstraints() {
		
		activityControlMenuBar?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		activityControlMenuBar?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		activityControlMenuBar?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		activityControlMenuBar?.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
		
		
		
		newsAndActivityCollection?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		newsAndActivityCollection?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		newsAndActivityCollection?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		newsAndActivityCollection?.topAnchor.constraint(equalTo: (activityControlMenuBar?.bottomAnchor)!).isActive = true
		
		
	}

	
	func handleShowProfile() {
		
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
		
	}
	
	func handleShowWorkoutView() {
		
		let showWorkoutDetailsVC = WorkoutViewController()
		showWorkoutDetailsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(showWorkoutDetailsVC, animated: true)
	}
	
}
