//
//  ActivityMenuBar.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

let menuCellId = "menuCellId"
let menuLabels = ["Activity", "News"]


class ActivityMenuBar: BaseView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var activityController: ActivityViewController?
	var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
	
	let backgroundView : UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor.black
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	lazy var menuBarCollectionView: UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0.0
		layout.minimumInteritemSpacing = 0.0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor.darkBlack()
		collectionView.layer.cornerRadius = 6.0
		collectionView.isScrollEnabled = false 
		collectionView.dataSource = self
		collectionView.delegate = self
		return collectionView
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		self.setupBackgroundAndCollectionView()

		let selectedIndexPath = NSIndexPath(item: 0, section: 0) as IndexPath
		menuBarCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
		//setupHorizontalBar()
	}
	
	
	func setupBackgroundAndCollectionView() {
		
		addSubview(backgroundView)
		
		backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
		
		menuBarCollectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: menuCellId)
		menuBarCollectionView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.addSubview(menuBarCollectionView)
		
		menuBarCollectionView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 15.0).isActive = true
		menuBarCollectionView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -15.0).isActive = true
		menuBarCollectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 35.0).isActive = true
		menuBarCollectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10.0).isActive = true
	}
	
	func setupHorizontalBar() {
		
		let horizontalBarView = UIView()
		horizontalBarView.backgroundColor = UIColor.black
		horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(horizontalBarView)
		
		
		horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
		horizontalBarLeftAnchorConstraint?.isActive = true
		
		horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
		horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
	}
	
	
	
}


