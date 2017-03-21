//
//  WorkoutsModel+CoreDataProperties.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/21.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation
import CoreData


extension WorkoutsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutsModel> {
        return NSFetchRequest<WorkoutsModel>(entityName: "WorkoutsModel");
    }

    @NSManaged public var colour: String?
    @NSManaged public var dayName: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var number: Int64
    @NSManaged public var trainer: String?
    @NSManaged public var trainerImage: NSData?
    @NSManaged public var workoutImage: NSData?
    @NSManaged public var workoutName: String?
    @NSManaged public var exercises: NSSet?

}

