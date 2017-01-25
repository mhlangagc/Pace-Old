//
//  BaseView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/11.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class BaseView : UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}

	func setupViews() {
		
		
	}
}
