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
		
		let editProfile = SettingsModel()
		editProfile.setting = "Edit Profile"
		editProfile.settingDetail = nil
		
		let units = SettingsModel()
		units.setting = "Units"
		units.settingDetail = "km/kg"
		
		let healthkit = SettingsModel()
		healthkit.setting = "Heathkit"
		healthkit.settingDetail = "connected"
		
		return [editProfile, units, healthkit]
	}
	
	func createJoinTheTrainers() -> [SettingsModel] {
		
		let joinTrainers = SettingsModel()
		joinTrainers.setting = "Login as a Trainer"
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
		
		return [sendUsFeedback, ratePace, inviteAFriend]
	}
	
	
	func createBottomSettings() -> [SettingsModel] {
		
		let aboutPace = SettingsModel()
		aboutPace.setting = "About Pace"
		aboutPace.settingDetail = nil
		
		let termsAndConditions = SettingsModel()
		termsAndConditions.setting = "Terms & Conditions"
		termsAndConditions.settingDetail = nil
		
		let privacyPolicy = SettingsModel()
		privacyPolicy.setting = "Privacy Policy"
		privacyPolicy.settingDetail = nil
		
		return [aboutPace, termsAndConditions, privacyPolicy]
	}
	
	func createLogout() -> [SettingsModel] {
		
		let logout = SettingsModel()
		logout.setting = "Logout"
		logout.settingDetail = nil
		
		return [logout]
	}
	
}
