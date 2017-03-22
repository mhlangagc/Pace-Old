//
//  RunReadyViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RunReadyViewController : UIViewController {
	
	var club: ClubModel?
	var musicPlayerView : MusicPlayerView?
	
	
	// Distance Stat
	let kmNumberLabel: UILabel = {
		
		let label = UILabel()
		label.text = "456"
		label.textAlignment = .center
		textSpacing(label, spacing: 2.4)
		label.textColor = UIColor.greyWhite()
		label.font = UIFont(name: "BebasNeueBold", size: 42)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let kmTextLabel: UILabel = {
		
		let label = UILabel()
		label.text = "total km".lowercased()
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var distanceContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.kmNumberLabel)
		self.kmNumberLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.kmNumberLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
		self.kmNumberLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.kmNumberLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
		
		
		containerView.addSubview(self.kmTextLabel)
		self.kmTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.kmTextLabel.topAnchor.constraint(equalTo: self.kmNumberLabel.bottomAnchor, constant: 4).isActive = true
		self.kmTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.kmTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()

	
	//	Total Runs Stat
	let totalRunsNumberLabel: UILabel = {
		
		let label = UILabel()
		label.text = "34"
		label.textAlignment = .center
		textSpacing(label, spacing: 2.4)
		label.textColor = UIColor.greyWhite()
		label.font = UIFont(name: "BebasNeueBold", size: 42)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let totalRunsTextLabel: UILabel = {
		
		let label = UILabel()
		label.text = "total runs".lowercased()
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var totalRunsContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.totalRunsNumberLabel)
		self.totalRunsNumberLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.totalRunsNumberLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
		self.totalRunsNumberLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.totalRunsNumberLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
		
		
		containerView.addSubview(self.totalRunsTextLabel)
		self.totalRunsTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.totalRunsTextLabel.topAnchor.constraint(equalTo: self.totalRunsNumberLabel.bottomAnchor, constant: 4).isActive = true
		self.totalRunsTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.totalRunsTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()
	
	
	//	Pace Stat
	let paceNumberLabel: UILabel = {
		
		let label = UILabel()
		label.text = "7:09"
		label.textAlignment = .center
		textSpacing(label, spacing: 2.4)
		label.textColor = UIColor.greyWhite()
		label.font = UIFont(name: "BebasNeueBold", size: 42)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let paceTextLabel: UILabel = {
		
		let label = UILabel()
		label.text = "mins/km".lowercased()
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var paceContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.paceNumberLabel)
		self.paceNumberLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.paceNumberLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
		self.paceNumberLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.paceNumberLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
		
		
		containerView.addSubview(self.paceTextLabel)
		self.paceTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.paceTextLabel.topAnchor.constraint(equalTo: self.paceNumberLabel.bottomAnchor, constant: 4).isActive = true
		self.paceTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.paceTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()
	
	let goButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("GO", for: UIControlState.normal)
		button.setTitleColor(UIColor.greyWhite(), for: UIControlState.normal)
		button.titleLabel?.font = UIFont(name: "BebasNeueBold", size: 60)
		textSpacing(button.titleLabel!, spacing: 3)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		navigationItem.title = club?.name?.uppercased()
		self.navigationBarItems()
		self.setupRightNavItem()
		self.setupTotalRuns()
		self.setupDistanceContainer()
		self.setupPaceContainerView()
		self.setupGoButton()
		self.setupPlayerView()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.navigationController?.navigationBar.isHidden = false
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
	
	}
	
	
}
