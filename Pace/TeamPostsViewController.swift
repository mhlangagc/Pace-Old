//
//  ConversationViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamPostsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
	
	var teamModel: TeamsModel?
	var containerViewBottomAnchor: NSLayoutConstraint?
	let ChatMessageCellID = "ChatMessageCellID"
	
	var messagesArray = [TeamMessagesModel]()

	lazy var appService: PaceAppServices = {
		
		let appService = PaceAppServices()
		return appService
		
	}()
	
	lazy var inputTextField: UITextField = {
		
		let textField = TextField()
		textField.borderStyle = .none
		textField.keyboardType = .default
		textField.keyboardAppearance = .dark
		textField.backgroundColor = .black
		textField.autocapitalizationType = .sentences
		textField.textColor = UIColor.white
		textField.layer.cornerRadius = 50.0 * 0.5
		textField.layer.borderWidth = 1.5
		textField.layer.borderColor = UIColor.greyBlackColor().cgColor
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"Ask the team anything...",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyWhite()])
		textField.returnKeyType = .default
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	lazy var sendButton: UIButton = {
		
		let button = UIButton()
		button.isEnabled = false
		button.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()

	
	let postsMenuBar: PostsMenuBar = {
		
		let postsBar = PostsMenuBar()
		postsBar.translatesAutoresizingMaskIntoConstraints = false
		return postsBar
		
	}()
	
	func setupCollectionView() {
		
		collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 70, right: 0) //58 for the top
		collectionView?.alwaysBounceVertical = true
		collectionView?.backgroundColor = UIColor(fromHexString: "0C0E10")
		collectionView?.register(MessagePostsCell.self, forCellWithReuseIdentifier: ChatMessageCellID)
		collectionView?.keyboardDismissMode = .interactive
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		navigationItem.title = teamModel?.workoutName
		navigationNoLineBar()
		self.setupRightNavItem()
		
	}
	
	private func setupRightNavItem() {
		
		let buttonWidth : CGFloat = 35.0
		let trainerButton = UIButton(type: .system)
		trainerButton.setImage(#imageLiteral(resourceName: "justin").withRenderingMode(.alwaysOriginal), for: .normal)
		trainerButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth)
		trainerButton.layer.cornerRadius = buttonWidth * 0.5
		trainerButton.layer.masksToBounds = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: trainerButton)
		
	}
	
	func observeTeamMessages(completion: @escaping (_ result: [TeamMessagesModel]) -> Void) {
		
		let teamID = teamModel?.workoutID
		var teamMessagesArray = [TeamMessagesModel]()
		
		print(teamID!)
		
		let fanTeamMessagesRef = FIRDatabase.database().reference().child("fan-team-messages").child(teamID!)
		fanTeamMessagesRef.observe(.childAdded, with: { (snapshot) in
			
			let messageId = snapshot.key
			let messagesRef = FIRDatabase.database().reference().child("TeamMessages").child(messageId)
			messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
				
				if let dictionary = snapshot.value as? [String: AnyObject] {
					
					let workoutTeamMessage = TeamMessagesModel()
					
					workoutTeamMessage.userSending = dictionary["userSending"] as? String
					workoutTeamMessage.message = dictionary["message"] as? String
					workoutTeamMessage.timeStamp = dictionary["timeStamp"] as? Int
					teamMessagesArray.append(workoutTeamMessage)
					
					completion(teamMessagesArray)
					
				}
				
				
			}, withCancel: nil)
			
		}, withCancel: nil)
	}

	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
		
		self.observeTeamMessages { (teamMessagesRecieved) in
			
			self.messagesArray = teamMessagesRecieved
			print(self.messagesArray)
			self.setupCollectionView()
			self.collectionView?.reloadData()
			self.view.layoutIfNeeded()
			
		}
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
	}
	
	lazy var chatContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.black
		containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65)
	
		
		containerView.addSubview(self.sendButton)
		self.sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15.0).isActive = true
		self.sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.sendButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
		self.sendButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
		
		
		containerView.addSubview(self.inputTextField)
		self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
		self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -10.0).isActive = true
		self.inputTextField.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		
		return containerView
		
	}()
	
	
	override var inputAccessoryView: UIView? {
		
		get {
			
			return chatContainerView
		
		}
		
	}
	
	override var canBecomeFirstResponder: Bool {
		
		return true
	}
	
	private func setupChatMenuBar() {
		
		view.addSubview(postsMenuBar)
		
		postsMenuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		postsMenuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		postsMenuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		postsMenuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
	}
	
	func textFieldDidChange() {
		
		if (inputTextField.text?.characters.count)! > 0 {
			
			sendButton.isEnabled = true
			sendButton.setImage(UIImage(named: "send"), for: UIControlState.normal)
			
		} else {
			
			sendButton.isEnabled = false
			sendButton.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
			
			
		}
		
	}

	func handleSendingInvitation() {
		
		// TO DO
		print("Sending Invitation to Friend")
		
		
	}
	
	func handleSend() {
		
		guard let teamID = teamModel?.workoutID else {
			return
		}
		
		let ref = FIRDatabase.database().reference().child("TeamMessages")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		let values = ["message" : inputTextField.text!,
		              "userSending": userID,
		              "timeStamp": Int(NSDate().timeIntervalSince1970),
		              "teamID": teamID] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
			let userPostsRef = FIRDatabase.database().reference().child("fan-user-messages").child(userID)
			let messageId = childRef.key
			userPostsRef.updateChildValues([messageId: 1])
			
			let workoutTeamMessagesRef = FIRDatabase.database().reference().child("fan-team-messages").child(teamID)
			workoutTeamMessagesRef.updateChildValues([messageId: 1])
			
			
		}


		inputTextField.text = nil
		sendButton.isEnabled = false
		sendButton.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		
	}
	
	
	func handleClose() {
		
		if let navController = self.navigationController {
			
			navController.popViewController(animated: true)
			
		}
		
	}
	
}

