//
//  EmptyDayViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/05.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Lottie

class EmptyDayViewController: UIViewController {
	
	var routineWorkoutModel : WorkoutDaysModel?
	var lottieAnimationView : LAAnimationView?
	
	let detailLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyWhite()
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	lazy var findAWorkoutButton : UIButton = {
		
		let button = UIButton()
		button.setTitle("Find a workout", for: UIControlState.normal)
		button.setTitleColor(selectedDayColour, for: UIControlState.normal)
		button.backgroundColor = UIColor.darkerBlack()
		button.layer.cornerRadius = 6.0
		button.layer.masksToBounds = true
		button.layer.borderColor = selectedDayColour.cgColor
		button.layer.borderWidth = 1.5
		button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		button.addTarget(self, action: #selector(handleFindAWorkout), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor.closeBlack()
		self.setupNavigationBar()
		self.addViews()
		self.lottieAnimationView?.play()
		
    }
	
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationItem.title = routineWorkoutModel?.dayName
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
	}
	
	func handlePlayAnimation() {
		
		if self.lottieAnimationView?.isAnimationPlaying == true {
			
			//	DO NOTHING
			
		} else {
			
			self.lottieAnimationView?.play()
		}
		
		
	}
	
	func addViews() {
		
		lottieAnimationView = LAAnimationView.animationNamed("\((routineWorkoutModel?.dayName)![0...0])")
		lottieAnimationView?.backgroundColor = UIColor.darkerBlack()
		lottieAnimationView?.isUserInteractionEnabled = true
		lottieAnimationView?.tintColor = selectedDayColour
		lottieAnimationView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePlayAnimation)))
		lottieAnimationView?.layer.cornerRadius = 70.0
		lottieAnimationView?.layer.masksToBounds = true
		lottieAnimationView?.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(lottieAnimationView!)
		
		
		detailLabel.text = "What will be your \((routineWorkoutModel?.dayName)!) \n workout?"
		view.addSubview(detailLabel)
		
		
		view.addSubview(findAWorkoutButton)
		
		detailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
		detailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		detailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
		detailLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
		
		lottieAnimationView?.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 60).isActive = true
		lottieAnimationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		lottieAnimationView?.heightAnchor.constraint(equalToConstant: 140).isActive = true
		lottieAnimationView?.widthAnchor.constraint(equalToConstant: 140).isActive = true
		
		findAWorkoutButton.topAnchor.constraint(equalTo: (lottieAnimationView?.bottomAnchor)!, constant: 50).isActive = true
		findAWorkoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 69).isActive = true
		findAWorkoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -68).isActive = true
		findAWorkoutButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
		
	}
	
	
	
	func handleFindAWorkout() {
		
		// TO DO
	
	}
	
	
}
