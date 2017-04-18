//
//  ProfileSettingsHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/15.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ProfileTabHeaderView : BaseView {
	
	var profileVC : ProfileViewController?
	
	var firstLetterCharacter : UILabel?
	var profileImageView : UIImageView?
	var profileNameLabel : UILabel?
	var editProfileNameButton: UIButton?
	
	var kmNumberLabel: UILabel?
	var kmTextLabel: UILabel?
	
	var totalRunsNumberLabel: UILabel?
	var totalRunsTextLabel: UILabel?
	
	var paceNumberLabel: UILabel?
	var paceTextLabel: UILabel?
	
	let textWidth : CGFloat = 78.0
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor(fromHexString: "0C0E10")
		
		self.addViews()
	}
	
	func addViews() {
		
		firstLetterCharacter = UILabel.init(frame: CGRect(x: ((frame.width - 100.0) * 0.5), y: 60.0, width: 100.0, height: 100.0))
		firstLetterCharacter?.textAlignment = .center
		firstLetterCharacter?.textColor = UIColor.paceBrandColor()
		firstLetterCharacter?.font = UIFont.systemFont(ofSize: 45, weight: UIFontWeightHeavy)
		
		profileImageView = UIImageView.init(frame: CGRect(x: ((frame.width - 100.0) * 0.5), y: 60.0, width: 100.0, height: 100.0))
		profileImageView?.backgroundColor = UIColor.darkBlack()
		profileImageView?.isUserInteractionEnabled = true
		profileImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUpdateProfilePicture)))
		profileImageView?.contentMode = .scaleAspectFill
		profileImageView?.layer.cornerRadius = 50.0
		profileImageView?.layer.masksToBounds = true
		addSubview(profileImageView!)
		addSubview(firstLetterCharacter!)
		
		profileNameLabel = UILabel.init(frame: CGRect(x: 0.0, y: 200, width: frame.width, height: 32.0))
		profileNameLabel?.textAlignment = .center
		profileNameLabel?.textColor = UIColor.greyWhite()
		profileNameLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightBlack)
		addSubview(profileNameLabel!)
		

		editProfileNameButton = UIButton.init(frame: CGRect(x: 0.0, y: 220, width: frame.width, height: 18.0))
		editProfileNameButton?.contentHorizontalAlignment = .center
		editProfileNameButton?.setTitle("Edit profile", for: UIControlState.normal)
		editProfileNameButton?.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		//editProfileNameButton?.addTarget(self, action: #selector(handleEditProfile), for: UIControlEvents.touchUpInside)
		editProfileNameButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		//addSubview(editProfileNameButton!)
		
		
		
		//	Distance Section
		kmNumberLabel = UILabel.init(frame: CGRect(x: 24.0, y: 280, width: textWidth, height: 46))
		kmNumberLabel?.text = "8.49"
		kmNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		kmNumberLabel?.textColor = UIColor.greyWhite()
		kmNumberLabel?.textAlignment = .center
		textSpacing(kmNumberLabel!, spacing: 2.4)
		addSubview(kmNumberLabel!)
		
		
		kmTextLabel = UILabel.init(frame: CGRect(x: 24.0, y: 330, width: textWidth, height: 20))
		kmTextLabel?.text = "total km"
		kmTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		kmTextLabel?.textColor = UIColor.greyBlackColor()
		kmTextLabel?.textAlignment = .center
		addSubview(kmTextLabel!)
		
		//	Total Runs
		var xPosition = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			xPosition = (window.frame.width - textWidth) * 0.5
			
		}
		
		totalRunsNumberLabel = UILabel.init(frame: CGRect(x: xPosition, y: 280, width: textWidth, height: 46))
		totalRunsNumberLabel?.text = "49"
		totalRunsNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		totalRunsNumberLabel?.textColor = UIColor.greyWhite()
		totalRunsNumberLabel?.textAlignment = .center
		textSpacing(totalRunsNumberLabel!, spacing: 2.4)
		addSubview(totalRunsNumberLabel!)
		
		
		totalRunsTextLabel = UILabel.init(frame: CGRect(x: xPosition, y: 330, width: textWidth, height: 20))
		totalRunsTextLabel?.text = "total runs"
		totalRunsTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		totalRunsTextLabel?.textColor = UIColor.greyBlackColor()
		totalRunsTextLabel?.textAlignment = .center
		addSubview(totalRunsTextLabel!)
		
		//	Average Pace
		var xEndPosition = CGFloat()
		if let window = UIApplication.shared.keyWindow {
			
			xEndPosition = window.frame.width - textWidth - 24
			
		}
		paceNumberLabel = UILabel.init(frame: CGRect(x: xEndPosition, y: 280, width: textWidth, height: 46))
		paceNumberLabel?.text = "7:09"
		paceNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		paceNumberLabel?.textColor = UIColor.greyWhite()
		paceNumberLabel?.textAlignment = .center
		textSpacing(paceNumberLabel!, spacing: 2.4)
		addSubview(paceNumberLabel!)
		
		
		paceTextLabel = UILabel.init(frame: CGRect(x: xEndPosition, y: 330, width: textWidth, height: 20))
		paceTextLabel?.text = "mins/km"
		paceTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		paceTextLabel?.textColor = UIColor.greyBlackColor()
		paceTextLabel?.textAlignment = .center
		addSubview(paceTextLabel!)
		
	}
	
	
	func handleUpdateProfilePicture() {
		
		profileVC?.handleUpdateProfilePicture()
		
	}
}

