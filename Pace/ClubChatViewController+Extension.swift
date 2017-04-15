//
//  ClubChatViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension ClubChatViewController {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
	
		return 1
	
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return userRunsArray.count
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let runsCell : ClubRunsCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClubRunsCellID, for: indexPath) as! ClubRunsCell
		runsCell.runsModel = userRunsArray[indexPath.item]
		return runsCell
		
	}
	
	private func estimateFrameForText(text: String) -> CGRect {
		
		let size = CGSize(width: 290, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)], context: nil)
	
	}

	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		/*
		var height: CGFloat = 220
		
		if let text = messagesArray[indexPath.item].message {
			
			if messagesArray[indexPath.item].message == "" {
			
				height = 200.0
				
			} else {
				
				height = estimateFrameForText(text: text).height + 100
				
			}
			
		}
		
		let width = UIScreen.main.bounds.width
		*/
		
		return CGSize(width: UIScreen.main.bounds.width, height: 200)
	}
	
}
