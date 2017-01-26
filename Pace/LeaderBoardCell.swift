//
//  LeaderBoardCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class LeaderBoardCell : CollectionViewBaseCell {
	
	let profileImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.layer.cornerRadius = 31.0
		imageView.layer.borderColor = UIColor.greyBlackColor().cgColor
		imageView.layer.borderWidth = 2.0
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupCell()
		
	}
	
	func setupCell() {
		
		addSubview(profileImageView)
		
		profileImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		profileImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
		
	}
}
