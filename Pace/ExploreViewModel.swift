//
//  DiscoveryViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ExploreViewModel : NSObject {
	
	func setupEvents() -> [EventModel] {
		
		let capeArgus = EventModel()
		capeArgus.eventName = "Cape Town Cycle Tour"
		capeArgus.eventDate = "Sunday, 12 March 2017"
		capeArgus.daysAway = "33 DAYS AWAY".uppercased()
		capeArgus.eventImage = UIImage(named: "4")
		
		
		return [capeArgus]
		
	}
	
	func suggestedTrainers() -> [UserModel] {
		
		let trainer_1 = UserModel()
		trainer_1.name = "Maria Sharapova"
		trainer_1.profileImage = UIImage(named: "maria")
		trainer_1.location = "Nyagan, Russia"
		trainer_1.trainerDescription = "Maria Yuryevna Sharapova is a Russian professional tennis player. A United States resident since 1994, Sharapova has competed on the WTA tour since 2001"
		
		let trainer_2 = UserModel()
		trainer_2.name = "Ell Marshall"
		trainer_2.profileImage = UIImage(named: "trainer")
		trainer_2.location = "Dorset, U.K"
		trainer_2.trainerDescription = "Lean Muscle Specialist"
		
		let trainer_3 = UserModel()
		trainer_3.name = "Mila George"
		trainer_3.profileImage = UIImage(named: "cynthia")
		trainer_3.location = "South Shawna, U.S"
		trainer_3.trainerDescription = "Physiotherapy, Pilates & Yoga Specialist"
		
		let trainer_4 = UserModel()
		trainer_4.name = "Justin Margolis"
		trainer_4.profileImage = UIImage(named: "justin")
		trainer_4.location = "South Carolina, U.S"
		trainer_4.trainerDescription = "X-Marine Specialising in Muscle Building and Endurance Training"
		
		
		
		return [trainer_1, trainer_2, trainer_3, trainer_4]
	}
}
