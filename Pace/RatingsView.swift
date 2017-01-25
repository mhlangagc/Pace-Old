//
//  RatingsView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RatingView: BaseView {
	
	var ratingValue = 4
	
	
	func createRatingImage(ratingColor: UIColor?) -> UIImageView {
		
		let ratingIv = UIImageView()
		ratingIv.image = UIImage(named: "star")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		ratingIv.tintColor = ratingColor
		ratingIv.contentMode = .scaleAspectFit
		ratingIv.layer.masksToBounds = true
		return ratingIv

		
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.clear
		self.setupRatingStars()
	}
	
	func setupRatingStars() {
		
		let star_1 = createRatingImage(ratingColor: UIColor.greyBlackColor())
		star_1.frame = CGRect(x: 0.0, y: 0.0, width: 15.0, height: 15.0)
		addSubview(star_1)
		
		let star_2 = createRatingImage(ratingColor: UIColor.greyBlackColor())
		star_2.frame = CGRect(x: 25.0, y: 0.0, width: 15.0, height: 15.0)
		addSubview(star_2)
		
		let star_3 = createRatingImage(ratingColor: UIColor.greyBlackColor())
		star_3.frame = CGRect(x: 50.0, y: 0.0, width: 15.0, height: 15.0)
		addSubview(star_3)
		
		let star_4 = createRatingImage(ratingColor: UIColor.greyBlackColor())
		star_4.frame = CGRect(x: 75, y: 0.0, width: 15.0, height: 15.0)
		addSubview(star_4)
		
		let star_5 = createRatingImage(ratingColor: UIColor.greyBlackColor())
		star_5.frame = CGRect(x: 100, y: 0.0, width: 15.0, height: 15.0)
		addSubview(star_5)
		
		switch ratingValue {
		case 1:
			
			//	One Star Rating
			star_1.tintColor = UIColor.wednesday()
			
			break
			
		case 2:
			
			star_1.tintColor = UIColor.wednesday()
			star_2.tintColor = UIColor.wednesday()
			
			break
			
		case 3:
			
			star_1.tintColor = UIColor.wednesday()
			star_2.tintColor = UIColor.wednesday()
			star_3.tintColor = UIColor.wednesday()
			
			break
			
		case 4:
			
			star_1.tintColor = UIColor.wednesday()
			star_2.tintColor = UIColor.wednesday()
			star_3.tintColor = UIColor.wednesday()
			star_4.tintColor = UIColor.wednesday()
			
			break
			
		case 5:
			
			star_1.tintColor = UIColor.wednesday()
			star_2.tintColor = UIColor.wednesday()
			star_3.tintColor = UIColor.wednesday()
			star_4.tintColor = UIColor.wednesday()
			star_5.tintColor = UIColor.wednesday()
			
			break
			
			
		default:
			
			break
		}
		
		
		
		
		
	}
}


