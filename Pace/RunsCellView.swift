//
//  RunsCellView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class RunsCellView : TableBaseCell {
	
	let runsImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 8.0
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	
	let runDate: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "C9D5EB")
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	
	let runDayName: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "C9D5EB")
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let runDetails: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor(fromHexString: "454E5C")
		label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightSemibold)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	var  runsModel : RunsModel? {
		
		didSet {
			
			if let distanceRan = runsModel?.distance, let pace = runsModel?.pace, let mins = runsModel?.mins, let seconds = runsModel?.seconds, let timeOfRun = runsModel?.timeStamp {
				
				
				let date = NSCalendar.current.component(.day, from: Date(timeIntervalSince1970: Double(timeOfRun)))
				let formatter  = DateFormatter()
				formatter.dateFormat = "MMM"
				let month = formatter.string(from: Date(timeIntervalSince1970: Double(timeOfRun)))
				
				runDate.text = "\(date) \(month)"
				runDetails.text = "\(distanceRan)km    \(pace)/km    \(mins):\(seconds)"
				runDayName.text = self.timeOfRun(timeStamp: timeOfRun)
			
			}
			
		}
		
	}
	
	func timeOfRun(timeStamp: Int) -> String? {
		
		let hour = NSCalendar.current.component(.hour, from: Date(timeIntervalSince1970: Double(timeStamp)))
		let formatter  = DateFormatter()
		formatter.dateFormat = "EEEE"
		let day = formatter.string(from: Date(timeIntervalSince1970: Double(timeStamp)))
		
		switch hour {
			
		case 6..<12 :
			
			return "\(day) Morning Run"
		
		case 12..<17 :
			
			return "\(day) Afternoon Run"
		
		case 17..<22 :
			
			return "\(day) Evening Run"
			
		default:
		
			return "\(day) Late Night Run"
		
		}
		
	}

	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupView()
		
	}

	func setupView() {
		
		self.contentView.addSubview(runsImage)
		self.contentView.addSubview(runDate)
		self.contentView.addSubview(runDayName)
		self.contentView.addSubview(runDetails)
		
		runsImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
		runsImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		runsImage.widthAnchor.constraint(equalToConstant: 95.0).isActive = true
		runsImage.heightAnchor.constraint(equalToConstant: 95.0).isActive = true
		
		
		runDate.leftAnchor.constraint(equalTo: runsImage.rightAnchor, constant: 15.0).isActive = true
		runDate.topAnchor.constraint(equalTo: topAnchor, constant: 25.0).isActive = true
		runDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
		runDate.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		runDayName.leftAnchor.constraint(equalTo: runsImage.rightAnchor, constant: 15.0).isActive = true
		runDayName.topAnchor.constraint(equalTo: runDate.bottomAnchor, constant: 8.0).isActive = true
		runDayName.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
		runDayName.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
		
		runDetails.leftAnchor.constraint(equalTo: runsImage.rightAnchor, constant: 15.0).isActive = true
		runDetails.topAnchor.constraint(equalTo: runDayName.bottomAnchor, constant: 10.0).isActive = true
		runDetails.rightAnchor.constraint(equalTo:  rightAnchor, constant: -8.0).isActive = true
		runDetails.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		
		
	}
	
}

