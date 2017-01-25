//
//  TouchBarHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation

class TouchBarHeaderView : BaseView {
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkBlack()
		addViews()
		
		
	}
	
	func addViews() {
		
		let touchBarLabel = UILabel()
		touchBarLabel.frame = CGRect(x: 0.0, y: 27.0, width: frame.width, height: 26.0)
		touchBarLabel.textAlignment = .center
		touchBarLabel.text = "Capture yourself while at it"
		touchBarLabel.textColor = UIColor.greyBlackColor()
		touchBarLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		addSubview(touchBarLabel)

	}
	
}
