//
//  ActivityMenuBar+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension ActivityMenuBar {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath as IndexPath) as! MenuBarCell
		cell.barLabel.text = menuLabels[indexPath.item]
		return cell
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
		
	}

	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		activityController?.scrollToMenuIndex(menuIndex: indexPath.item)
	}
	
	
}
