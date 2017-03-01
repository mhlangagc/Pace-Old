//
//  GroupChatModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/27.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class GroupChatViewModel : NSObject {
	
	var userCreation : LocalUserViewModel?
	
	func createChatGroups() -> [ChatGroupModel] {

		let group1 = ChatGroupModel()
		group1.groupWorkout = "Bigger Chest & Core"
		group1.groupImage = UIImage(named: "2")
		group1.groupTrainer = "Pace"
		group1.groupTrainerImage = UIImage(named: "logo")
		group1.numberOfMembers = "\(450)"
			
		let group2 = ChatGroupModel()
		group2.groupWorkout = "Cardio for Muscle Build"
		group2.groupImage = UIImage(named: "5")
		group2.groupTrainer = "Letty"
		group2.groupTrainerImage = UIImage(named: "logo")
		group2.numberOfMembers = "\(97)"
		
		
		let group3 = ChatGroupModel()
		group3.groupWorkout = "Cardio for Runners"
		group3.groupImage = UIImage(named: "7")
		group3.groupTrainer = "Pace"
		group3.groupTrainerImage = UIImage(named: "logo")
		group3.numberOfMembers = "\(3.5)k"
		
		
		let group4 = ChatGroupModel()
		group4.groupWorkout = "Legs & Butt"
		group4.groupImage = UIImage(named: "1")
		group4.groupTrainer = "Pace"
		group4.groupTrainerImage = UIImage(named: "logo")
		group4.numberOfMembers = "\(9.1)k"
		
		
		return [group1, group2, group3, group4]
	
	}
	
}

class CommunityMessagesViewModel : NSObject {
	
	func createMessages() -> [CommunityMessagesModel] {
		
		let message1 = CommunityMessagesModel()
		message1.message = "Totally Love this app"
		message1.userSending?.name = "Cynthia"
		message1.numberOfLikes = 85
		
		
		let message2 = CommunityMessagesModel()
		message2.message = "Hey gang, we are working on on organising an event for all our members at GreenPoint. show by a like if you would be interesting in attending the event."
		message2.userSending?.name = "Thomas"
		message2.numberOfLikes = 290
		
		
		
		return [message1, message2]
		
	}

	
}
