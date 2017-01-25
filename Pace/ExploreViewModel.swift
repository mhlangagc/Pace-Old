//
//  DiscoveryViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ExploreViewModel : NSObject {
	
	func setupFeaturedWorkout() -> [ExploreModel] {
		
		let featured_1 = ExploreModel()
		featured_1.workoutName = "Stronger Legs"
		featured_1.workoutImage = UIImage(named: "fetured1")
		featured_1.trainerName = "Maria Sharapova"
		featured_1.trainerImage = UIImage(named: "maria")
		featured_1.rating = 5
		featured_1.numberOfReviews = 22
		featured_1.isDownloaded = false
		featured_1.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		featured_1.workoutTime = 55
		featured_1.workoutPrice = PriceEnum.fourDollars
		featured_1.workoutCatergory = WorkoutCatergory.legs
		
		
		let featured_2 = ExploreModel()
		featured_2.workoutName = "Legs & Bum day"
		featured_2.workoutImage = UIImage(named: "fetured2")
		featured_2.trainerName = "Ell Marshall"
		featured_2.trainerImage = UIImage(named: "trainer")
		featured_2.rating = 4
		featured_2.numberOfReviews = 5
		featured_2.isDownloaded = false
		featured_2.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		featured_2.workoutTime = 30
		featured_2.workoutPrice = PriceEnum.twoDollars
		featured_2.workoutCatergory = WorkoutCatergory.legs
		
		
		
		let featured_3 = ExploreModel()
		featured_3.workoutName = "Six Pack Abs"
		featured_3.workoutImage = UIImage(named: "fetured3")
		featured_3.trainerName = "Mila George"
		featured_3.trainerImage = UIImage(named: "cynthia")
		featured_3.rating = 4
		featured_3.numberOfReviews = 56
		featured_3.isDownloaded = false
		featured_3.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		featured_3.workoutTime = 7
		featured_3.workoutPrice = PriceEnum.threeDollars
		featured_3.workoutCatergory = WorkoutCatergory.sevenmin
		
		
		return [featured_1, featured_2, featured_3]
	}
	
	
	func setupNewToPaceWorkout() -> [ExploreModel] {
		
		let popular_1 = ExploreModel()
		popular_1.workoutName = "V Shape Upper Body"
		popular_1.workoutImage = UIImage(named: "popular1")
		popular_1.trainerName = "Maria Sharapova"
		popular_1.trainerImage = UIImage(named: "maria")
		popular_1.rating = 5
		popular_1.numberOfReviews = 22
		popular_1.isDownloaded = false
		popular_1.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_1.workoutTime = 55
		popular_1.workoutPrice = PriceEnum.oneDollars
		popular_1.workoutCatergory = WorkoutCatergory.armsAndShoulders
		
		
		let popular_2 = ExploreModel()
		popular_2.workoutName = "Get Big Arms"
		popular_2.workoutImage = UIImage(named: "popular2")
		popular_2.trainerName = "Justin Margolis"
		popular_2.trainerImage = UIImage(named: "justin")
		popular_2.rating = 4
		popular_2.numberOfReviews = 5
		popular_2.isDownloaded = false
		popular_2.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_2.workoutTime = 30
		popular_2.workoutPrice = PriceEnum.oneDollars
		popular_2.workoutCatergory = WorkoutCatergory.cardio
		
		let popular_3 = ExploreModel()
		popular_3.workoutName = "Belly Fat Blaster"
		popular_3.workoutImage = UIImage(named: "popular3")
		popular_3.trainerName = "Maria Sharapova"
		popular_3.trainerImage = UIImage(named: "maria")
		popular_3.rating = 5
		popular_3.numberOfReviews = 10
		popular_3.isDownloaded = false
		popular_3.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_3.workoutTime = 55
		popular_3.workoutPrice = PriceEnum.oneDollars
		popular_3.workoutCatergory = WorkoutCatergory.legs
		
		
		let popular_4 = ExploreModel()
		popular_4.workoutName = "Friday Shoulder, Chest & Back Gym"
		popular_4.workoutImage = UIImage(named: "popular4")
		popular_4.trainerName = "Mila George"
		popular_4.trainerImage = UIImage(named: "cynthia")
		popular_4.rating = 4
		popular_4.numberOfReviews = 5
		popular_4.isDownloaded = false
		popular_4.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_4.workoutTime = 7
		popular_4.workoutPrice = PriceEnum.oneDollars
		popular_4.workoutCatergory = WorkoutCatergory.recovery
		
		let popular_5 = ExploreModel()
		popular_5.workoutName = "Body Weight Workout"
		popular_5.workoutImage = UIImage(named: "popular5")
		popular_5.trainerName = "Maria Sharapova"
		popular_5.trainerImage = UIImage(named: "maria")
		popular_5.rating = 5
		popular_5.numberOfReviews = 22
		popular_5.isDownloaded = false
		popular_5.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_5.workoutTime = 45
		popular_5.workoutPrice = PriceEnum.oneDollars
		popular_5.workoutCatergory = WorkoutCatergory.mobility
		
		
		let popular_6 = ExploreModel()
		popular_6.workoutName = "Home Workout for Beginners"
		popular_6.workoutImage = UIImage(named: "popular6")
		popular_6.trainerName = "Ell Marshall"
		popular_6.trainerImage = UIImage(named: "trainer")
		popular_6.rating = 4
		popular_6.numberOfReviews = 5
		popular_6.isDownloaded = false
		popular_6.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		popular_6.workoutTime = 30
		popular_6.workoutPrice = PriceEnum.oneDollars
		popular_6.workoutCatergory = WorkoutCatergory.cardio
		
		return [popular_1, popular_2, popular_3, popular_4, popular_5, popular_6]
	}
	
	func setupNewWorkouts() -> [ExploreModel] {
		
		let new_1 = ExploreModel()
		new_1.workoutName = "Love Handles & Muffin top melter"
		new_1.workoutImage = UIImage(named: "new1")
		new_1.trainerName = "Maria Sharapova"
		new_1.trainerImage = UIImage(named: "maria")
		new_1.rating = 5
		new_1.numberOfReviews = 22
		new_1.isDownloaded = false
		new_1.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_1.workoutTime = 55
		new_1.workoutPrice = PriceEnum.oneDollars
		new_1.workoutCatergory = WorkoutCatergory.legs
		
		
		let new_2 = ExploreModel()
		new_2.workoutName = "Hardcore Butt Firming"
		new_2.workoutImage = UIImage(named: "new2")
		new_2.trainerName = "Justin Margolis"
		new_2.trainerImage = UIImage(named: "justin")
		new_2.rating = 4
		new_2.numberOfReviews = 5
		new_2.isDownloaded = false
		new_2.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_2.workoutTime = 30
		new_2.workoutPrice = PriceEnum.threeDollars
		new_2.workoutCatergory = WorkoutCatergory.cardio
		
		let new_3 = ExploreModel()
		new_3.workoutName = "Hitt that butt"
		new_3.workoutImage = UIImage(named: "new3")
		new_3.trainerName = "Maria Sharapova"
		new_3.trainerImage = UIImage(named: "maria")
		new_3.rating = 5
		new_3.numberOfReviews = 10
		new_3.isDownloaded = false
		new_3.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_3.workoutTime = 55
		new_3.workoutPrice = PriceEnum.nineDollars
		new_3.workoutCatergory = WorkoutCatergory.legs
		
		
		let new_4 = ExploreModel()
		new_4.workoutName = "Insanity Circuit Style"
		new_4.workoutImage = UIImage(named: "new4")
		new_4.trainerName = "Mila George"
		new_4.trainerImage = UIImage(named: "cynthia")
		new_4.rating = 4
		new_4.numberOfReviews = 5
		new_4.isDownloaded = false
		new_4.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_4.workoutTime = 7
		new_4.workoutPrice = PriceEnum.eightDollars
		new_4.workoutCatergory = WorkoutCatergory.sevenmin
		
		let new_5 = ExploreModel()
		new_5.workoutName = "Wednesday Abs & Obliques"
		new_5.workoutImage = UIImage(named: "new5")
		new_5.trainerName = "Maria Sharapova"
		new_5.trainerImage = UIImage(named: "maria")
		new_5.rating = 5
		new_5.numberOfReviews = 22
		new_5.isDownloaded = false
		new_5.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_5.workoutTime = 45
		new_5.workoutPrice = PriceEnum.oneDollars
		new_5.workoutCatergory = WorkoutCatergory.legs
		
		
		let new_6 = ExploreModel()
		new_6.workoutName = "Arms toned for summer"
		new_6.workoutImage = UIImage(named: "new6")
		new_6.trainerName = "Ell Marshall"
		new_6.trainerImage = UIImage(named: "trainer")
		new_6.rating = 4
		new_6.numberOfReviews = 5
		new_6.isDownloaded = false
		new_6.workoutDescription = "If you are looking to get toned and enjoy fast paced interval training to shed fat - this workout is for you."
		new_6.workoutTime = 30
		new_6.workoutPrice = PriceEnum.twoDollars
		new_6.workoutCatergory = WorkoutCatergory.butt
		
		return [new_1, new_2, new_3, new_4, new_5, new_6]
	}
	
	func setupWorkoutCatergory() -> [CatergoryModel] {
		
		let legsCatergory = CatergoryModel()
		legsCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.legs.rawValue)
		legsCatergory.catergoryImage = UIImage(named: "legs")
		
		let buttCatergory = CatergoryModel()
		buttCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.butt.rawValue)
		buttCatergory.catergoryImage = UIImage(named: "butt")
		
		let sevenMin = CatergoryModel()
		sevenMin.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.sevenmin.rawValue)
		sevenMin.catergoryImage = UIImage(named: "sevenMinute")
		
		let cardioCatergory = CatergoryModel()
		cardioCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.cardio.rawValue)
		cardioCatergory.catergoryImage = UIImage(named: "cardio")
		
		let armsAndShoulderCatergory = CatergoryModel()
		armsAndShoulderCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.armsAndShoulders.rawValue)
		armsAndShoulderCatergory.catergoryImage = UIImage(named: "armsShoulder")
		
		let mobilityCatergory = CatergoryModel()
		mobilityCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.mobility.rawValue)
		mobilityCatergory.catergoryImage = UIImage(named: "Mobility")
		
		let recoveryCatergory = CatergoryModel()
		recoveryCatergory.catergoryName = WorkoutCatergory(rawValue: WorkoutCatergory.recovery.rawValue)
		recoveryCatergory.catergoryImage = UIImage(named: "recovery")
		
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
