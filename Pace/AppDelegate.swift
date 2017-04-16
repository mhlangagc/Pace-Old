//
//  AppDelegate.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Fabric
import Branch
import Stripe
import Crashlytics
import CoreData
import Firebase
import SLPagingView

let appStoreLinkToDownload: NSURL = NSURL(string: "https://itunes.apple.com/us/app/pace-ultimate-fitness-organising/id1107980760?ls=1&mt=8")!
let termsLink : String = "http://mhlangagc.wixsite.com/pace/terms-of-use"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var nav : UINavigationController?
	
	lazy var paceAppService: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		self.runTimeDependencies()
		
		if FIRAuth.auth()?.currentUser?.uid == nil {
			
			self.window = UIWindow(frame: UIScreen.main.bounds)
			self.window?.rootViewController = UINavigationController(rootViewController: WelcomeLaunchViewController())
			self.window?.makeKeyAndVisible()
			self.window?.tintColor = UIColor.black
			
		} else {
			
			self.loadDataForViews()
			
			Branch.getInstance().initSession(launchOptions: launchOptions, automaticallyDisplayDeepLinkController: true, deepLinkHandler: { params, error in
				if error == nil {
				
					// params are the deep linked params associated with the link that the user clicked -> was re-directed to this app
					// params will be empty if no data found
					// ... insert custom logic here ...
					print("params: %@", (params?.description)!)
				
				}
				
			})


			
			self.window = UIWindow(frame: UIScreen.main.bounds)
			self.window?.rootViewController = CustomTabBarController()
			self.window?.makeKeyAndVisible()
			self.window?.tintColor = UIColor.black
			
			var preferredStatusBarStyle: UIStatusBarStyle {
				
				return UIStatusBarStyle.lightContent
				
			}
		
		}
		
		let barAppearace = UIBarButtonItem.appearance()
		barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
		
		return true
	}
	
	func loadDataForViews() {
		
		paceAppService.retrieveUser { (userFound) in
			//	Do nothing for now
		}
		
		paceAppService.retrieveUserDownloadedWorkouts { (workoutTeamsArray) in
			
		}
		
	}
	
	func runTimeDependencies() {
		
		FIRApp.configure()
		Fabric.with([Crashlytics.self, STPAPIClient.self, Branch.self])
		
		
	}
	
	// Respond to URI scheme links
	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		
		// For Branch to detect when a URI scheme is clicked
		Branch.getInstance().handleDeepLink(url)
		
		// do other deep link routing for the Facebook SDK, Pinterest SDK, etc
		
		return true
	
	}
	
	// Respond to Universal Links
	private func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: @escaping ([AnyObject]?) -> Void) -> Bool {
		
		// For Branch to detect when a Universal Link is clicked
		Branch.getInstance().continue(userActivity)
		return true
	
	}


	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
	}

	// MARK: - Core Data stack
	lazy var applicationDocumentsDirectory: URL = {
		// The directory the application uses to store the Core Data store file. This code uses a directory named "fitness.paceapp.Pace" in the application's documents Application Support directory.
		let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
		return urls[urls.count-1]
	}()
	
	
	lazy var managedObjectModel: NSManagedObjectModel = {
		// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
		let modelURL = Bundle.main.url(forResource: "Pace", withExtension: "momd")!
		return NSManagedObjectModel(contentsOf: modelURL)!
	}()
	
	
	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "Pace")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()
	
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		// The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
		// Create the coordinator and store
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
		} catch {
			// Report any error we got.
			var dict = [String: AnyObject]()
			dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
			dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
			
			dict[NSUnderlyingErrorKey] = error as NSError
			let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
			// Replace this with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
			abort()
		}
		
		return coordinator
	}()

	
	lazy var managedObjectContext: NSManagedObjectContext = {
		// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
		let coordinator = self.persistentStoreCoordinator
		var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator
		return managedObjectContext
	}()

	
	// MARK: - Core Data Saving support

	func saveContext () {
		
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
				abort()
			}
		}

	}

}

