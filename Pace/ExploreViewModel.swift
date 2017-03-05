//
//  DiscoveryViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class ExploreViewModel : NSObject {
	
	func setupEvents() -> [EventModel] {
		
		let capeArgus = EventModel()
		capeArgus.eventName = "Cape Town Cycle Tour"
		capeArgus.eventDate = "Sunday, 12 March 2017"
		capeArgus.daysAway = "33 DAYS AWAY".uppercased()
		capeArgus.eventImage = UIImage(named: "4")
		
		return [capeArgus]
		
	}
	
}
