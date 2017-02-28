//
//  ChatMessagesCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/28.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatMessageCell: CollectionBaseCell {
	
	let textView: UITextView = {
		let textView = UITextView()
		textView.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
		textView.backgroundColor = .clear
		textView.textColor = .greyWhite()
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
		
	}()
	
	let bubbleView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkerBlack()
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "cynthia")
		imageView.layer.cornerRadius = 15
		imageView.layer.masksToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	var bubbleWidthAnchor: NSLayoutConstraint?
	var bubbleViewRightAnchor: NSLayoutConstraint?
	var bubbleViewLeftAnchor: NSLayoutConstraint?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
	}
	
	func addViews() {
		
		addSubview(bubbleView)
		addSubview(textView)
		addSubview(profileImageView)
		
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		
		bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
		bubbleViewRightAnchor?.isActive = true
		bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20)
		bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 280)
		bubbleWidthAnchor?.isActive = true
		bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
		
		textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 10).isActive = true
		textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -5).isActive = true
		textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
		
	}
}
