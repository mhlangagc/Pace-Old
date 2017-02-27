//
//  TeamMemberCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/27.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class TeamMemberCell: CollectionBaseCell {
	
	let teamProfileImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.image = UIImage(named: "simon")
		imageView.backgroundColor = UIColor.paceBrandColor()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		addSubview(teamProfileImage)
		
		teamProfileImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		teamProfileImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		teamProfileImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
		teamProfileImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
	}
	
}
