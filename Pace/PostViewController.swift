//
//  PostViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/07.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PostViewController : ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {
	
	var teamModel: TeamsModel?
	var containerViewBottomAnchor: NSLayoutConstraint?

	var messagesArray = [TeamMessagesModel]()
	
	var collectionNode : ASCollectionNode?
	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 25
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		collectionNode?.backgroundColor = UIColor(fromHexString: "0C0E10")
		super.init(node: collectionNode!)
		navigationNoLineBar()
	
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.leadingScreensForBatching = 1.0
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 70, right: 0)
		collectionNode?.view.showsVerticalScrollIndicator = false
		collectionNode?.view.backgroundColor = UIColor(fromHexString: "0C0E10")
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Storyboards are incompatible with truth and beauty")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavBar()
		navigationNoLineBar()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavBar()
		
		print((teamModel?.workoutID)!)
		
		self.observeTeamMessages { (postsArray) in
			
			self.messagesArray = postsArray
			
			self.setupCollectionView()
			
			let indexPath = IndexPath(item: 0, section: 0)
			self.collectionNode?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)
			
		}

		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
	}
	
	private func setupNavBar() {
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = teamModel?.workoutName
		myLabel.numberOfLines = 1
		myLabel.textColor = UIColor.white
		myLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
		
		
		let smallText = UILabel()
		smallText.translatesAutoresizingMaskIntoConstraints = false
		smallText.text = "2k Members"
		smallText.numberOfLines = 1
		smallText.textColor = UIColor.greyWhite()
		smallText.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightBold)
		
		
		let wrapper = UIView()
		wrapper.addSubview(myLabel)
		wrapper.addSubview(smallText)
		wrapper.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[myLabel]-0-|", options: [], metrics: nil, views: ["myLabel": myLabel, "smallText": smallText]))
		wrapper.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[myLabel]-2-[smallText]-0-|", options: .alignAllCenterX, metrics: nil, views: ["myLabel": myLabel, "smallText": smallText]))
		
		wrapper.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(max(myLabel.intrinsicContentSize.width, smallText.intrinsicContentSize.width)), height: CGFloat(myLabel.intrinsicContentSize.height + smallText.intrinsicContentSize.height + 2))
		wrapper.clipsToBounds = true
		
		self.navigationItem.titleView = wrapper
		self.navigationController?.navigationBar.clipsToBounds = true
		
		if let window = UIApplication.shared.keyWindow {
			
			self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: window.frame.size.width, height: 80.0)
		
		}
		
	}

	
	func observeTeamMessages(completion: @escaping (_ result: [TeamMessagesModel]) -> Void) {
		
		var teamMessagesArray = [TeamMessagesModel]()
		
		if let teamID = teamModel?.workoutID {
			
			let fanTeamMessagesRef = FIRDatabase.database().reference().child("fan-team-messages").child(teamID)
			
			fanTeamMessagesRef.observe(.childAdded, with: { (snapshot) in
				
				let messageId = snapshot.key
				let messagesRef = FIRDatabase.database().reference().child("TeamMessages").child(messageId)
				messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
					
					if let dictionary = snapshot.value as? [String: AnyObject] {
						
						let workoutTeamMessage = TeamMessagesModel()
						
						workoutTeamMessage.imageURL = dictionary["imageUrl"] as? String
						workoutTeamMessage.userSending = dictionary["userSending"] as? String
						workoutTeamMessage.message = dictionary["message"] as? String
						workoutTeamMessage.timeStamp = dictionary["timeStamp"] as? Int
						teamMessagesArray.append(workoutTeamMessage)
						teamMessagesArray.sort(by: {$0.timeStamp! > $1.timeStamp!})
						
						completion(teamMessagesArray)
						
					}
					
					
				}, withCancel: nil)
				
			}, withCancel: nil)

		}
		
	}

	

}
