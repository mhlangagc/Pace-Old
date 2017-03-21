//
//  LocationModel+CoreDataProperties.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation
import CoreData


extension LocationModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationModel> {
        return NSFetchRequest<LocationModel>(entityName: "LocationModel");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var run: RunModel?

}
