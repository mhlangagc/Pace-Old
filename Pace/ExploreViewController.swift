//
//  ViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ExploreViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate  {

	var collectionNode : ASCollectionNode?
	var searchController : UISearchController?
	
	lazy var ExploreWorkoutSetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	func retrieveFeaturedWorkouts() -> [ExploreWorkoutModel] {
		
		var workoutArray = [ExploreWorkoutModel]()
		
		FIRDatabase.database().reference().child("ExploreWorkouts").child("FeaturedWorkouts").observe(FIRDataEventType.childAdded, with: { (snapShot) in
			
			let exploreID = snapShot.key
			
			if let dictionary = snapShot.value as? [String: AnyObject] {
				
				let featuredWorkout = ExploreWorkoutModel()
				
				featuredWorkout.workoutName = dictionary["workoutName"] as? String
				featuredWorkout.workoutMins = dictionary["workoutMins"] as? Int
				featuredWorkout.workoutImageUrl = dictionary["workoutImageUrl"] as? String
				
				featuredWorkout.trainerName = dictionary["trainerName"] as? String
				featuredWorkout.trainerImageUrl = dictionary["trainerImageUrl"] as? String
				
				featuredWorkout.workoutDescription = dictionary["workoutDescription"] as? String
				featuredWorkout.rating = dictionary["rating"] as? Int
				featuredWorkout.numberOfReviews = dictionary["numberOfReviews"] as? Int
				featuredWorkout.workoutPrice = (dictionary["workoutPrice"] as? Double).map { PriceEnum(rawValue: $0) }!
				featuredWorkout.workoutCatergory = (dictionary["workoutCatergory"] as? String).map { WorkoutCatergory(rawValue: $0) }!
				
				featuredWorkout.exploreID = exploreID
				
				workoutArray.append(featuredWorkout)
				
			}
			
		}, withCancel: nil)
		
		return workoutArray
		
	}
	
	
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 0
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: collectionNode!)
		
		navigationNoLineBar()
		self.setupCollectionView()
		self.setUpSearchCntroller()
		
	}
	
	func setUpSearchCntroller() {
		
		self.searchController = UISearchController(searchResultsController:  nil)
		self.searchController?.searchResultsUpdater = self
		self.searchController?.delegate = self
		self.searchController?.searchBar.delegate = self
		self.searchController?.dimsBackgroundDuringPresentation = false
		self.searchController?.searchBar.placeholder = "Find a workout or trainer"
		self.searchController?.hidesNavigationBarDuringPresentation = false
		self.navigationItem.titleView = searchController?.searchBar
		self.definesPresentationContext = true
		self.searchController?.searchBar.barStyle = .black
		self.searchController?.searchBar.barTintColor = UIColor.paceBrandColor()
		self.searchController?.searchBar.setBackgroundImage(UIImage(), for: .topAttached, barMetrics: UIBarMetrics.default)
		self.searchController?.searchBar.backgroundColor = UIColor.black
		
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		
		//filterContentForSearchText(searchText: searchController.searchBar.text!)
		
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.leadingScreensForBatching = 1.0
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.showsVerticalScrollIndicator = false
		collectionNode?.view.backgroundColor = UIColor.black
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationBarItems()
		navigationNoLineBar()
		//self.setUpSearchCntroller()
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationBarItems()
		navigationItem.title = "Explore"
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		
		
	}
	
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Explore"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		
		//self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleSearch))
	}
	
	
	func handleSearch() {
		
		//	TO DO
		
	}
	
	func handleSeeAllTrainers() {
		
		let seeAllPeopleVC = AllPeopleViewController()
		seeAllPeopleVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeAllPeopleVC, animated: true)
		
	}
	
	var exploreWorkoutsToPass : [ExploreModel]?
	var allWorkoutsTitle : String?
	
	func handleSeeAllWorkouts() {
		
		let seeAllWorkoutsVC = AllWorkoutsViewController()
		seeAllWorkoutsVC.navigationItem.title = allWorkoutsTitle
		//seeAllWorkoutsVC.workoutsPassed = exploreWorkoutsToPass
		seeAllWorkoutsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeAllWorkoutsVC, animated: true)
	
	}
	
	
	func handleShowProfile() {
		
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
		
	}
	
	func handleShowWorkoutView() {
		
		//let daySelected = weeklyWorkouts?[indexPath.item]
		
		let showWorkoutDetailsVC = WorkoutViewController()
		showWorkoutDetailsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(showWorkoutDetailsVC, animated: true)
	}
	
	
	func showWorkoutCatergoryView() {
		
		let seeCatergoryWorkoutsVC = AllWorkoutsViewController()
		seeCatergoryWorkoutsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeCatergoryWorkoutsVC, animated: true)
	}
	
	
	func becomeATrainer() {
		
		//	TO DO
		print("Become a Trainer")
		
	}
	
	
	func sendFeedback() {
		
		//	TO DO
		print("Send Feedback")
		
	}
	
	
}

