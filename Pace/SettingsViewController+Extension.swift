//
//  SettingsViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/17.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit


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
			settingsCell.settingsTitle.layer.opacity = 0.5
			return settingsCell
		}
		
		
		
	}
	
	func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
		
		tableNode.deselectRow(at: indexPath, animated: true)
		
	}
	
}
