//
//  GoalsInterestsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class GoalsInterestsViewController : UIViewController{
	
	override var prefersStatusBarHidden: Bool {
		
		return true
		
	}
	
	let goalsHeader : UILabel = {
		
		let label = UILabel()
		label.textColor = .white
		label.text = "goals & interests"
		label.font = UIFont(name: "BebasNeueBold", size: 21)
		textSpacing(label, spacing: 4.1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let descriptionLabel : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 3
		label.text = "What are your workout goals and fitness interests (present & future)."
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	lazy var pickGoalsButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("pick 3 more", for: UIControlState.normal)
		button.setTitleColor(UIColor.black, for: UIControlState.normal)
		button.backgroundColor = UIColor.white
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.isEnabled = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handlePickGoals), for: UIControlEvents.touchUpInside)
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
		view.addSubview(pickGoalsButton)
		
		goalsHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		goalsHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		goalsHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		goalsHeader.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		
		descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
		descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
		descriptionLabel.topAnchor.constraint(equalTo: goalsHeader.bottomAnchor, constant: 15).isActive = true
		descriptionLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		
		pickGoalsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		pickGoalsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		pickGoalsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
		pickGoalsButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		
	}
	
	
	func handlePickGoals() {
		
		self.navigationController?.pushViewController(RoutineViewController(), animated: true)
		
	}
	
	func handleNothing() {
		
		//	 do nothing 
	}
	
}
