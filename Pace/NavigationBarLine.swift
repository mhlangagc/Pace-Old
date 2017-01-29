//
//  NavigationBarLine.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/23.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

extension UIViewController {
	
	public func failurePopup(mainMessage: String, detailedString: String) {
		
		let alertview = UIAlertController(title: mainMessage, message: detailedString, preferredStyle: .alert)
		alertview.addAction(UIAlertAction(title: "Ok", style: .default, handler:
			{ (alertAction) -> Void in
				
		}))
		
		present(alertview, animated: true, completion: nil)
	}
	
	public func navigationNoLineBar() {
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.barStyle = .black
		
	}
	
	public func navigationLineBar() {
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.barStyle = .black
		
		
	}
	
	
	public func hideNavBar() {
		
		self.navigationController?.navigationBar.isHidden = true
		
	}
	
	
	public func onboardingCounter(counterString: String) {
		
		let titleLabel = UILabel(frame: CGRect(x: view.frame.width, y: 30, width: view.frame.width, height: 25))
		titleLabel.text = counterString
		titleLabel.textAlignment = .right
		titleLabel.textColor = UIColor.greyWhite()
		titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
	}
	
	
}
