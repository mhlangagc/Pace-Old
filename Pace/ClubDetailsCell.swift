//
//  ClubDetailsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubDetailsCell : TableBaseCell {
	
	
	let profileImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 42 * 0.5
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let userName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyWhite()
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let disclosureIndicator: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "DisclosureIndicator")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	
	var userMember : User? {
		
		didSet {
			
			if let usersName = userMember?.name, let imageURL = userMember?.profileImageUrl {
				
				userName.text = usersName
				profileImage.loadImageFromCacheWithUrlString(urlString: imageURL)
				
			}
			
		}
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.paceBackgroundBlack()
		self.setupView()
		
	}
	
	func setupView() {
		
		addSubview(profileImage)
		addSubview(userName)
		addSubview(disclosureIndicator)
		
		profileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		profileImage.widthAnchor.constraint(equalToConstant: 42.0).isActive = true
		profileImage.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
		
		disclosureIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		disclosureIndicator.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
		disclosureIndicator.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		
		userName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 24.0).isActive = true
		userName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		userName.rightAnchor.constraint(equalTo: disclosureIndicator.leftAnchor, constant: -5.0).isActive = true
		userName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
	}
	
}
