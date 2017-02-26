//
//  WeekDayViewModel.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/29.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import CoreData

class RoutinesViewModel : NSObject, NSFetchedResultsControllerDelegate {
	
	override init() {
		super.init()
		
		
	}
	
	
	let managedObjectContext : NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
	var _fetchedResultsController: NSFetchedResultsController<WorkoutsModel>? = nil
	
	var fetchedResultsController: NSFetchedResultsController<WorkoutsModel> {
		
		//  Ensure _fetchedResultsController is not nil
		if _fetchedResultsController != nil {
			return _fetchedResultsController!
		}
		
		//  Create the Fetch Request & how you want to sort the data.
		let fetchRequest: NSFetchRequest<WorkoutsModel> = WorkoutsModel.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		
		//  Create an NSFetchResultsController object
		let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		
		//  Delegate and return
		fetchedResultController.delegate = self
		_fetchedResultsController = fetchedResultController
		
		return  _fetchedResultsController!
		
		
	}

	
	func routinesCreation(completion: () ->()) {
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context = appDelegate.managedObjectContext
		let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: "WorkoutsModel", in: context)!
		
		//  ####    Sunday  - Create on Item for now.
		let sunday = WorkoutsModel(entity: entityDescription, insertInto: context)
		sunday.dayName = "Sunday"
		sunday.workoutName = "Sunday Abs & Obliques"
		sunday.isCompleted = false
		sunday.number = 1
		sunday.colour = "F71952"
		sunday.trainer = "Pace"
		sunday.workoutImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "1")!)!)
		sunday.trainerImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "logo")!)!)
		
		
		//  ####    Monday
		let monday = WorkoutsModel(entity: entityDescription, insertInto: context)
		monday.dayName = "Monday"
		monday.workoutName = "-"
		monday.isCompleted = false
		monday.number = 2
		monday.colour = "17D5FD"
		monday.trainer = "Pace"
		
		
		//  ####    Tuesday
		let tuesday = WorkoutsModel(entity: entityDescription, insertInto: context)
		tuesday.dayName = "Tuesday"
		tuesday.workoutName = "_"
		tuesday.isCompleted = false
		tuesday.number = 3
		tuesday.colour = "BB00FF"
		tuesday.trainer = "Pace"
		
		
		//  ####    Wednesday
		let wednesday = WorkoutsModel(entity: entityDescription, insertInto: context)
		wednesday.dayName = "Wednesday"
		wednesday.workoutName = "Cardio"
		wednesday.isCompleted = false
		wednesday.number = 4
		wednesday.colour = "FAB904"
		wednesday.trainer = "Pace"
		wednesday.workoutImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "4")!)!)
		wednesday.trainerImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "logo")!)!)
		
		
		//  ####    Thursday
		let thursday = WorkoutsModel(entity: entityDescription, insertInto: context)
		thursday.dayName = "Thursday"
		thursday.workoutName = "Legs & Abs"
		thursday.isCompleted = false
		thursday.number = 5
		thursday.colour = "50E3C2"
		thursday.trainer = "Pace"
		thursday.workoutImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "5")!)!)
		thursday.trainerImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "logo")!)!)
		
		
		//  ####    Friday
		let friday = WorkoutsModel(entity: entityDescription, insertInto: context)
		friday.dayName = "Friday"
		friday.workoutName = "-"
		friday.isCompleted = false
		friday.number = 6
		friday.colour = "607D8B"
		friday.trainer = "Pace"
		
		
		//  ####    Saturday
		let saturday = WorkoutsModel(entity: entityDescription, insertInto: context)
		saturday.dayName = "Saturday"
		saturday.workoutName = "-"
		saturday.isCompleted = false
		saturday.number = 7
		saturday.colour = "FF5E00"
		saturday.trainer = "Pace"
		
		
		//  Save the Created Items
		appDelegate.saveContext()
		
		
		completion()
		
	}
	
	func loadRoutineWorkouts() {
		
		do {
			
			try fetchedResultsController.performFetch()
			
		} catch {
			
			print("Error: \(error)")
			
			
		}
		
		
	}
	
	
	
	
}

