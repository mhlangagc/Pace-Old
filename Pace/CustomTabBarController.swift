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
        
        UITabBar.appearance().barTintColor = UIColor.paceBackgroundBlack()
        tabBarController?.tabBar.clipsToBounds = true
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.greyWhite(), size: CGSize(width: tabBar.frame.width/3, height: tabBar.frame.height))
        UITabBar.appearance().tintColor = UIColor.greyWhite()
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.greyBlackColor()], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.greyWhite()], for: .selected)
		
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
				
					imageName = "profile-female"
				
				default: break
				
			}
            tabBarItem.image = UIImage(named:imageName)!.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage(named:imageName + "_Active")!.withRenderingMode(.alwaysOriginal)
        }
    }
	
    func setUpViewControllers() {
     
        //  My Routine
//        let weekViewController = WeekViewController()
//        let weekNavController = ASNavigationController(rootViewController: weekViewController)
//        weekViewController.navigationController?.navigationBar.barStyle = .black
//        weekViewController.extendedLayoutIncludesOpaqueBars = true
		
        //	Discovery
        let exploreViewController = ExploreViewController()
        let exploreNavController = ASNavigationController(rootViewController: exploreViewController)
		exploreViewController.navigationController?.navigationBar.barStyle = .black
        exploreViewController.extendedLayoutIncludesOpaqueBars = true
		
        //	Clubs
        let clubsViewController = ClubsViewController()
        let clubsNavController = ASNavigationController(rootViewController: clubsViewController)
        clubsViewController.navigationController?.navigationBar.barStyle = .black
        clubsViewController.extendedLayoutIncludesOpaqueBars = true
		
		//  Activity View Controller
		let profileViewController = ProfileViewController()
		let profileNavController = ASNavigationController(rootViewController: profileViewController)
		//profileSettingsNavController.tabBarItem.title = "Profile"
		profileViewController.navigationController?.navigationBar.barStyle = .black
		profileViewController.extendedLayoutIncludesOpaqueBars = true
		
		
        viewControllers = [clubsNavController, exploreNavController, profileNavController]
        
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
