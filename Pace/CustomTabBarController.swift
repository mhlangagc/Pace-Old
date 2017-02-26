//
//  CustomTabBarController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/06/30.
//  Copyright © 2016 Canaan Studios. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import CoreData

class CustomTabBarController: ASTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViewControllers()
		
        self.tabBarSetup()
        
    }
    
    
    //  MARK: Setup Tab Bar
    func tabBarSetup() {
        
        tabBar.isTranslucent = false
        tabBar.shadowImage = nil
        tabBar.backgroundImage = nil
        
        UITabBar.appearance().barTintColor = UIColor.black
        tabBarController?.tabBar.clipsToBounds = true
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.paceBrandColor(), size: CGSize(width: tabBar.frame.width/3, height: tabBar.frame.height))
        UITabBar.appearance().tintColor = UIColor.paceBrandColor()
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.greyBlackColor()], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.paceBrandColor()], for: .selected)
		
        for i in 0..<Int((tabBar.items?.count)!) {
            
            let tabBarItem = (tabBar.items?[i])! as UITabBarItem
            
            // Adjust tab images
            tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0) // ***** UIEdgeInsetsMake(0, 0, 0, 0) ********** .
			
            var imageName = ""
            switch (i) {
				
				case 0:
					
					imageName = "home"
				
				case 1:
					
					imageName = "discovery"
				
				case 2:
				
					imageName = "chat"
				
				default: break
				
			}
            tabBarItem.image = UIImage(named:imageName)!.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage(named:imageName + "_Active")!.withRenderingMode(.alwaysOriginal)
        }
    }
	
    func setUpViewControllers() {
     
        //  My Routine
        let weekViewController = WeekViewController()
        let weekNavController = ASNavigationController(rootViewController: weekViewController)
        //weekNavController.tabBarItem.title = "My Routine"
        weekViewController.navigationController?.navigationBar.barStyle = .black
        weekViewController.extendedLayoutIncludesOpaqueBars = true
		
        //	Discovery
        let exploreViewController = ExploreViewController()
        let exploreNavController = ASNavigationController(rootViewController: exploreViewController)
		//exploreNavController.tabBarItem.title = "Explore"
		exploreViewController.navigationController?.navigationBar.barStyle = .black
        exploreViewController.extendedLayoutIncludesOpaqueBars = true
        
		//  Activity View Controller
//		let activityViewController = ActivityViewController()
//		let activityNavController = ASNavigationController(rootViewController: activityViewController)
//		activityNavController.tabBarItem.title = "Activity"
//		activityViewController.navigationController?.navigationBar.barStyle = .black
//		activityViewController.extendedLayoutIncludesOpaqueBars = true
		
		
        //  Profile
        let profileViewController = ChatViewController()
        let profileNavController = ASNavigationController(rootViewController: profileViewController)
		//profileNavController.tabBarItem.title = "Profile"
        profileViewController.navigationController?.navigationBar.barStyle = .black
        profileViewController.extendedLayoutIncludesOpaqueBars = true
		
        viewControllers = [weekNavController, exploreNavController, profileNavController ]
        
    }
    
    
}

//  Tab Bar Image
extension UIImage {
    
    func makeImageWithColorAndSize(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        //color.setFill()
        //UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
