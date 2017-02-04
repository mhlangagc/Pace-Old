//
//  DiscoveryViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ExploreViewModel : NSObject {
	
	func setupWorkoutCatergory() -> [CatergoryModel] {
		
		let legsCatergory = CatergoryModel()
		legsCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.legs.rawValue)
		legsCatergory.catergoryImage = UIImage(named: "1")
		
		let buttCatergory = CatergoryModel()
		buttCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.butt.rawValue)
		buttCatergory.catergoryImage = UIImage(named: "2")
		
		let sevenMin = CatergoryModel()
		sevenMin.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.sevenmin.rawValue)
		sevenMin.catergoryImage = UIImage(named: "6")
		
		let cardioCatergory = CatergoryModel()
		cardioCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.cardio.rawValue)
		cardioCatergory.catergoryImage = UIImage(named: "4")
		
		let armsAndShoulderCatergory = CatergoryModel()
		armsAndShoulderCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.armsAndShoulders.rawValue)
		armsAndShoulderCatergory.catergoryImage = UIImage(named: "3")
		
		let mobilityCatergory = CatergoryModel()
		mobilityCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.mobility.rawValue)
		mobilityCatergory.catergoryImage = UIImage(named: "5")
		
		let recoveryCatergory = CatergoryModel()
		recoveryCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.recovery.rawValue)
		recoveryCatergory.catergoryImage = UIImage(named: "7")
		
		return [legsCatergory, buttCatergory, sevenMin, cardioCatergory, armsAndShoulderCatergory, mobilityCatergory, recoveryCatergory]
		
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
