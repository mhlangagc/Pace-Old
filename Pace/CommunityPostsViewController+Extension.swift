//
//  ChatViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension CommunityPostsViewController {
	
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return (messagesArray?.count)!
	
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCellID, for: indexPath) as! CommunityPostsCell
		
		messageCell.messagesModel = messagesArray?[indexPath.item]
		
		return messageCell

		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 80
		if let text = messagesArray?[indexPath.item].message {
			height = estimateFrameForText(text: text).height + 170 //+ 190
		}
		
		let width = UIScreen.main.bounds.width
		return CGSize(width: width, height: height)
		
	}
	
	private func estimateFrameForText(text: String) -> CGRect {
	
		let size = CGSize(width: 300, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)], context: nil)
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return 40.0

	}

	
}

extension CommunityPostsViewController {
	
	
//	func setupKeyboardObservers() {
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//		
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
	}
	
//	func handleKeyboardWillShow(notification: NSNotification) {
//		let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//		let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
//		
//		containerViewBottomAnchor?.constant = -keyboardFrame!.height
//		
//		UIView.animate(withDuration: keyboardDuration!) {
//			self.view.layoutIfNeeded()
//		}
//		
//	}
//	
//	func handleKeyboardWillHide(notification: NSNotification) {
//		
//		let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
//		
//		containerViewBottomAnchor?.constant = 0
//		UIView.animate(withDuration: keyboardDuration!) {
//			self.view.layoutIfNeeded()
//		}
//	}
}

