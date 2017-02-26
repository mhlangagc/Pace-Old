//
//  ProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit


extension ChatViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 120.0
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
		return 3
		
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var chatCell = tableView.dequeueReusableCell(withIdentifier: chatCellID) as? ChatCell
		
		if (chatCell == nil) {
			tableView.register(ChatCell.self, forCellReuseIdentifier: chatCellID)
			chatCell = tableView.dequeueReusableCell(withIdentifier: chatCellID) as? ChatCell
		}
		
		if (chatCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: chatCell!.frame.size.width, height: chatCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			chatCell!.selectedBackgroundView = backgroundView
		}
		
		chatCell?.backgroundColor = UIColor.black
		
		return chatCell!
		
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let conversationVC = ConversationViewController()
		conversationVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(conversationVC, animated: true)
		
		tableView.deselectRow(at: indexPath, animated: true)
	
	}
	

}

