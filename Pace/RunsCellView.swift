//
//  RunsCellView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RunsCellView : TableBaseCell {
	
	let runsImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 8.0
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let runDayName: UILabel = {
		
		let label = UILabel()
		label.text = "Tuesday Morning Run"
		label.textColor = UIColor.greyWhite()
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let runDetails: UILabel = {
		
		let label = UILabel()
		label.text = "4.40km        8:05/km         35:31"
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
	}

	func setupView() {
		
		self.contentView.addSubview(runsImage)
		self.contentView.addSubview(runDayName)
		self.contentView.addSubview(runDetails)
		
		runsImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		runsImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		runsImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		runsImage.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
		
		runDayName.leftAnchor.constraint(equalTo: runsImage.rightAnchor, constant: 15.0).isActive = true
		runDayName.topAnchor.constraint(equalTo: topAnchor, constant: 35.0).isActive = true
		runDayName.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
		runDayName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		runDetails.leftAnchor.constraint(equalTo: runsImage.rightAnchor, constant: 15.0).isActive = true
		runDetails.topAnchor.constraint(equalTo: runDayName.bottomAnchor, constant: 10.0).isActive = true
		runDetails.rightAnchor.constraint(equalTo:  rightAnchor, constant: -20.0).isActive = true
		runDetails.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
	}
	
}

