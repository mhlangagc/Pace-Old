//
//  GroupChatModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/30.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit


class TeamsModel: NSObject {
	
	var workoutID : String?
	var workoutName : String?
	var backgroundImageUrl : String?
	var trainerID: String?
	var teamMessages: NSSet?
	var teamMembers: NSSet?
	var workoutExercises: NSSet?
}

class TeamMessagesModel: NSObject {
	
	var imageURL: String?
	var userSending : String?
	var message: String?
	var timeStamp: Int?
	//var numberOfLikes: Int?
	
}
