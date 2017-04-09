//
//  MusicPlayerView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class MusicPlayerView : BaseView {
	
	var workoutProcessVC: WorkoutProcessViewController?
	
	let musicButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "ghostStories"), for: UIControlState.normal)
		button.layer.cornerRadius = 6
		button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let songPlayingLabel: UILabel = {
		
		let label = UILabel()
		label.text = "Let it happen"
		label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		label.textColor = UIColor.white
		textSpacing(label, spacing: 0.4)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let playButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "play"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	
	let forwardButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "forward"), for: UIControlState.normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.headerBlack()
		
		self.addButtonViews()
	
	}
	
	
	func addButtonViews() {
		
		
		addSubview(musicButton)
		musicButton.addTarget(self, action: #selector(handleMusicSelect), for: UIControlEvents.touchUpInside)
		
		
		addSubview(forwardButton)
		forwardButton.addTarget(self, action: #selector(handleMusicPlay), for: UIControlEvents.touchUpInside)
		
		
		addSubview(playButton)
		playButton.addTarget(self, action: #selector(handleMusicPlay), for: UIControlEvents.touchUpInside)
		
		
		addSubview(songPlayingLabel)
	
		musicButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
		musicButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		musicButton.heightAnchor.constraint(equalToConstant: 49.0).isActive = true
		musicButton.widthAnchor.constraint(equalToConstant: 49.0).isActive = true
		
		forwardButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
		forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		forwardButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
		forwardButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
		
		
		playButton.rightAnchor.constraint(equalTo: forwardButton.leftAnchor, constant: -15.0).isActive = true
		playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		playButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
		playButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
		
		songPlayingLabel.leftAnchor.constraint(equalTo: musicButton.rightAnchor, constant: 15.0).isActive = true
		songPlayingLabel.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -15.0).isActive = true
		songPlayingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		songPlayingLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
	}
	
	func handleMusicSelect() {
		
		//	TO DO
		
	}
	
	func handleMusicPlay() {
		
		// TO DO
	}
	

}

