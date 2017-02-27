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
		group1.groupTrainerImage = UIImage(named: "2")
		group1.groupUsers = [(userCreation?.createLocalUser())!]
		
		
		
		
		return [group1]
	
	}
}
