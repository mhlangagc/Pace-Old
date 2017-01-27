//
//  ProfileHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ProfileHeaderView : BaseView {

	var nameLabel : UILabel?
	var profileImageView: UIImageView?
	var locationLabel : UILabel?
	var detailsLabel : UILabel?
	
	var followersNumberButton : UIButton?
	var followersButton: UIButton?
	var followingNumberButton: UIButton?
	var followingButton: UIButton?
	var followButton : UIButton?
	
	var profileVC : ProfileViewController?
	var discoverProfileVC : DiscoverProfileViewController?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		
		self.addViews()
	}
	
	func addViews() {
		
		
		nameLabel = UILabel.init(frame: CGRect(x: 20.0, y: 25.0, width: frame.width - 75.0, height: 50.0))
		nameLabel?.sizeThatFits(CGSize(width: frame.width - 75.0, height: 50.0))
		nameLabel?.textColor = UIColor.greyWhite()
		nameLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
		addSubview(nameLabel!)
		
		
		profileImageView = UIImageView.init(frame: CGRect(x: 20.0, y: 137.0, width: 80.0, height: 80.0))
		profileImageView?.contentMode = .scaleAspectFill
		profileImageView?.backgroundColor = UIColor.darkBlack()
		profileImageView?.layer.cornerRadius = 45.0
		profileImageView?.layer.masksToBounds = true
		addSubview(profileImageView!)
		
		
		
		locationLabel = UILabel.init(frame: CGRect(x: 130.0, y: 124, width: frame.width - 145.0, height: 20.0))
		locationLabel?.textColor = UIColor.greyWhite()
		locationLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(locationLabel!)
		
		
		
		detailsLabel = UILabel.init(frame: CGRect(x: 130.0, y: 157, width: frame.width - 145.0, height: 75.0))
		detailsLabel?.numberOfLines = 0
		detailsLabel?.textColor = UIColor.greyBlackColor()
		detailsLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
		addSubview(detailsLabel!)
		
		
		
		
		
		followersNumberButton = UIButton.init(frame: CGRect(x: 20.0, y: frame.height - 70.0, width: 80.0, height: 18.0))
		followersNumberButton?.setTitle("34", for: UIControlState.normal)
		followersNumberButton?.contentHorizontalAlignment = .left
		followersNumberButton?.setTitleColor(UIColor.greyWhite(), for: UIControlState.normal)
		followersNumberButton?.addTarget(self, action: #selector(handleShowFollowers), for: UIControlEvents.touchUpInside)
		followersNumberButton?.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		//addSubview(followersNumberButton!)
		
		followersButton = UIButton.init(frame: CGRect(x: 20.0, y: frame.height - 50.0, width: 80.0, height: 16.0))
		followersButton?.setTitle("Followers", for: UIControlState.normal)
		followersButton?.contentHorizontalAlignment = .left
		followersButton?.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		followersButton?.addTarget(self, action: #selector(handleShowFollowers), for: UIControlEvents.touchUpInside)
		followersButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
		//addSubview(followersButton!)
		
		
		
		
		followingNumberButton = UIButton.init(frame: CGRect(x: 130.0, y: frame.height - 70.0, width: 80.0, height: 18.0))
		followingNumberButton?.setTitle("123", for: UIControlState.normal)
		followingNumberButton?.contentHorizontalAlignment = .left
		followingNumberButton?.setTitleColor(UIColor.greyWhite(), for: UIControlState.normal)
		followingNumberButton?.addTarget(self, action: #selector(handleShowFollowing), for: UIControlEvents.touchUpInside)
		followingNumberButton?.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		//addSubview(followingNumberButton!)
		
		followingButton = UIButton.init(frame: CGRect(x: 130.0, y: frame.height - 50.0, width: 80.0, height: 16.0))
		followingButton?.setTitle("Following", for: UIControlState.normal)
		followingButton?.contentHorizontalAlignment = .left
		followingButton?.setTitleColor(UIColor.greyBlackColor(), for: UIControlState.normal)
		followingButton?.addTarget(self, action: #selector(handleShowFollowing), for: UIControlEvents.touchUpInside)
		followingButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
		//addSubview(followingButton!)
		
		
		followButton = UIButton.init(frame: CGRect(x: frame.width - 155.0, y: frame.height - 80.0, width: 135, height: 40.0))
		followButton?.setTitle("Follow", for: UIControlState.normal)
		followButton?.backgroundColor = UIColor.darkBlack()
		followButton?.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		followButton?.layer.cornerRadius = 8
		followButton?.addTarget(self, action: #selector(handleFollow_Unfollow), for: UIControlEvents.touchUpInside)
		followButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
		//addSubview(followButton!)
		
	}
	
	func handleShowFollowers() {
		
		profileVC?.handleOpenFollowersView()
		
	}
	
	func handleShowFollowing() {
		
		profileVC?.handleOpenFollowingView()
		
	}
	
	func handleFollow_Unfollow() {
		
		//	TODO
		
	}
	
}
