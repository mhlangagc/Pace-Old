//
//  ChatViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension ChatViewController {
	
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return 7
	
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCellID, for: indexPath) as! ChatMessageCell
		
		let textMessage = "Hey gang, we are working on on organising an event for all our members at GreenPoint. show by a like if you would be interesting in adttending the event."

		messageCell.textView.text = textMessage
		
		//setupCell(cell, message: message)
		
		messageCell.bubbleWidthAnchor?.constant = estimateFrameForText(text: textMessage).width + 32 //lets modify the bubbleView's width somehow
		
		return messageCell

		
		
	}
	
	/*
	private func setupCell(cell: ChatMessageCell, message: Message) {
		if let profileImageUrl = self.user?.profileImageUrl {
			cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
		}
		
		if message.fromId == FIRAuth.auth()?.currentUser?.uid {
			//outgoing blue
			cell.bubbleView.backgroundColor = ChatMessageCell.blueColor
			cell.textView.textColor = UIColor.whiteColor()
			cell.profileImageView.hidden = true
			
			cell.bubbleViewRightAnchor?.active = true
			cell.bubbleViewLeftAnchor?.active = false
			
		} else {
			//incoming gray
			cell.bubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
			cell.textView.textColor = UIColor.blackColor()
			cell.profileImageView.hidden = false
			
			cell.bubbleViewRightAnchor?.active = false
			cell.bubbleViewLeftAnchor?.active = true
		}
	}
	*/
	
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		
		collectionView?.collectionViewLayout.invalidateLayout()
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 80
		
		//get estimated height somehow
		let text = "Hey gang, we are working on on organising an event for all our members at GreenPoint. show by a like if you would be interesting in adttending the event."
		height = estimateFrameForText(text: text).height + 20
		
		let width = UIScreen.main.bounds.width
		return CGSize(width: width, height: height)
		
	}
	
	private func estimateFrameForText(text: String) -> CGRect {
	
		let size = CGSize(width: 300, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)], context: nil)
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return 30.0

	}

	
}

extension ChatViewController {
	
	
	func setupKeyboardObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
	}
	
	func handleKeyboardWillShow(notification: NSNotification) {
		let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
		let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
		
		containerViewBottomAnchor?.constant = -keyboardFrame!.height
		
		UIView.animate(withDuration: keyboardDuration!) {
			self.view.layoutIfNeeded()
		}
		
	}
	
	func handleKeyboardWillHide(notification: NSNotification) {
		
		let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
		
		containerViewBottomAnchor?.constant = 0
		UIView.animate(withDuration: keyboardDuration!) {
			self.view.layoutIfNeeded()
		}
	}
}

