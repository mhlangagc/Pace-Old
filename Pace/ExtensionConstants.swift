//
//  ExtensionConstants.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/07/16.
//  Copyright © 2016 Canaan Studios. All rights reserved.
//

import UIKit
import Foundation

public let WINDOW = UIScreen.main.bounds

public let iPhoneVersion = (WINDOW.size.height == 568 ? 5 : (WINDOW.size.height == 480 ? 4 : (WINDOW.size.height == 667 ? 6 : (WINDOW.size.height == 736 ? 61 : 999))))
