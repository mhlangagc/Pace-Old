//
//  CompletedRunHeaderView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/23.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import MapKit

class CompletedRunHeaderView : BaseView {
	
	var runMapView: MKMapView?
	
	var distanceLabel: UILabel?
	var kmTextLabel: UILabel?
	
	var runningDurationLabel: UILabel?
	var minsLabel: UILabel?
	
	var paceNumberLabel: UILabel?
	var paceTextLabel: UILabel?

	var completedRunVC : CompletedRunViewController?
	let textWidth : CGFloat = 78.0
	
	var lineView : UIView?
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.darkerBlack()
		
		self.mapViews()
		self.clubStats()
		
	}
	
	func mapViews() {
		
		runMapView = MKMapView.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 380))
		runMapView?.mapType = .standard
		runMapView?.showsBuildings = true
		runMapView?.showsCompass = true
		runMapView?.showsPointsOfInterest = true
		runMapView?.showsUserLocation = false
		runMapView?.layer.masksToBounds = true
		addSubview(runMapView!)
	
	}
	
	func clubStats() {
		
		//	Distance Section
		distanceLabel = UILabel.init(frame: CGRect(x: 24.0, y: 430, width: textWidth, height: 46))
		distanceLabel?.text = "8.49"
		distanceLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		distanceLabel?.textColor = UIColor.paceBrandColor()
		distanceLabel?.textAlignment = .center
		textSpacing(distanceLabel!, spacing: 2.4)
		addSubview(distanceLabel!)
		
		
		kmTextLabel = UILabel.init(frame: CGRect(x: 24.0, y: 480, width: textWidth, height: 20))
		kmTextLabel?.text = "km"
		kmTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		kmTextLabel?.textColor = UIColor.greyBlackColor()
		kmTextLabel?.textAlignment = .center
		addSubview(kmTextLabel!)
		
		//	Total Runs
		var xPosition = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			xPosition = (window.frame.width - textWidth) * 0.5
			
		}
		
		runningDurationLabel = UILabel.init(frame: CGRect(x: xPosition, y: 430, width: textWidth, height: 46))
		runningDurationLabel?.text = "34:07"
		runningDurationLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		runningDurationLabel?.textColor = UIColor.paceBrandColor()
		runningDurationLabel?.textAlignment = .center
		textSpacing(runningDurationLabel!, spacing: 2.4)
		addSubview(runningDurationLabel!)
		
		
		minsLabel = UILabel.init(frame: CGRect(x: xPosition, y: 480, width: textWidth, height: 20))
		minsLabel?.text = "mins"
		minsLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		minsLabel?.textColor = UIColor.greyBlackColor()
		minsLabel?.textAlignment = .center
		addSubview(minsLabel!)
		
		
		//	Average Pace
		
		var xEndPosition = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			xEndPosition = window.frame.width - textWidth - 24
			
		}
		paceNumberLabel = UILabel.init(frame: CGRect(x: xEndPosition, y: 430, width: textWidth, height: 46))
		paceNumberLabel?.text = "6:19"
		paceNumberLabel?.font = UIFont(name: "BebasNeueBold", size: 42)
		paceNumberLabel?.textColor = UIColor.paceBrandColor()
		paceNumberLabel?.textAlignment = .center
		textSpacing(paceNumberLabel!, spacing: 2.4)
		addSubview(paceNumberLabel!)
		
		
		paceTextLabel = UILabel.init(frame: CGRect(x: xEndPosition - 5.0, y: 480, width: textWidth + 10.0, height: 20))
		paceTextLabel?.text = "mins/km"
		paceTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		paceTextLabel?.textColor = UIColor.greyBlackColor()
		paceTextLabel?.textAlignment = .center
		addSubview(paceTextLabel!)

	}
	

	func handleShowProfile() {
		
		//workoutDetailVC?.handleOpenProfile()
		
	}
	
	
}
