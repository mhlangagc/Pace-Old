//
//  AuthenticationService.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/29.
//  Copyright © 2017 Pace. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AuthenticationService: NSObject {
	
	func createNewUser(emailCaptured: String, passwordCaptured: String, completion: @escaping (_ error: Error?) -> Void ) {
		
		FIRAuth.auth()?.createUser(withEmail: emailCaptured, password: passwordCaptured, completion: { (user: FIRUser?, error) in
			
			if error != nil {
				
				completion(error)
				return
			}
			
			guard let uid = user?.uid else {
				return
			}
			
			
			let values = [
				"name": "",
				"about" : "",
				"email": emailCaptured,
				"profileImageUrl": "",
				"location" : "",
				"isTrainer": "false"
			]
			
			FIRDatabase.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: { (err, ref) in
				
				if err != nil {
					completion(err)
					return
				}
				
				completion(nil)
				return
				
			})
			
		})
		
	}
	
	func updateFireBasewithName(nameCaptured: String, completion: @escaping (_ error: Error?) -> Void ) {
		
		guard let uid =  FIRAuth.auth()?.currentUser?.uid else {
			return
		}
		
		let values = [
			"name": nameCaptured
		]
		
		FIRDatabase.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
			
			if error != nil {
				
				completion(error)
				return
			}
			
			completion(nil)
			
		})
		
		
		
	}
	
	func signIn(userEmail: String, userPassword: String, completion: @escaping (_ error: Error?) -> Void) {
		
		FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword) { (user, error) in
			
			if error != nil {
				
				completion(error)
				return
			}
			
			//  Successfully Signed in
			completion(nil)
			
		}
		
	}

}


