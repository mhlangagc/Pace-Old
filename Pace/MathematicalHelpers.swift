
//
//  MathematicalHelpers.swift
//  Keep Up
//
//  Created by Gugulethu Mhlanga on 2015/12/18.
//  Copyright © 2015 Canaan Studios. All rights reserved.
//

import Foundation
import UIKit


public func randomIntergerInRange(_ low:Int, high:Int) -> Int {
    
    if (iPhoneVersion < 5) {
        
        
        let randomGeneratedNumber = UInt(low) + UInt(arc4random()) % (UInt(high) - UInt(low))
        return Int(randomGeneratedNumber)
        
    }   else if (iPhoneVersion == 5)  {
        
        
        let randomGeneratedNumber = UInt(low) + UInt(arc4random()) % (UInt(high) - UInt(low))
        return Int(randomGeneratedNumber)
    
    } else if (iPhoneVersion == 6) {
       
        let randomGeneratedNumber = UInt64(low) + UInt64(arc4random()) % (UInt64(high) - UInt64(low))
        return Int(randomGeneratedNumber)

       
    } else {
        
        let randomGeneratedNumber = low + Int(arc4random()) % (high - low);
        return Int(randomGeneratedNumber)

    }

    
    
}

public func randomInRange(_ low:CGFloat, high:CGFloat) -> CGFloat {
        let randomGeneratedNumber = low + CGFloat(arc4random()).truncatingRemainder(dividingBy: (high - low));
        return CGFloat(randomGeneratedNumber)
}

//Rounding off a Double.
/*
extension Double {
    
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
    
}
 */

//MARK : Kg to Pound Conversion
public func kgToPound(_ kgValue: Double) -> Double {
    
    return Double(2.20462 * kgValue)
}

public func poundToKg(_ poundValue: Double) -> Double {
    
    return Double(poundValue/2.20462)
}

//MARK : Km to Mile Conversion
public func kmToMile(_ kmValue: Double) -> Double {
    
    return Double(0.621371 * kmValue)
}

public func mileToKm(_ mileValue: Double) -> Double {
    
    return Double(mileValue/0.621371)
}


extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

