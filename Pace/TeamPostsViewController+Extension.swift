//
//  ChatViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension TeamPostsViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return messagesArray.count
	
	}
	
	func observeTeamMessages() {
		
		let teamID = teamModel?.workoutID
		var teamMessagesArray = [TeamMessagesModel]()
		let fanUserMessagesRef = FIRDatabase.database().reference().child("fan-team-messages").child(teamID!)
		fanUserMessagesRef.observe(.childAdded, with: { (snapshot) in
			
			let messageId = snapshot.key
			let messagesRef = FIRDatabase.database().reference().child("TeamMessages").child(messageId)
			messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
				
				if let dictionary = snapshot.value as? [String: AnyObject] {
					
					let workoutTeamMessage = TeamMessagesModel()
					
					workoutTeamMessage.userSending = dictionary["userSending"] as? String
					workoutTeamMessage.message = dictionary["message"] as? String
					workoutTeamMessage.timeStamp = dictionary["timeStamp"] as? Int
					teamMessagesArray.append(workoutTeamMessage)
					
					
					
				}
				
				
			}, withCancel: nil)
			
		}, withCancel: nil)
	}


	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCellID, for: indexPath) as! MessagePostsCell
		
//		let fanUserMessagesRef = FIRDatabase.database().reference().child("fan-user-messages").child(messagesArray[indexPath.item].userSending!)
//		fanUserMessagesRef.observe(.childAdded, with: { (snapshot) in
//			
//			let messageId = snapshot.key
//			let messagesRef = FIRDatabase.database().reference().child("Users").child(messageId)
//			messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
//				
//				if let dictionary = snapshot.value as? [String: AnyObject] {
//					
//					let userFound = User()
//					
//					userFound.name = dictionary["name"] as? String
//					userFound.profileImageUrl = dictionary["profileImageUrl"] as? String
//					
//					DispatchQueue.main.async {
//						
//						messageCell.profileNameLabel.text = userFound.name
//						//messageCell.profileImageView.image = UIImageView( NSURL(string: (teamModel?.backgroundImageUrl!)!)! as URL
//						
//						
//					}
//					
//					
//				}
//				
//				
//			}, withCancel: nil)
//			
//		}, withCancel: nil)
		
		
		messageCell.messagesModel = self.messagesArray[indexPath.item]
		
		return messageCell

	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 80
		if let text = messagesArray[indexPath.item].message {
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
		
		return 25.0

	}

	
}

extension TeamPostsViewController {
	
	
//	func setupKeyboardObservers() {
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//		
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//	}
	
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

