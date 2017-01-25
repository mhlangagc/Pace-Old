//
//  RoundButtonCorners.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/31.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension UIButton{
	
	func roundedButton(corners:UIRectCorner, radius: CGFloat){
		
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		let rect = self.bounds
		mask.frame = rect
		mask.path = path.cgPath
		self.layer.mask = mask
		
	}
}
