//
//  SettingsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
	
	var settingsTableView : UITableView?
	let settingsCellID = "settingsCellID"
	
	//var topSettingsArray : [SettingsModel]?
	var trainerJoinArray : [SettingsModel]?
	var middleSectionArray : [SettingsModel]?
	var bottomSectionArray : [SettingsModel]?
	var logoutArray : [SettingsModel]?
	
	
	lazy var profileSetup: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	lazy var SettingsSetup: SettingsViewModel = {
		
		let settingsSetup = SettingsViewModel()
		return settingsSetup
		
	}()
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		settingsTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.grouped)
		settingsTableView?.backgroundColor = UIColor.black
		settingsTableView?.delegate = self
		settingsTableView?.dataSource = self
		settingsTableView?.separatorStyle = .none
		settingsTableView?.showsVerticalScrollIndicator = false
		view.addSubview(settingsTableView!)
		
		//topSettingsArray = SettingsSetup.editProfile()
		trainerJoinArray = SettingsSetup.createClub()
		middleSectionArray = SettingsSetup.createMiddleSettings()
		bottomSectionArray = SettingsSetup.createBottomSettings()
		logoutArray = SettingsSetup.createLogout()
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsTableView?.register(SettingsCellView.self, forCellReuseIdentifier: settingsCellID)
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Settings"
		view.backgroundColor = .black
		self.navigationBarItems()
		self.setupWorkoutDetailsTableView()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Settings"
		navigationNoLineBar()
		self.navigationBarItems()
		self.settingsTableView?.reloadData()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Settings"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	}


	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
	
	func configuredMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		mailComposerVC.setToRecipients(["gugulethu@paceapp.fitness"])
		mailComposerVC.setSubject("Joining Pace as a Trainer")
		mailComposerVC.setMessageBody("Hi There, \n \n Because we are still new we are accepting trainers, to join via email. \n \n Compose your email here and we will be in touch in 30mins. ;) 🏋🏽🏊🏽‍♀️", isHTML: false)
		
		return mailComposerVC
		
	}
	
	func configuredFeedbackMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		mailComposerVC.setToRecipients(["gugulethu@paceapp.fitness"])
		mailComposerVC.setSubject("Some thoughts Pace...")
		mailComposerVC.setMessageBody("Hi There, \n \n We are new and would love to know all your thoughts, criticisms, ideas on improvement or just your workout story. \n \n Send us your feedback here and we will be in touch within 10mins tops ;). 🏊🏽‍♀️🏋🏽 \n \n", isHTML: false)
		
		return mailComposerVC
		
	}
	
	
	func showSendMailErrorAlert() {
		
		let alertController = UIAlertController(title: "Could not open mail!", message: "Please check your e-mail settings and try again.", preferredStyle: .alert)
		
		let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
			// ...
		}
		alertController.addAction(OKAction)
		
		self.present(alertController, animated: true) {
			// ...
		}
	}

	
}
