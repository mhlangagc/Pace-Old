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
}

class ClubModel: NSObject {
	
	var clubID : String?
	var name : String?
	var clubDescription: String?
	var backgroundImageUrl : String?
	var trainerID: String?
	var distance: Int?
	var totalRuns: Int?
	var paceMins: Int?
	var paceSeconds: Int?
	
}

class TeamMessagesModel: NSObject {
	
	var userSendingName: String?
	var userSendingImageURL: String?
	var imageURL: String?
	var userSending : String?
	var message: String?
	var timeStamp: Int?
	//var numberOfLikes: Int?
	
}


class RunsModel: NSObject {
	
	var userID : String?
	var userImageURL: String?
	var userName : String?
	var timeStamp: Int?
	var clubID : String?
	
	var distance: String?
	var mins: Int?
	var pace: String?
	var seconds : Int?
	
}


