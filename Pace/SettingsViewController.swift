//
//  SettingsViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import MessageUI
import SafariServices

class SettingsViewController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource, MFMailComposeViewControllerDelegate {
	
	var settingsTableNode : ASTableNode?
	
	var topSettingsArray : [SettingsModel]?
	var trainerJoinArray : [SettingsModel]?
	var middleSectionArray : [SettingsModel]?
	var bottomSectionArray : [SettingsModel]?
	var logoutArray : [SettingsModel]?
	
	lazy var SettingsSetup: SettingsViewModel = {
		
		let settingsSetup = SettingsViewModel()
		return settingsSetup
		
	}()
	
	init() {
		
		settingsTableNode = ASTableNode(style:.grouped)
		super.init(node: settingsTableNode!)
		
		self.setupSettingsNode()
		
		topSettingsArray = SettingsSetup.createTopSettings()
		trainerJoinArray = SettingsSetup.createJoinTheTrainers()
		middleSectionArray = SettingsSetup.createMiddleSettings()
		bottomSectionArray = SettingsSetup.createBottomSettings()
		logoutArray = SettingsSetup.createLogout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.isHidden = false
		navigationLineBar()
		self.navigationItem.title = "Settings"
		view.backgroundColor = .black
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Settings"
		navigationNoLineBar()
		
	}

	func setupSettingsNode() {
		
		self.settingsTableNode?.delegate = self
		self.settingsTableNode?.dataSource = self
		self.settingsTableNode?.backgroundColor = UIColor.black
		self.settingsTableNode?.view.separatorStyle = .none
		self.settingsTableNode?.view.showsVerticalScrollIndicator = false
		
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
