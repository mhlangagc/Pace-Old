//
//  CreateClubViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class CreateClubViewController : UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.paceBackgroundBlack()
		self.setupNavBar()
		
	}
	
	func setupNavBar() {
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.tintColor = UIColor.paceBrandColor()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBrandColor()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShowPreview))
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleCancel))
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func handleShowPreview() {
		
		//	TO DO
		
	}
	
	func handleCancel() {
		
		self.dismiss(animated: true) { 
			
			// TO Do - Track who is dismissing what. 
			
		}
	}
}
