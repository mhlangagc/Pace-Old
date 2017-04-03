//
//  ClubChatViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubChatViewController: UIViewController {
	
	var clubModel: ClubModel?
	
	let startWorkoutBar : StartWorkoutButtonView = {
		
		let startWorkoutBar = StartWorkoutButtonView()
		startWorkoutBar.translatesAutoresizingMaskIntoConstraints = false
		return startWorkoutBar
		
	}()
	
	let textFieldBar : TextComposingView = {
		
		let textFieldView = TextComposingView()
		textFieldView.translatesAutoresizingMaskIntoConstraints = false
		return textFieldView
		
	}()
	
	let selectImageBar : ChatImageSelectionBarView = {
		
		let imageSelection = ChatImageSelectionBarView()
		imageSelection.translatesAutoresizingMaskIntoConstraints = false
		return imageSelection
		
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		self.setupNavBar()
		self.setupOverlayViews()
		
	}
	
	func setupNavBar() {
		
		// Title
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBackgroundBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.paceBackgroundBlack()
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
		//	Title
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = clubModel?.name
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		//	Right Bar
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "moreGreen").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleMoreOptions), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	func setupOverlayViews() {
		
		view.addSubview(startWorkoutBar)
		startWorkoutBar.clubChatVC = self
		
		
		view.addSubview(textFieldBar)
		
		startWorkoutBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		startWorkoutBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		startWorkoutBar.heightAnchor.constraint(equalToConstant: 62).isActive = true
		startWorkoutBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		
		textFieldBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		textFieldBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		textFieldBar.heightAnchor.constraint(equalToConstant: 56).isActive = true
		textFieldBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
	}
	
	func textFieldDidChange() {
		
		//	TO DO 
		
	}
	
	func handleMoreOptions() {
		
		//	TO DO
		
	}
	
	func handleSend() {
		
		//	TO DO
		
	}
	
	func handleSelectImage() {
		
		//	TO DO
		print("Select Image")
		
	}
	
	func handleStartWorkout() {
		
		let readyToRunVC = ReadyViewController()
		readyToRunVC.club = self.clubModel
		let readyNavBar = UINavigationController(rootViewController: readyToRunVC)
		self.navigationController?.present(readyNavBar, animated: true, completion: {
			
			//	TO DO
			
		})
	}
	
}
