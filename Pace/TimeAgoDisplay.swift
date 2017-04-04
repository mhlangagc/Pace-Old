//
//  TimeAgoDisplay.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/04.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension Date {
	
	func timeAgoDisplay() -> String {
		
		let secondsAgo = Int(Date().timeIntervalSince(self))
		
		let minute = 60
		let hour = 60 * minute
		let day = 24 * hour
		let week = 7 * day
		
		if secondsAgo < minute {
			if secondsAgo == 1 {
				
				return "\(secondsAgo) second ago"
				
			}
			
			return "\(secondsAgo) seconds ago"
			
		} else if secondsAgo < hour {
			
			if (secondsAgo / minute) == 1 {
				
				return "\(secondsAgo / minute) minute ago"
				
			}
			return "\(secondsAgo / minute) minutes ago"
			
		} else if secondsAgo < day {
			
			if (secondsAgo / hour) == 1 {
				
				return "\(secondsAgo / hour) hour ago"
				
			}
			
			return "\(secondsAgo / hour) hours ago"
			
		} else if secondsAgo < week {
			
			if (secondsAgo / day) == 1 {
				
				return "\(secondsAgo / day) day ago"
				
			}
			
			return "\(secondsAgo / day) days ago"
			
		}
		
		if (secondsAgo/week) == 1 {
			
			return "\(secondsAgo / week) week ago"
			
		}
		return "\(secondsAgo / week) weeks ago"
		
	}
	
}
