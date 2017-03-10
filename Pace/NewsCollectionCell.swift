//
//  NewsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

private let NewsCellDetailsCellID = "NewsCellDetailsCellID"

class NewsCollectionCell : CollectionViewBaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var activityCollectionView : UICollectionView?
	var activityViewController : ActivityViewController?
	
	var newsArray : [ActivityNewsModel]?
	
	lazy var NewsSetup: ActivityViewModel = {
		
		let newsSetup = ActivityViewModel()
		return newsSetup
		
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		
		self.setupCollectionView()
		self.viewConstraints()
		
		newsArray = NewsSetup.setupPlaceHolderNews()
		
	}
	
	func setupCollectionView() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 20
		flowLayout.minimumLineSpacing       = 20.0
		flowLayout.scrollDirection = .vertical
		activityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		activityCollectionView?.delegate   = self
		activityCollectionView?.dataSource = self
		activityCollectionView?.alwaysBounceVertical = true
		activityCollectionView?.allowsSelection = true
		activityCollectionView?.backgroundColor = UIColor.black
		activityCollectionView?.translatesAutoresizingMaskIntoConstraints = false
		
		activityCollectionView?.register(NewsDetailsCell.self, forCellWithReuseIdentifier: NewsCellDetailsCellID)
		
		addSubview(activityCollectionView!)
		
	}
	
	
	
	func viewConstraints() {
		
		activityCollectionView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		activityCollectionView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		activityCollectionView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		activityCollectionView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
		
		
	}
	
	
}

extension NewsCollectionCell {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return (newsArray?.count)!
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCellDetailsCellID, for: indexPath) as! NewsDetailsCell
		activityCell.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowCreatorProfile)))
		activityCell.newsModel = newsArray?[indexPath.item]
		return activityCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: frame.width, height: 125.0)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 30.0, right: 0.0)
	
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		collectionView.deselectItem(at: indexPath, animated: true)
		//activityViewController?.handleShowWorkoutView()
		
	}
	
	
	func handleShowCreatorProfile() {
		
		activityViewController?.handleShowProfile()
		
	}
	
	
	
}

