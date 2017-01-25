//
//  LocalUserViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/31.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class LocalUserViewModel : NSObject {
	
	func createLocalUser() -> UserModel {
		
		let user = UserModel()
		user.name = "Simon"
		user.profileImage = UIImage(named: "simon")
		user.location = "Cape Town, ZA"
		user.trainerDescription = "Getting ready for the gym and muscle carving"
		
		return user
	}
}
