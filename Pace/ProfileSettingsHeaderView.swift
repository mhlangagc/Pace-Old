//
//  ProfileSettingsHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/15.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ProfileSettingsHeaderView : BaseView {
	
	var profileImageView : UIImageView?
	var profileNameButton : UIButton?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.paceBackgroundBlack()
		
		self.addViews()
	}
	
	func addViews() {
		
		profileImageView = UIImageView.init(frame: CGRect(x: ((frame.width - 100.0) * 0.5), y: 30.0, width: 100.0, height: 100.0))
		profileImageView?.backgroundColor = UIColor.darkBlack()
		profileImageView?.contentMode = .scaleAspectFill
		profileImageView?.layer.cornerRadius = 50.0
		profileImageView?.layer.masksToBounds = true
		addSubview(profileImageView!)
		
		profileNameButton = UIButton.init(frame: CGRect(x: 0.0, y: 175, width: frame.width, height: 32.0))
		profileNameButton?.contentHorizontalAlignment = .center
		profileNameButton?.setTitleColor(UIColor.greyWhite(), for: UIControlState.normal)
		profileNameButton?.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightBlack)
		addSubview(profileNameButton!)
		
		
	}
	
}

