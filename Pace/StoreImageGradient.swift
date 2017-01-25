//
//  StoreImageGradient.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/06/28.
//  Copyright © 2016 Canaan Studios. All rights reserved.
//

import Foundation
import UIKit

class StoreImageGradient: UIImageView
{
    let myGradientLayer: CAGradientLayer
    
    override init(frame: CGRect)
    {
        myGradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        myGradientLayer = CAGradientLayer()
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup()
    {
        myGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        myGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        let colors2 : [CGColor] = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor]
        let location2 = [0.0, 0.5, 1.0]
        
        myGradientLayer.colors = colors2
        myGradientLayer.isOpaque = false
        myGradientLayer.locations = location2 as [NSNumber]?
        self.layer.addSublayer(myGradientLayer)
    }
    
    override func layoutSubviews()
    {
        myGradientLayer.frame = self.layer.bounds
    }
}


