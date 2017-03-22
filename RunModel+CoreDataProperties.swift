//
//  RunModel+CoreDataProperties.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation
import CoreData


extension RunModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RunModel> {
        return NSFetchRequest<RunModel>(entityName: "RunModel");
    }

    @NSManaged public var distance: Float
    @NSManaged public var duration: Int64
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var locations: NSOrderedSet?

}

