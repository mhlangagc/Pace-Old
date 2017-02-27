//
//  ConversationViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
	
	var chatModel: ChatGroupModel?
	
	let chatMenuBar: ChatMenuBar = {
		
		let menuBar = ChatMenuBar()
		menuBar.translatesAutoresizingMaskIntoConstraints = false
		return menuBar
		
	}()
	
	private func setupChatenuBar() {
		
		view.addSubview(chatMenuBar)
		
		chatMenuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		chatMenuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		chatMenuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		chatMenuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		navigationItem.title = chatModel?.groupWorkout
		navigationNoLineBar()
		self.setupChatenuBar()
		
	}
	
	
	func handleSendingInvitation() {
		
		// TO DO
		print("Sending Invitation to Friend")
		
	}
	
}
