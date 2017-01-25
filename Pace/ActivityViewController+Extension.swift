//
//  ActivityViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//


import UIKit

extension ActivityViewController {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return 2
	
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.item == 0 {
			
			let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: activityCellID, for: indexPath) as! ActivityCollectionCell
			return activityCell
			
		} else {
			
			let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellID, for: indexPath) as! NewsCollectionCell
			newsCell.activityViewController = self
			return newsCell
		}
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: view.frame.height - 90.0)
		
	}
	
	
}
