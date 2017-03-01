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
	var messages : [CommunityMessagesModel]?
	var numberOfMembers: String?
	
}

class CommunityMessagesModel: NSObject {
	
	var userSending : String?
	var message: String?
	var dateSent: String?
	var numberOfLikes: Int?
	
}
