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
	var profileViewController : ProfileViewController?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		self.runTimeDependencies()
		self.loadDataForViews()
		
		if FIRAuth.auth()?.currentUser?.uid == nil {
			
			self.window = UIWindow(frame: UIScreen.main.bounds)
			self.window?.rootViewController = UINavigationController(rootViewController: WelcomeLaunchViewController())
			self.window?.makeKeyAndVisible()
			self.window?.tintColor = UIColor.black
			
		} else {
			
			let items = [
				UIImageView(image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)),
				UIImageView(image: UIImage(named: "chat")?.withRenderingMode(.alwaysTemplate)),
				UIImageView(image: UIImage(named: "discovery")?.withRenderingMode(.alwaysTemplate))]
			
			let pageViewController = SLPagingViewController.init(navBarItems: items, navBarBackground: UIColor.black, controllers: [
				WorkoutsViewController(),
				ChatViewController(),
				DiscoverViewController()], showPageControl: false)
			
			UIApplication.shared.statusBarView?.backgroundColor = .black
			pageViewController?.setCurrentIndex(1, animated: true)
			pageViewController?.navigationSideItemsStyle = .onBounds
			
			pageViewController?.pagingViewMoving = ({ subviews in
				for v in subviews! {
					
					let lbl = v as! UIImageView
					var c = UIColor.darkBlack
					
					if (lbl.frame.origin.x > 45 && lbl.frame.origin.x < 145) {
						
						c = UIColor.darkBlack
						
					} else if (lbl.frame.origin.x > 145 && lbl.frame.origin.x < 245) {
						
						c = UIColor.paceBrandColor
					}
					else if(lbl.frame.origin.x == 145) {
						
						c = UIColor.paceBrandColor
					}
					
					lbl.tintColor = c()
				}
			})
			
			self.nav = UINavigationController(rootViewController: pageViewController!)
			self.window = UIWindow(frame: UIScreen.main.bounds)
			self.window?.rootViewController = self.nav
//			self.window = UIWindow(frame: UIScreen.main.bounds)
//			self.window?.rootViewController = CustomTabBarController()
			self.window?.makeKeyAndVisible()
			self.window?.tintColor = UIColor.black
			
			var preferredStatusBarStyle: UIStatusBarStyle {
				
				return UIStatusBarStyle.lightContent
				
			}
		
		}
		
		return true
	}
	
	func loadDataForViews() {
		
		//	Profile View Controller
		profileViewController = ProfileViewController()
		profileViewController?.retrieveUser()
		
	}
	
	func runTimeDependencies() {
		
		FIRApp.configure()
		Fabric.with([Crashlytics.self, STPAPIClient.self])
		
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

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

}

