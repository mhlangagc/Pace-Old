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
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 180)
	}
	
}
