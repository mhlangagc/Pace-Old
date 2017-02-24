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
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		
		return 5
		
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		
		switch section {
			
		case 0:
			
			return (topSettingsArray?.count)!
			
		case 1:
			
			return (trainerJoinArray?.count)!
			
		case 2:
			
			return (middleSectionArray?.count)!
			
		case 3:
			
			return (bottomSectionArray?.count)!
			
		default:
			
			return 1
		}
		
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		
		let settingsCell = SettingsCell()
		
		switch indexPath.section {
			
		case 0:
			
			settingsCell.settingsModel = topSettingsArray?[indexPath.item]
			return settingsCell
			
		case 1:
			settingsCell.settingsModel = trainerJoinArray?[indexPath.item]
			return settingsCell
			
		case 2:
			
			settingsCell.settingsModel = middleSectionArray?[indexPath.item]
			return settingsCell
			
		case 3:
			
			settingsCell.settingsModel = bottomSectionArray?[indexPath.item]
			return settingsCell
			
		default:
			
			settingsCell.settingsModel = logoutArray?[indexPath.item]
			settingsCell.settingsTitle.layer.opacity = 0.3
			return settingsCell
		}
		
		
		
	}
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		
		switch indexPath.section {
			
		case 0:
			
			if indexPath.item == 0 {
				
				
				print("Edit Profile")
				
				
			} else if indexPath.item == 1 {
				
				
				print("Change Units")
				
			
			} else {
				
				print("Health Kit")
			
			}

			
		case 1:
			
			if indexPath.item == 0 {
				
				let mailComposeViewController = configuredMailComposeViewController()
				if MFMailComposeViewController.canSendMail() {
					
					self.present(mailComposeViewController, animated: true, completion: nil)
					
				} else {
					
					self.showSendMailErrorAlert()
					
				}
				
			}
			
		case 2:
			
			if indexPath.item == 0 {
				
				let mailComposeViewController = configuredFeedbackMailComposeViewController()
				if MFMailComposeViewController.canSendMail() {
					
					self.present(mailComposeViewController, animated: true, completion: nil)
					
				} else {
					
					self.showSendMailErrorAlert()
					
				}
				
			}
			
		case 3:
			
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

		
		tableNode.deselectRow(at: indexPath, animated: true)
		
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
