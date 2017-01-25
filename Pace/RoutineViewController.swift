//
//  RoutineViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RoutineViewController : UIViewController{
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let goalsHeader : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "my routine"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let descriptionLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 3
		label.text = "Which days do you current exercise on, or would like to?"
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	
	let laterLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 3
		label.text = "You can always adjust this later."
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var doneButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Done", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleDone), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationNoLineBar()
		view.backgroundColor = UIColor.black
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleNothing))
		self.setupViews()
		
	}
	
	func setupViews() {
		
		view.addSubview(goalsHeader)
		view.addSubview(descriptionLabel)
		view.addSubview(laterLabel)
		view.addSubview(doneButton)
		
		goalsHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		goalsHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		goalsHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
		goalsHeader.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: goalsHeader.bottomAnchor, constant: 15).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true
		
		
		laterLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		laterLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		laterLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
		laterLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
		doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		doneButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handleDone() {
		
		self.present(CustomTabBarController(), animated: true) {
			
			//	TO DO
			
		}
		
	}
	
	
	func handleNothing() {
		
		//	 DO NOTHING
	}
	
}
