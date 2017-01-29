//
//  AuthenticationService.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/29.
//  Copyright © 2017 Pace. All rights reserved.
//

/*
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AuthenticationService {
	
	func handleSignupWithDetails(emailCaptured: String, passwordCaptured: String, completion: @escaping (_ error: Error?) -> Void) {
		
		if emailCaptured.isEmpty {
			completion(AuthenticationError.usernameInputError)
			return
		}
		
		if passwordCaptured.isEmpty {
			completion(AuthenticationError.passwordInputError)
			return
		}
		
		FIRAuth.auth()?.createUser(withEmail: emailCaptured, password: passwordCaptured, completion: { (user: FIRUser?, error) in
			
			if error != nil {
				
				self.failurePopup(mainMessage: "Something's being a doozy", detailedString: (error?.localizedDescription)!)
				
				self.stopProcessingSignUp()
				
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
					
					self.failurePopup(mainMessage: "Something's being a doozy", detailedString: (error?.localizedDescription)!)
					
					//self.stopProcessingSignUp()
					
					return
				}
				
				
				
			})
			
			
			//  Send Verification Email
			user?.sendEmailVerification() { error in
				
				if error != nil {
					
					print("An Error occured \(error?.localizedDescription)")
					
					self.failurePopup(mainMessage: "Something's being a doozy", detailedString: (error?.localizedDescription)!)
					
					
				} else {
					
					
					//  Stop the Spinnder herere
					//  Navigate to Name View Controller
					print("Email Sent")
					
					//self.processingView?.stopAnimating()
					
					UIView.animate(withDuration: 0.2) {
						
						self.nextButton.alpha = 1.0
						self.showButton?.alpha = 1.0
						self.createPasswordLabel.alpha = 1.0
						self.passwordTextField.alpha = 1.0
						
					}
					
					self.navigationController?.pushViewController(NameViewController(), animated: true)
					
				}
				
			}
			
			
		})
		
		
	}
	
	func createUser(email: String, password: String, completion: @escaping (_ error: Error?) -> Void){
		if email.isEmpty {
			completion(AuthenticationError.usernameInputError)
			return
		}
		
		if password.isEmpty {
			completion(AuthenticationError.passwordInputError)
			return
		}
		
		
		Auth0
			.authentication()
			.signUp(
				email: email,
				password: password,
				connection: databaseConnection
			)
			.start { result in
				switch result {
				case .success(let credentials):
					let newUser = User()
					newUser.email = email
					newUser.password = password
					newUser.token = credentials.idToken
					self.loggedInUser = newUser
					completion(nil)
					return
				case .failure(let error):
					dump(error)
					completion(error)
					return
				}
		}
	}
	
}

*/
