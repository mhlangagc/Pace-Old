//
//  ExercisesModel+CoreDataProperties.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import Foundation
import CoreData


extension ExercisesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExercisesModel> {
        return NSFetchRequest<ExercisesModel>(entityName: "ExercisesModel");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var distanceOrReps: Int64
    @NSManaged public var durationOrSets: Int64
    @NSManaged public var exerciseImage: NSData?
    @NSManaged public var exerciseName: String?
    @NSManaged public var exerciseTime: Int64
    @NSManaged public var exerciseType: String?
    @NSManaged public var exerciseVideoURL: String?
    @NSManaged public var weight: Int64
    @NSManaged public var workout: WorkoutsModel?

}
