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
		group1.groupWorkout = "Bigger Chest Workout"
		group1.groupImage = UIImage(named: "2")
		group1.groupTrainer = "Pace"
		group1.groupTrainerImage = UIImage(named: "logo")
			
		let group2 = ChatGroupModel()
		group2.groupWorkout = "Cardio"
		group2.groupImage = UIImage(named: "5")
		group2.groupTrainer = "Letty"
		group2.groupTrainerImage = UIImage(named: "logo")
		
		
		return [group1, group2]
	
	}
}
