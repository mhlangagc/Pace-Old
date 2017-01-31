//
//  PaceAppServices.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/31.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PaceAppServices : NSObject {
	
	func retrieveUser() -> User {
		
		let user = User()
		
		if let userID = FIRAuth.auth()?.currentUser?.uid {
			
			FIRDatabase.database().reference().child("Users").child(userID).observe(FIRDataEventType.value, with: { (snapShot) in
				
				if let dictionary = snapShot.value as? [String: AnyObject] {
					
					user.name = dictionary["name"] as? String
					user.profileImageUrl = dictionary["profileImageUrl"] as? String
					user.location = dictionary["location"] as? String
					user.about = dictionary["about"] as? String
					
				}
				
			})
			
		}
		
		return user
		
	}
	
}
