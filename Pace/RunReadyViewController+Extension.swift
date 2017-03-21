//
//  RunReadyViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension RunReadyViewController {
	
	func setupTotalRuns() {
		
		view.addSubview(totalRunsContainerView)
		
		self.totalRunsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		self.totalRunsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
		self.totalRunsContainerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
		self.totalRunsContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
	}
	
	func setupDistanceContainer() {
		
		view.addSubview(distanceContainerView)
		
		self.distanceContainerView.rightAnchor.constraint(equalTo: totalRunsContainerView.leftAnchor, constant: -60).isActive = true
		self.distanceContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
		self.distanceContainerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
		self.distanceContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
		
	}
	
	func setupPaceContainerView() {
		
		view.addSubview(paceContainerView)
		
		self.paceContainerView.leftAnchor.constraint(equalTo: totalRunsContainerView.rightAnchor, constant: 60).isActive = true
		self.paceContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
		self.paceContainerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
		self.paceContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
		
	}
	
	func setupGoButton() {
		
		goButton.addTarget(self, action: #selector(handleGo), for: UIControlEvents.touchUpInside)
		view.addSubview(goButton)
		
		self.goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		self.goButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		self.goButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		self.goButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		self.goButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
	}
	
	func setupRightNavItem() {
		
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleClose), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Love Handles & Core Team".uppercased()
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		navigationItem.titleView = titleLabel
	}
	
	func setupPlayerView() {
		
		musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: view.frame.height - 149.0, width: view.frame.width, height: 85.0))
		view.addSubview(musicPlayerView!)
	}
	
	
	func handleClose() {
		
		self.dismiss(animated: true, completion: nil)
		
	}
	
	func handleGo() {
		
		self.navigationController?.pushViewController(RunningViewController(), animated: true)
		
	}
	
}

