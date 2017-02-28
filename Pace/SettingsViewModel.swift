//
//  SettingsViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/31.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class SettingsViewModel : NSObject {
	
	func createTopSettings() -> [SettingsModel] {
		
		let units = SettingsModel()
		units.setting = "Units"
		units.settingDetail = "km/kg"
		
		let healthkit = SettingsModel()
		healthkit.setting = "Healthkit"
		healthkit.settingDetail = "connected"
		
		return [units, healthkit]
	}
	
	func createJoinTheTrainers() -> [SettingsModel] {
		
		let joinTrainers = SettingsModel()
		joinTrainers.setting = "Upload your Workout"
		joinTrainers.settingDetail = nil
		
		return [joinTrainers]
	}
	
	func createMiddleSettings() -> [SettingsModel] {
		
		let sendUsFeedback = SettingsModel()
		sendUsFeedback.setting = "Send us Feedback"
		sendUsFeedback.settingDetail = nil
		
		let ratePace = SettingsModel()
		ratePace.setting = "Rate Pace"
		ratePace.settingDetail = nil
		
		let inviteAFriend = SettingsModel()
		inviteAFriend.setting = "Invite a Friend"
		inviteAFriend.settingDetail = nil
		
		return [sendUsFeedback]
	}
	
	
	func createBottomSettings() -> [SettingsModel] {
		
		let aboutPace = SettingsModel()
		aboutPace.setting = "About Pace"
		aboutPace.settingDetail = nil
		
		let termsAndConditions = SettingsModel()
		termsAndConditions.setting = "Our Terms"
		termsAndConditions.settingDetail = nil
		
		return [aboutPace, termsAndConditions]
	}
	
	func createLogout() -> [SettingsModel] {
		
		let logout = SettingsModel()
		logout.setting = "Logout"
		logout.settingDetail = nil
		
		return [logout]
	}
	
}
