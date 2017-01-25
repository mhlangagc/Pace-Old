//
//  ActivityCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

private let ActivityCellDetailsCellID = "ActivityCellDetailsCellID"

class ActivityCollectionCell : CollectionViewBaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var activityCollectionView : UICollectionView?
	
	var activityArray : [ActivitiesModel]?
	
	lazy var ActivitiesSetup: ActivityViewModel = {
		
		let activitiesSetup = ActivityViewModel()
		return activitiesSetup
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		
		self.setupCollectionView()
		self.viewConstraints()
		
		activityArray = ActivitiesSetup.setupPlaceholderActivity()
		
	}
	
	func setupCollectionView() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 30
		flowLayout.minimumLineSpacing       = 30
		flowLayout.scrollDirection = .vertical
		activityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		activityCollectionView?.delegate   = self
		activityCollectionView?.dataSource = self
		activityCollectionView?.alwaysBounceVertical = false
		activityCollectionView?.allowsSelection = true
		activityCollectionView?.backgroundColor = UIColor.black
		activityCollectionView?.translatesAutoresizingMaskIntoConstraints = false
		
		activityCollectionView?.register(ActivityCell.self, forCellWithReuseIdentifier: ActivityCellDetailsCellID)
		
		addSubview(activityCollectionView!)
		
	}
	
	
	
	func viewConstraints() {
		
		activityCollectionView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		activityCollectionView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		activityCollectionView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		activityCollectionView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
		
		
	}
	
	
}

extension ActivityCollectionCell {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return (activityArray?.count)!
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCellDetailsCellID, for: indexPath) as! ActivityCell
		activityCell.activityModel = activityArray?[indexPath.item]
		return activityCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: frame.width, height: 300.0)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
	
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	
		collectionView.deselectItem(at: indexPath, animated: true)
	}

}
