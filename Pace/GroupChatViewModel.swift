//
//  GroupChatModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/27.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class CommunityMessagesViewModel : NSObject {
	
	func createMessages() -> [CommunityMessagesModel] {
		
		let message1 = CommunityMessagesModel()
		message1.message = "Totally Love this app"
		message1.userSending = "Cynthia"
		message1.numberOfLikes = 85
		
		
		let message2 = CommunityMessagesModel()
		message2.message = "Hey gang, we are working on on organising an event for all our members at GreenPoint. show by a like if you would be interesting in attending the event."
		message2.userSending = "Thomas"
		message2.numberOfLikes = 290
		
		
		
		return [message1, message2]
		
	}

	
}
