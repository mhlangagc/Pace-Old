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
		label.text = "Cynthia"
		label.textColor = UIColor.greyWhite()
		label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
		textSpacing(label, spacing: 0.36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	
	}()
	
	let textView: UITextView = {
		let textView = UITextView()
		textView.textAlignment = .center
		textView.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
		textView.backgroundColor = .clear
		textView.textColor = .greyWhite()
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
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
	}
	
	func addViews() {
		
		addSubview(profileImageView)
		addSubview(profileNameLabel)
		addSubview(textView)
		addSubview(likeButton)
		addSubview(numberOfLikesLabel)
		addSubview(postTimeLabel)
		
		
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
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
		
		
		
	}
}
