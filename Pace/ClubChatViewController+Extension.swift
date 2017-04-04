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
		
		return messagesArray.count
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let chatCell : ClubChatCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClubChatCellID, for: indexPath) as! ClubChatCell
		chatCell.messagesModel = messagesArray[indexPath.item]
		return chatCell
		
	}
	
	private func estimateFrameForText(text: String) -> CGRect {
		
		let size = CGSize(width: 290, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)], context: nil)
	}

	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 80
		
		if let text = messagesArray[indexPath.item].message {
			
			height = estimateFrameForText(text: text).height + 118
		
		}
		
		let width = UIScreen.main.bounds.width
		
		return CGSize(width: width, height: height)
	}
	
}
