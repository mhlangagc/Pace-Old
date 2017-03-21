//
//  RunningViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RunningViewController: UIViewController {
	
	//	Distance
	let kmTimer: UILabel = {
		
		let label = UILabel()
		label.text = "0.00"
		label.textAlignment = .center
		label.textColor = UIColor.white
		label.font = UIFont(name: "BebasNeueBold", size: 120)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let kmLabel: UILabel = {
		
		let label = UILabel()
		label.text = "kilometers".uppercased()
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var distanceContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.kmTimer)
		self.kmTimer.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.kmTimer.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		self.kmTimer.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.kmTimer.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		
		containerView.addSubview(self.kmLabel)
		self.kmLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.kmLabel.topAnchor.constraint(equalTo: self.kmTimer.bottomAnchor).isActive = true
		self.kmLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.kmLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()
	
	// Total Time
	
	let timerImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "totalRunTime")
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let timeNumberLabel: UILabel = {
		
		let label = UILabel()
		label.text = "00:00"
		label.textAlignment = .center
		textSpacing(label, spacing: 2.4)
		label.textColor = UIColor.white
		label.font = UIFont(name: "BebasNeueBold", size: 42)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let minutesLabel: UILabel = {
		
		let label = UILabel()
		label.text = "minutes".lowercased()
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var timeContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(self.timerImageView)
		self.timerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		self.timerImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		self.timerImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
		self.timerImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
		
		containerView.addSubview(self.timeNumberLabel)
		self.timeNumberLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.timeNumberLabel.topAnchor.constraint(equalTo: self.timerImageView.bottomAnchor, constant: 10).isActive = true
		self.timeNumberLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.timeNumberLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
		
		
		containerView.addSubview(self.minutesLabel)
		self.minutesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.minutesLabel.topAnchor.constraint(equalTo: self.timeNumberLabel.bottomAnchor, constant: 8).isActive = true
		self.minutesLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.minutesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()
	
	
	// Pace Time
	
	let paceImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.image = UIImage(named: "stopWatch")
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let paceNumberLabel: UILabel = {
		
		let label = UILabel()
		label.text = "00:00"
		label.textAlignment = .center
		textSpacing(label, spacing: 2.4)
		label.textColor = UIColor.white
		label.font = UIFont(name: "BebasNeueBold", size: 42)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let paceMinutesLabel: UILabel = {
		
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
		
		containerView.addSubview(self.paceImageView)
		self.paceImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		self.paceImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		self.paceImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
		self.paceImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
		
		containerView.addSubview(self.paceNumberLabel)
		self.paceNumberLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.paceNumberLabel.topAnchor.constraint(equalTo: self.paceImageView.bottomAnchor, constant: 10).isActive = true
		self.paceNumberLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.paceNumberLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
		
		
		containerView.addSubview(self.paceMinutesLabel)
		self.paceMinutesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.paceMinutesLabel.topAnchor.constraint(equalTo: self.paceNumberLabel.bottomAnchor, constant: 8).isActive = true
		self.paceMinutesLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.paceMinutesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		return containerView
		
		
	}()
	
	
	lazy var pauseButton : UIButton = {
		
		let pauseButton = UIButton()
		pauseButton.setImage(#imageLiteral(resourceName: "PauseWorkout"), for: UIControlState.normal)
		pauseButton.addTarget(self, action: #selector(handlePauseRun), for: UIControlEvents.touchUpInside)
		pauseButton.translatesAutoresizingMaskIntoConstraints = false
		return pauseButton
		
	}()
	
	var musicPlayerView : MusicPlayerView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		
		self.setupDistanceContainerView()
		self.setupTimerContainerView()
		self.setupPaceContainerView()
		self.setupPauseButton()
		self.setupPlayerView()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationNoLineBar()
		self.navigationItem.setHidesBackButton(true, animated: true)
		self.navigationController?.navigationBar.isHidden = false
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		self.navigationController?.navigationBar.isHidden = true
		self.setupLogoNavItem()
	
	}
	
	
	
	func handlePauseRun() {
		
		//	 TODO
	}

}

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
