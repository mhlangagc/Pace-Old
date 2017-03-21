//
//  RunModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation

class RunModel: NSObject {
	
	var duration: NSNumber?
	var distance: NSNumber?
	var timestamp: NSDate?
	var locations: NSOrderedSet?
	
}

class LocationModel: NSObject {
	
	var timestamp: NSDate?
	var latitude: NSNumber?
	var longitude: NSNumber?
	var run: RunModel?
	
}
