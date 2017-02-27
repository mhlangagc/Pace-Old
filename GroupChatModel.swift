//
//  GroupChatModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/30.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit


class ChatGroupModel: NSObject {
	
	var groupImage : UIImage?
	var groupWorkout: String?
	var groupUsers : [UserModel]?
	var groupTrainer: String?
	var groupTrainerImage: UIImage?
	var messages : [ChatMessageModel]?
	var numberOfMembers: String?
	
}

class ChatMessageModel: NSObject {
	
	var userSending : User?
	var message: String?
	var dateSent: String?
	
}
