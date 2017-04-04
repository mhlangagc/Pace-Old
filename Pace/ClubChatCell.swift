//
//  ClubChatCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubChatCell: CollectionBaseCell {
	
	let profileImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkerBlack()
		imageView.layer.cornerRadius = 36 * 0.5
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let nameLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "97A9CA")
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBlack)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var likeImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = #imageLiteral(resourceName: "like")
		imageView.isUserInteractionEnabled = true
		imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLike)))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let messageTextView : UITextView = {
		
		let tView = UITextView()
		tView.text = "A delicious wave of Calamari black mussels, clams, crab…"
		tView.textColor = UIColor.greyWhite()
		tView.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		tView.translatesAutoresizingMaskIntoConstraints = false
		tView.backgroundColor = UIColor.clear
		tView.isEditable = false
		tView.isSelectable = false
		return tView

		
	}()
	
	let timeStampLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "3C4459")
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()

	
	
	var  messagesModel : TeamMessagesModel? {
		
		didSet {
			
			if let userName = messagesModel?.userSendingName, let messageText = messagesModel?.message {
				
				nameLabel.text = userName
				messageTextView.text = messageText
			
			}
			
			if let userProfileImageURL = messagesModel?.userSendingImageURL {
				
				profileImageView.loadImageFromCacheWithUrlString(urlString: userProfileImageURL)
				
			}
			
			if let messageTime = messagesModel?.timeStamp {
				
				timeStampLabel.text = Date(timeIntervalSince1970: Double(messageTime)).timeAgoDisplay()
				
			}
			
		
		}
	
		
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .closeBlack()
		self.configureViews()
	
	}
	
	var textViewHeight: CGFloat?
	
	func configureViews() {
		
		addSubview(profileImageView)
		addSubview(nameLabel)
		addSubview(likeImageView)
		addSubview(messageTextView)
		addSubview(timeStampLabel)
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
		
		
		likeImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
		likeImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		likeImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
		likeImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
		
		
		nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
		nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		nameLabel.rightAnchor.constraint(equalTo: likeImageView.leftAnchor, constant: -10).isActive = true
		likeImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		timeStampLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
		timeStampLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18).isActive = true
		timeStampLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
		timeStampLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		messageTextView.rightAnchor.constraint(equalTo: likeImageView.rightAnchor).isActive = true
		messageTextView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
		messageTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant : 2).isActive = true
		messageTextView.bottomAnchor.constraint(equalTo: timeStampLabel.topAnchor, constant: -16).isActive = true
		
		
		
	}
	
	var isLiked = false
	
	func handleLike() {
		
		if isLiked == false {
			
			likeImageView.image = #imageLiteral(resourceName: "like_Active")
			isLiked = true
		
		} else {
			
			likeImageView.image = #imageLiteral(resourceName: "like")
			isLiked = false
			
		}
		
	}
	
}
