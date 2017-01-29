//
//  HealthKitManager.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/01/29.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import HealthKit

//  Identifiers
private let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
//private let activeEnergy = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
private let sleepAnalysis = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)
private let workoutType = HKObjectType.workoutType()




class HealthkitAccessAndManager: NSObject {
	
	let healthKitStore:HKHealthStore = HKHealthStore()
	var typesToRead: Set<HKObjectType>!
	let calendar = Calendar.current
	var now = NSDate() as Date
	var yesterday = NSDate() as Date
	var tommorrow = NSDate() as Date
	
	
	
	//	Health Kit Authorisation
	func authorizeHealthKitAcess(completion: ((_ success:Bool, _ error:NSError?) -> Void)!)
	{
		
		//  Types to Read
		if let sleepAnalysisToRead = sleepAnalysis, let stepsToRead = stepsCount {
			
			typesToRead = Set([sleepAnalysisToRead, stepsToRead, workoutType])
			
		}
		
		
		//  Types to Write to Healthkit
		//let typesToShare = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, HKQuantityType.workoutType())
		let typesToShare = Set(arrayLiteral: HKQuantityType.workoutType())
		
		
		//  Check for Error
		if !HKHealthStore.isHealthDataAvailable()
		{
			let error = NSError(domain: "fitness.paceapp.PaceFitness", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
			if( completion != nil )
			{
				print("Failed to Access HealthKit : \(error)")
				//completion(success:false, error:error)
			}
			return
		}
		
		
		//  Request HealthKit authorization
		healthKitStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) -> Void in
			
			if success == true {
				
				//  Use Accepted
				print("HealthKit Connected")
				
			} else {
				
				//  Use Denied
				print("Heathkit not connected - something went wrong")
				
			}
		}
		
	}
	
	
	
	override init() {
		super.init()
		
		//  Setup the View and Background
		yesterday = calendar.date(byAdding: .day, value: -1, to: NSDate() as Date)!
		tommorrow = calendar.date(byAdding: .day, value: 1, to: NSDate() as Date)!
		
	}
	
	
	//  Retrieve WorkoutType
	func retrieveActiveEnergyWorkOuts(completion: @escaping (_ activeEnergyRetrieved : [AnyObject]) -> Void) {
		
		let date = NSDate()
		let cal = Calendar(identifier: Calendar.Identifier.gregorian)
		let newDate = cal.startOfDay(for: date as Date)
		
		//  Set the Predicates
		let predicate = HKQuery.predicateForSamples(withStart: newDate as Date, end: NSDate() as Date, options: .strictStartDate)
		
		//  Order the workouts by date
		let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending: false)
		
		let query = HKSampleQuery(sampleType: HKSampleType.workoutType(), predicate: predicate, limit: 10, sortDescriptors: [sortDescriptor]) { (query, results, error) in
			
			if error != nil {
				
				//  Something Went wrong
				print("Something went wrong while retrieving the samples : \(error?.localizedDescription)")
				return
				
			}
			
			completion(results!)
			
		}
		
		// Execute the query
		healthKitStore.execute(query)
		
	}
	
	
	
	//  Retrieve Step Count
	func retrieveStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
		
		let date = NSDate()
		let cal = Calendar(identifier: Calendar.Identifier.gregorian)
		let newDate = cal.startOfDay(for: date as Date)
		
		//  Set the Predicates
		let predicate = HKQuery.predicateForSamples(withStart: newDate as Date, end: now, options: .strictStartDate)
		
		let interval: NSDateComponents = NSDateComponents()
		interval.day = 1
		
		//  Perform the Quesry
		let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval as DateComponents)
		
		query.initialResultsHandler = { query, results, error in
			
			if error != nil {
				
				//  Something went Wrong
				return
			}
			
			if let myResults = results{
				myResults.enumerateStatistics(from: self.yesterday as Date, to: self.now as Date) {
					statistics, stop in
					
					if let quantity = statistics.sumQuantity() {
						
						let steps = quantity.doubleValue(for: HKUnit.count())
						completion(steps)
						
					}
				}
			}
			
			
		}
		
		healthKitStore.execute(query)
		
	}
	
	
	
	//	Retrieve Sleep Analysis
	func retrieveSleepAnalysis (completion: @escaping (_ resultsRetrieved : [AnyObject]) -> Void) {
		
		//  Calculate the Sunset Time from the Previous Date
		let comps: NSDateComponents = calendar.dateComponents([.day, .month, .year], from: yesterday) as NSDateComponents
		comps.hour = 18 //  Set comps to 18:00 hrs.
		comps.minute = 0
		comps.second = 0
		let sunsetOfPreviousDate: NSDate = calendar.date(from: comps as DateComponents)! as NSDate
		
		
		//  Set the Predicates (from yesterdaySet to today)
		let predicate = HKQuery.predicateForSamples(withStart: sunsetOfPreviousDate as Date, end: NSDate() as Date, options: .strictStartDate)
		let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
		
		// we create our query with a block completion to execute
		let query = HKSampleQuery(sampleType: sleepAnalysis!, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, results, error) -> Void in
			
			if error != nil {
				
				// something went wrong
				return
				
			}
			
			//                    let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
			//
			//                    print("Healthkit sleep: \(value) : From \(sample.startDate) to \(sample.endDate) - source: \(sample.sourceRevision.source.name)")
			
			completion(results!)
		}
		
		// finally, we execute our query
		healthKitStore.execute(query)
		
	}
	
	
	//	Save Workout
	func saveWorkoutData(startDate: NSDate, endDate: NSDate, completion: ( (Bool, NSError?) -> Void)!) {
		
		// Provide summary information when creating the workout.
		let workout = HKWorkout(activityType: .mixedMetabolicCardioTraining, start: startDate as Date, end: endDate as Date, duration: abs(endDate.timeIntervalSince(startDate as Date)), totalEnergyBurned: nil, totalDistance: nil, metadata: nil)
		
		// Save the workout before adding detailed samples.
		
		healthKitStore.save(workout) { (success, error) -> Void in
			
			if (error != nil) {
				
				print("Workout Sucessfully saved")
				
			} else {
				
				print("Something went wrong while saving your workout: \(error)")
				
			}
			
			
		}
		
	}
	
	
	
}
