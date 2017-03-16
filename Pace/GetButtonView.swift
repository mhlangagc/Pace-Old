//
//  GetButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/13.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class GetButtonView : BaseView {
	
	var gradientBackground : UIView?
	var getButton: UIButton?
	var tryButton : UIButton?
	var workoutDetailsVC : WorkoutViewController?
	
	override func setupViews() {
		super.setupViews()
		
		self.setupButtons()
		backgroundColor = UIColor.black
		
	}
	
	func setupButtons() {
		
		gradientBackground = UIView()
		gradientBackground?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
		gradientBackground?.backgroundColor = UIColor.clear
		backgroundGradientLayer(view: gradientBackground!, overLayView: self)
		gradientBackground?.layer.masksToBounds = true
		addSubview(gradientBackground!)
		
		tryButton = UIButton()
		tryButton?.frame = CGRect(x: 20.0, y: 10.0, width: 150.0, height: 50.0)
		tryButton?.setTitle("Try out".uppercased(), for: UIControlState.normal)
		tryButton?.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		textSpacing((tryButton?.titleLabel)!, spacing: 0.5)
		tryButton?.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		tryButton?.layer.cornerRadius = 8.0
		tryButton?.layer.masksToBounds = true
		tryButton?.backgroundColor = UIColor.darkBlack()
		tryButton?.addTarget(self, action: #selector(handleTry), for: UIControlEvents.touchUpInside)
		gradientBackground?.addSubview(tryButton!)
		
		
		getButton = UIButton()
		getButton?.frame = CGRect(x: frame.width - 170.0, y: 10.0, width: 150.0, height: 50.0)
		getButton?.setTitle("GET".uppercased(), for: UIControlState.normal)
		getButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
		getButton?.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing((getButton?.titleLabel)!, spacing: 0.5)
		getButton?.layer.cornerRadius = 8.0
		getButton?.layer.masksToBounds = true
		getButton?.backgroundColor = UIColor.paceBrandColor()
		getButton?.addTarget(self, action: #selector(handleGet), for: UIControlEvents.touchUpInside)
		gradientBackground?.addSubview(getButton!)
		
	}
	
	func backgroundGradientLayer(view: UIView, overLayView: UIView) {
		
		let gradient = CAGradientLayer()
		gradient.frame = overLayView.frame
		gradient.startPoint = CGPoint(x: 0.5, y: 0)
		gradient.endPoint = CGPoint(x: 0.5, y: 1)
		let colors : [CGColor] = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.95).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
		let location = [0.0, 0.05, 1.0]
		gradient.colors = colors
		gradient.isOpaque = true
		gradient.locations = location as [NSNumber]?
		view.layer.addSublayer(gradient)
		
	}
	
	
	func handleGet() {
		
		workoutDetailsVC?.handleDownloadWorkout()
		
	}
	
	
	func handleTry() {
		
		workoutDetailsVC?.handleTryWorkout()
		
	}
}
