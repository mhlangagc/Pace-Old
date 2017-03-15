//
//  SettingsCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class SettingsCellView : TableBaseCell {
	
	let settingIconImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 4
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let settingName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.white
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightSemibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let settingDetailName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.textAlignment = .right
		label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightBold)
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
	
	
	let dividerLineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkerBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	var  settingsModel : SettingsModel? {
		
		didSet {
			
			if let settingsName  = settingsModel?.setting {
				
				settingName.text = settingsName
				
			}
			
			
			if let detailSetting  = settingsModel?.settingDetail {
				
				settingDetailName.text = detailSetting
				
			}
			
		}
	}
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
		
	}
	
	func setupView() {
		
		self.contentView.addSubview(settingIconImage)
		self.contentView.addSubview(settingName)
		self.contentView.addSubview(settingDetailName)
		self.contentView.addSubview(disclosureIndicator)
		self.contentView.addSubview(dividerLineView)
		
		settingIconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		settingIconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		settingIconImage.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
		settingIconImage.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		disclosureIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
		disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		disclosureIndicator.widthAnchor.constraint(equalToConstant: 8.0).isActive = true
		disclosureIndicator.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
		
		
		settingDetailName.rightAnchor.constraint(equalTo: disclosureIndicator.leftAnchor, constant: -10.0).isActive = true
		settingDetailName.centerYAnchor.constraint(equalTo: disclosureIndicator.centerYAnchor).isActive = true
		settingDetailName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		settingDetailName.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
		
		
		settingName.leftAnchor.constraint(equalTo: settingIconImage.rightAnchor, constant: 15.0).isActive = true
		settingName.centerYAnchor.constraint(equalTo: settingIconImage.centerYAnchor).isActive = true
		settingName.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
		settingName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
		
	}
	
}

