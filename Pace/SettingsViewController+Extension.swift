//
//  SettingsViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import MessageUI
import SafariServices


extension SettingsViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
	
		return 4
	
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		switch section {
			
		case 0:
			
			return (trainerJoinArray?.count)!
			
		case 1:
			
			return (middleSectionArray?.count)!
			
		case 2:
			
			return (bottomSectionArray?.count)!
			
		default:
			
			return 1
		}
		
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var settingsCell = tableView.dequeueReusableCell(withIdentifier: settingsCellID) as? SettingsCellView
		
		if (settingsCell == nil) {
			tableView.register(SettingsCellView.self, forCellReuseIdentifier: settingsCellID)
			settingsCell = tableView.dequeueReusableCell(withIdentifier: settingsCellID) as? SettingsCellView
		}
		
		if (settingsCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: settingsCell!.frame.size.width, height: settingsCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			settingsCell!.selectedBackgroundView = backgroundView
		}
		
		
		switch indexPath.section {
			
		case 0:
			
			settingsCell?.settingsModel = trainerJoinArray?[indexPath.item]
			return settingsCell!
			
		case 1:
			
			settingsCell?.settingsModel = middleSectionArray?[indexPath.item]
			return settingsCell!
			
		case 2:
			
			settingsCell?.settingsModel = bottomSectionArray?[indexPath.item]
			return settingsCell!
			
		default:
			
			settingsCell?.settingsModel = logoutArray?[indexPath.item]
			settingsCell?.settingName.textColor = UIColor(fromHexString: "F71952")
			return settingsCell!
		}


		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		switch indexPath.section {
			
		case 0:
			
			print("Club Creation Methods Coming Soon")
			/*
			let createClubVC = CreateClubViewController()
			let navBarVC = UINavigationController(rootViewController: createClubVC)
			self.present(navBarVC, animated: true, completion: nil)
			*/
			
		case 1:
			
			if indexPath.item == 0 {
				
				let mailComposeViewController = configuredFeedbackMailComposeViewController()
				if MFMailComposeViewController.canSendMail() {
					
					self.present(mailComposeViewController, animated: true, completion: nil)
					
				} else {
					
					self.showSendMailErrorAlert()
					
				}

				
			}
			
		case 2:
			
			if indexPath.item == 0 {
				
				print("About Pace")
				
			} else {
				
				let svc = SFSafariViewController(url: NSURL(string: termsLink)! as URL)
				self.present(svc, animated: true, completion: nil)
				
			}
			
		default:
			
			if indexPath.item == 0 {
				
				let alertview = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
				alertview.addAction(UIAlertAction(title: "Yes", style: .default, handler:
					{ (alertAction) -> Void in
						
						self.handleLogout()
						
				}))
				
				alertview.addAction(UIAlertAction(title: "No", style: .destructive, handler:
					{ (alertAction) -> Void in
						
				}))
				
				present(alertview, animated: true, completion: nil)
				
			}
		}

		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 55
		
	}
	
	
	func handleLogout() {
		
		do {
			try FIRAuth.auth()?.signOut()
			
		} catch let logoutError {
			
			print(logoutError)
			
		}
	
		let welcomeVC = WelcomeLaunchViewController()
		welcomeVC.modalTransitionStyle = .flipHorizontal
		self.present(UINavigationController(rootViewController: welcomeVC), animated: true) {
			
			//	TO DO
			
		}
	}
	
}
