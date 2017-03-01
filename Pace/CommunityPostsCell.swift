//
//  ChatMessagesCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class CommunityPostsCell: CollectionBaseCell {
	
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
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
		textSpacing(label, spacing: 0.36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	
	}()
	
	let textView: UITextView = {
		
		let textView = UITextView()
		textView.isUserInteractionEnabled = false
		textView.backgroundColor = .clear
		textView.textAlignment = .center
		textView.textColor = UIColor.greyWhite()
		textView.font = UIFont.systemFont(ofSize: 16.5, weight: UIFontWeightMedium)
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
		
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
		label.textColor = UIColor.darkBlack()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
		textSpacing(label, spacing: 0.36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let postTimeLabel: UILabel = {
		
		let label = UILabel()
		label.text = "12 MINS AGO".uppercased()
		label.textAlignment = .right
		label.textColor = UIColor.darkBlack()
		label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let moreButton : UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
		button.tintColor = UIColor.greyBlackColor()
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
	
	
	var  messagesModel : CommunityMessagesModel? {
		
		didSet {
			
			if let sender  = messagesModel?.userSending {
				
				profileNameLabel.text = sender
				
			}
			
			
			if let messageSent  = messagesModel?.message {
				
				textView.text = messageSent
				
			}
			
			if let numberOfLikes = messagesModel?.numberOfLikes {
				
				numberOfLikesLabel.text = "\(numberOfLikes)"
				
			}
			
			
		}

	}
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
	}
	
	func addViews() {
		
		addSubview(topDividerLine)
		addSubview(profileImageView)
		addSubview(profileNameLabel)
		addSubview(moreButton)
		addSubview(textView)
		addSubview(likeButton)
		addSubview(numberOfLikesLabel)
		addSubview(postTimeLabel)
		addSubview(bottomDividerLine)
		
		topDividerLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		topDividerLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		topDividerLine.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		topDividerLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		
		profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true
		profileNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		profileNameLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
		profileNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		moreButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
		moreButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		moreButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		moreButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
		
		textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
		textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 90).isActive = true
		textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
		textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90).isActive = true
		
		
		likeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
		likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
		likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		likeButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
		
		numberOfLikesLabel.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 20).isActive = true
		numberOfLikesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
		numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
		numberOfLikesLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
		
		postTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
		postTimeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
		postTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
		postTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
		
		bottomDividerLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		bottomDividerLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		bottomDividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		bottomDividerLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
	}
}
