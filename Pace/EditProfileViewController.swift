//
//  EditProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/18.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Edit Profile"
		view.backgroundColor = .black
		self.navigationBarItems()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Edit Profile"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	}

}
