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
import MessageUI

class ExploreViewController: ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource, MFMailComposeViewControllerDelegate  {

	var collectionNode : ASCollectionNode?
	
	lazy var ExploreWorkoutSetup: ExploreViewModel = {
		
		let exploreWorkoutsSetup = ExploreViewModel()
		return exploreWorkoutsSetup
		
	}()
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 15
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		super.init(node: collectionNode!)
		
		navigationNoLineBar()
		self.setupCollectionView()
		
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
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationBarItems()
		navigationItem.title = "Explore"
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBackgroundBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.paceBackgroundBlack()
		
		
	}
	
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Explore"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		
		//self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleSearch))
	}
	
	
	func handleSeeAllTrainers() {
		
		let seeAllPeopleVC = AllPeopleViewController()
		seeAllPeopleVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeAllPeopleVC, animated: true)
		
	}
	
	var allWorkoutsTitle : String?
	
	func handleSeeAllWorkouts() {
		
		let seeAllWorkoutsVC = AllWorkoutsViewController()
		seeAllWorkoutsVC.navigationItem.title = allWorkoutsTitle
		seeAllWorkoutsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeAllWorkoutsVC, animated: true)
	
	}
	
	
	func handleShowProfile(userSelected: User) {
		
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.hidesBottomBarWhenPushed = true
		exploreProfileVC.trainer = userSelected
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
		
		
	}
	
	func handleShowClubView(clubSelected: ClubModel) {
		
		let showClubDetailsVC = WorkoutViewController()
		showClubDetailsVC.club = clubSelected
		showClubDetailsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(showClubDetailsVC, animated: true)
		
	}
	
	
	func showWorkoutCatergoryView() {
		
		let seeCatergoryWorkoutsVC = AllWorkoutsViewController()
		seeCatergoryWorkoutsVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(seeCatergoryWorkoutsVC, animated: true)
	}
	
	
	func becomeATrainer() {
		
		let mailComposeViewController = configuredMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			
			self.present(mailComposeViewController, animated: true, completion: nil)
			
		} else {
			
			self.showSendMailErrorAlert()
			
		}
		
	}
	
	func sendFeedback() {
		
		
		let mailComposeViewController = configuredFeedbackMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			
			self.present(mailComposeViewController, animated: true, completion: nil)
			
		} else {
			
			self.showSendMailErrorAlert()
			
		}
		
		
	}
	
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
	
	func configuredMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		mailComposerVC.setToRecipients(["gugulethu@paceapp.fitness"])
		mailComposerVC.setSubject("Joining Pace as a Trainer")
		mailComposerVC.setMessageBody("Hi There, \n \n Because we are still new we are accepting trainers, to join via email. \n \n Compose your email here and we will be in touch in 30mins. ;) 🏋🏽🏊🏽‍♀️", isHTML: false)
		
		return mailComposerVC
	
	}
	
	func configuredFeedbackMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		mailComposerVC.setToRecipients(["gugulethu@paceapp.fitness"])
		mailComposerVC.setSubject("Some thoughts Pace...")
		mailComposerVC.setMessageBody("Hi There, \n \n We are new and would love to know all your thoughts, criticisms, ideas on improvement or just your workout story. \n \n Send us your feedback here and we will be in touch within 10mins tops ;). 🏊🏽‍♀️🏋🏽 \n \n", isHTML: false)
		
		return mailComposerVC
		
	}
	
	
	func showSendMailErrorAlert() {
		
		let alertController = UIAlertController(title: "Could not open mail!", message: "Please check your e-mail settings and try again.", preferredStyle: .alert)
		
		let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
			// ...
		}
		alertController.addAction(OKAction)
		
		self.present(alertController, animated: true) {
			// ...
		}
	}
	
	
}


