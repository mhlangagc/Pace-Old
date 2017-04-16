//
//  ClubRunsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/16.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubRunsCell: CollectionBaseCell {
	
	let profileImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.headerBlack()
		imageView.layer.cornerRadius = 36 * 0.5
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let nameLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
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
	
	//	Distance
	let kmDistanceLabel : UILabel = {
		
		let label = UILabel()
		label.font = UIFont(name: "BebasNeueBold", size: 35)
		label.textColor = UIColor.paceBrandColor()
		label.textAlignment = .center
		textSpacing(label, spacing: 2.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	
	let distanceTextLabel : UILabel = {
		
		let label = UILabel()
		label.text = "km"
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	//	Time
	let timeLabel : UILabel = {
		
		let label = UILabel()
		label.font = UIFont(name: "BebasNeueBold", size: 35)
		label.textColor = UIColor.paceBrandColor()
		label.textAlignment = .center
		textSpacing(label, spacing: 2.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	
	let timeTextLabel : UILabel = {
		
		let label = UILabel()
		label.text = "min"
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	//	Average Pace
	let paceLabel : UILabel = {
		
		let label = UILabel()
		label.font = UIFont(name: "BebasNeueBold", size: 35)
		label.textColor = UIColor.paceBrandColor()
		label.textAlignment = .center
		textSpacing(label, spacing: 2.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	
	let paceTextLabel : UILabel = {
		
		let label = UILabel()
		label.text = "mins/km"
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var runStatsContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.clear
		containerView.layer.masksToBounds = true
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.distanceTextLabel)
		self.distanceTextLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		self.distanceTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28.0).isActive = true
		self.distanceTextLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.distanceTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
		
		containerView.addSubview(self.kmDistanceLabel)
		self.kmDistanceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		self.kmDistanceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
		self.kmDistanceLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.kmDistanceLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
		
		//
		containerView.addSubview(self.timeTextLabel)
		self.timeTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0).isActive = true
		self.timeTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28.0).isActive = true
		self.timeTextLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.timeTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
		
		containerView.addSubview(self.timeLabel)
		self.timeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20.0).isActive = true
		self.timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
		self.timeLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.timeLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
		
		//
		containerView.addSubview(self.paceTextLabel)
		self.paceTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24.0).isActive = true
		self.paceTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28.0).isActive = true
		self.paceTextLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.paceTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
		
		containerView.addSubview(self.paceLabel)
		self.paceLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24.0).isActive = true
		self.paceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
		self.paceLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
		self.paceLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
		
		return containerView
		
	}()
	
	
	let timeStampLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .right
		label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	
	var  runsModel : RunsModel? {
		
		didSet {
			
			if let userName = runsModel?.userName{
				
				nameLabel.text = userName
				
			}
			
			if let userProfileImageURL = runsModel?.userImageURL {
				
				profileImageView.loadImageFromCacheWithUrlString(urlString: userProfileImageURL)
				
			}
			
			if let messageTime = runsModel?.timeStamp {
				
				timeStampLabel.text = Date(timeIntervalSince1970: Double(messageTime)).timeAgoDisplay()
				
			}
			
			if let distanceRan = runsModel?.distance, let pace = runsModel?.pace {
				
				kmDistanceLabel.text = distanceRan
				paceLabel.text = pace
				
			}
			
			if let mins = runsModel?.mins, let seconds = runsModel?.seconds {
				
				timeLabel.text = "\(mins):\(seconds)"
				
			}
			
			
		}
		
		
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.headerBlack()
		self.configureViews()
		
	}
	
	var textViewHeight: CGFloat?
	
	func configureViews() {
		
		addSubview(profileImageView)
		addSubview(nameLabel)
		addSubview(runStatsContainerView)
		addSubview(timeStampLabel)
		
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
		profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
		
		
		timeStampLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
		timeStampLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		timeStampLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
		timeStampLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
		nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
		nameLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		runStatsContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		runStatsContainerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		runStatsContainerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant : 16).isActive = true
		runStatsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
		
		
		
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

