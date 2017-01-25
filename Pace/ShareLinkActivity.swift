//
//  ShareLinkActivity.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/31.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension UIViewController {
	
	public func shareLinkVC(linkString : String) {
		
		let activityViewController = UIActivityViewController(activityItems: [linkString], applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view
		
		// Excluded
		activityViewController.excludedActivityTypes = [ UIActivityType.airDrop,
		                                                 UIActivityType.addToReadingList,
		                                                 UIActivityType.assignToContact,
		                                                 UIActivityType.copyToPasteboard,
		                                                 UIActivityType.openInIBooks,
		                                                 UIActivityType.saveToCameraRoll
		]
		
		self.present(activityViewController, animated: true, completion: nil)
	}
}
