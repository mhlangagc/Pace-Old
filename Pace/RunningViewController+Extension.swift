//
//  RunningViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension RunningViewController {
	
	func setupLogoNavItem() {
		
		let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
		titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		titleImageView.contentMode = .scaleAspectFit
		
		navigationItem.titleView = titleImageView
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
	}
	
	func setupDistanceContainerView() {
		
		view.addSubview(distanceContainerView)
		
		self.distanceContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		self.distanceContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
		self.distanceContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		self.distanceContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
		
	}
	
	func setupTimerContainerView() {
		
		view.addSubview(timeContainerView)
		
		self.timeContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 42).isActive = true
		self.timeContainerView.topAnchor.constraint(equalTo: self.distanceContainerView.bottomAnchor, constant: 32).isActive = true
		self.timeContainerView.widthAnchor.constraint(equalToConstant: 90).isActive = true
		self.timeContainerView.heightAnchor.constraint(equalToConstant: 105).isActive = true
	}
	
	
	func setupPaceContainerView() {
		
		view.addSubview(paceContainerView)
		
		self.paceContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -42).isActive = true
		self.paceContainerView.topAnchor.constraint(equalTo: self.distanceContainerView.bottomAnchor, constant: 32).isActive = true
		self.paceContainerView.widthAnchor.constraint(equalToConstant: 90).isActive = true
		self.paceContainerView.heightAnchor.constraint(equalToConstant: 105).isActive = true
	}
	
	func setupPauseButton() {
		
		view.addSubview(pauseButton)
		
		pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		pauseButton.heightAnchor.constraint(equalToConstant: 116).isActive = true
		pauseButton.widthAnchor.constraint(equalToConstant: 116).isActive = true
		pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -116).isActive = true
		
	}
	
	func setupPlayerView() {
		
		musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: view.frame.height - 149.0, width: view.frame.width, height: 85.0))
		view.addSubview(musicPlayerView!)
	}
	
}
