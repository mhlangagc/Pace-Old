//
//  ChatMessagesCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import LBTAComponents

class MessagePostsCell: CollectionBaseCell {
	
	let profileImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.image = UIImage(named: "cynthia")
		imageView.layer.cornerRadius = 15
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let profileNameLabel: UILabel = {
	
		let label = UILabel()
		label.textColor = UIColor.greyWhite()
		label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
		textSpacing(label, spacing: 0.36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	
	}()
	
	let textView: UITextView = {
		
		let textView = UITextView()
		textView.isUserInteractionEnabled = false
		textView.backgroundColor = .clear
		textView.textAlignment = .left
		textView.textColor = UIColor.greyWhite()
		textView.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
		
	}()
	
	let messageImageView: CachedImageView = {
		
		let imageView = CachedImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFill
		return imageView
		
	}()
	
	let likeButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "like"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let numberOfLikesLabel: UILabel = {
		
		let label = UILabel()
		label.text = "12"
		label.textColor = UIColor.greyWhite()
		label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
		textSpacing(label, spacing: 0.36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let moreButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		button.tintColor = UIColor.darkBlack()
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let bottomDividerLine: UIView = {
		
		let line = UIView()
		line.backgroundColor = UIColor.darkBlack()
		line.translatesAutoresizingMaskIntoConstraints = false
		return line
		
	}()
	
	let topDividerLine: UIView = {
		
		let line = UIView()
		line.backgroundColor = UIColor.darkBlack()
		line.translatesAutoresizingMaskIntoConstraints = false
		return line
		
	}()
	
	
	var  messagesModel : TeamMessagesModel? {
		
		didSet {
			
			if let sender = messagesModel?.userSending {
				
				profileNameLabel.text = sender
				
			}
			
			if let messageImageUrl = messagesModel?.imageURL {
				
				messageImageView.loadImage(urlString: messageImageUrl)
				messageImageView.isHidden = false
				backgroundColor = UIColor.clear
			
			} else {
			
				messageImageView.isHidden = true
			
			}

			
			if let messageSent  = messagesModel?.message {
				
				textView.text = messageSent
				
			}
			
			
		}

	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
	}
	
	var imageHeightAnchor: NSLayoutConstraint?
	
	func addViews() {
		
		addSubview(profileImageView)
		addSubview(profileNameLabel)
		addSubview(moreButton)
		addSubview(textView)
		addSubview(likeButton)
		addSubview(numberOfLikesLabel)
		addSubview(messageImageView)
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		
		profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15).isActive = true
		profileNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		profileNameLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
		profileNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		moreButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18).isActive = true
		moreButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		moreButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		moreButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
		
		
		likeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
		likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
		likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		likeButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
		
		numberOfLikesLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15).isActive = true
		numberOfLikesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
		numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
		numberOfLikesLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
		
		
		messageImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		messageImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20).isActive = true
		messageImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		messageImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
		
		textView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15).isActive = true
		textView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25).isActive = true
		textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18).isActive = true
		textView.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -30).isActive = true

		
	}
}
