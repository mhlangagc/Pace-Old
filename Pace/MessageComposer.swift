//
//  MessageComposer.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
	
	// A wrapper function to indicate whether or not a text message can be sent from the user's device
	func canSendText() -> Bool {
		
		return MFMessageComposeViewController.canSendText()
		
	}
	
	
	func configuredMessageComposeViewController() -> MFMessageComposeViewController {
		let messageComposeVC = MFMessageComposeViewController()
		messageComposeVC.messageComposeDelegate = self
//		messageComposeVC.recipients = textMessageRecipients
		messageComposeVC.body = "Join my Running Club on Pace! http://go.joinpace.fitness/CcEg/LM8E0WFf3B"
		return messageComposeVC
	}
	
	
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
	
		controller.dismiss(animated: true, completion: nil)
		
	}

}
