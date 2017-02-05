//
//  GetPopupLauncher.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/27.
//  Copyright © 2016 Pace. All rights reserved.
//

import Foundation

class GetPopupLauncher : NSObject {
	
	let backgroundView : UIView = {
		
		let view = UIView()
		return view
		
	}()
	
	let blackView = UIView()
	var cancelButton : UIButton?
	var sundayButton : UIButton?
	var mondayButton : UIButton?
	var tuesdayButton : UIButton?
	var wednesdayButton : UIButton?
	var thursdayButton : UIButton?
	var fridayButton : UIButton?
	var saturdayButton : UIButton?
	
	override init() {
		super.init()
		
	}
	
	let addTo : UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
		return label
		
	}()
	
	func createButton(buttonLabel: String, buttonLabelColor: UIColor, buttonBackgroundColor: UIColor) -> UIButton {
		
		let button = UIButton()
		button.setTitle(buttonLabel, for: UIControlState.normal)
		button.setTitleColor(buttonLabelColor, for: UIControlState.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
		button.backgroundColor = buttonBackgroundColor
		return button
		
	}

	
	func showGetPopUp(currentView : UIView) {
		
		
		if let window = UIApplication.shared.keyWindow {
			
			//	Black View
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.85)
			blackView.frame = window.frame
			blackView.alpha = 0
			blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
			window.addSubview(blackView)
			
			//	Background View
			backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
			backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 550)
			
			self.savingButtons()
			
			window.addSubview(backgroundView)
			
			UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
				
				self.blackView.alpha = 1
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height - 550.0, width: window.frame.width, height: 550.0)
				
			}, completion: { (completed) in
				
				// TO DO - Analytics
				
			})
	
		}
	}
	
	func savingButtons() {
		
		//	Add To
		addTo.frame = CGRect(x: 0.0, y: 10.0, width: backgroundView.frame.width, height: 25.0)
		addTo.text = "Add workout to"
		addTo.textAlignment = .center
		backgroundView.addSubview(addTo)
		
		
		// Sunday
		sundayButton = createButton(buttonLabel: "Sunday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		sundayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		sundayButton?.frame = CGRect(x: 10.0, y: 58.0, width: backgroundView.frame.width - 20.0, height: 57.0)
		sundayButton?.roundedButton(corners: [.topLeft, .topRight], radius: 10)
		backgroundView.addSubview(sundayButton!)
		
		//	Monday
		mondayButton = createButton(buttonLabel: "Monday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		mondayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		mondayButton?.frame = CGRect(x: 10.0, y: 58.0 + 57.75, width: backgroundView.frame.width - 20.0, height: 57.0)
		backgroundView.addSubview(mondayButton!)
		
		//	Tuesday
		tuesdayButton = createButton(buttonLabel: "Tuesday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		tuesdayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		tuesdayButton?.frame = CGRect(x: 10.0, y: 58.0 + (57.75 * 2) , width: backgroundView.frame.width - 20.0, height: 57.0)
		backgroundView.addSubview(tuesdayButton!)
		
		
		//	Wednesday
		wednesdayButton = createButton(buttonLabel: "Wednesday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		wednesdayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		wednesdayButton?.frame = CGRect(x: 10.0, y: 58.0 + (57.75 * 3), width: backgroundView.frame.width - 20.0, height: 57.0)
		backgroundView.addSubview(wednesdayButton!)
		
		
		//	Thursday
		thursdayButton = createButton(buttonLabel: "Thursday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		thursdayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		thursdayButton?.frame = CGRect(x: 10.0, y: 58.0 + (57.75 * 4), width: backgroundView.frame.width - 20.0, height: 57.0)
		backgroundView.addSubview(thursdayButton!)
		
		//	Friday
		fridayButton = createButton(buttonLabel: "Friday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		fridayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		fridayButton?.frame = CGRect(x: 10.0, y: 58.0 + (57.75 * 5), width: backgroundView.frame.width - 20.0, height: 57.0)
		backgroundView.addSubview(fridayButton!)
		
		
		// Saturday
		saturdayButton = createButton(buttonLabel: "Saturday", buttonLabelColor: UIColor(fromHexString: "174339"), buttonBackgroundColor: UIColor.paceBrandColor())
		saturdayButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		saturdayButton?.frame = CGRect(x: 10.0, y: 58.0 + (57.75 * 6), width: backgroundView.frame.width - 20.0, height: 57.0)
		saturdayButton?.roundedButton(corners: [.bottomLeft, .bottomRight], radius: 10)
		backgroundView.addSubview(saturdayButton!)
		
		
		//	Cancel Button
		cancelButton = createButton(buttonLabel: "Cancel", buttonLabelColor: UIColor.paceBrandColor(), buttonBackgroundColor: UIColor.darkBlack())
		cancelButton?.addTarget(self, action: #selector(handleCancel), for: UIControlEvents.touchUpInside)
		cancelButton?.frame = CGRect(x: 10.0, y: backgroundView.frame.height - 67.0, width: backgroundView.frame.width - 20.0, height: 55.0)
		cancelButton?.layer.cornerRadius = 7.0
		cancelButton?.layer.masksToBounds = true
		cancelButton?.layer.masksToBounds = true
		backgroundView.addSubview(cancelButton!)

	}
	
	func handleCancel() {
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
			
			self.blackView.alpha = 0
			
			if let window = UIApplication.shared.keyWindow {
				
				self.backgroundView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 255.0)
				
			}
			
		}, completion: nil)
		
	}

}





