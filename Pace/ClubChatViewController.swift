//
//  ClubChatViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ClubChatViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
	
	let ClubChatCellID = "ClubChatCellID"
	var clubModel: ClubModel?
	var imageContainerViewTopAnchor: NSLayoutConstraint?
	
	var messagesArray = [TeamMessagesModel]()
	var imageUrl: String?
	
	var userName: String?
	var userImageURL : String?
	
//	var collectionNode : ASCollectionNode?
	var trainer = User()
	var exploreWorkout : ExploreWorkoutModel?
	
	let startWorkoutBar : StartWorkoutButtonView = {
		
		let startWorkoutBar = StartWorkoutButtonView()
		startWorkoutBar.translatesAutoresizingMaskIntoConstraints = false
		return startWorkoutBar
		
	}()
	
	
	lazy var inputTextField: UITextField = {
		
		let textField = UITextField()
		textField.borderStyle = .none
		textField.keyboardType = .default
		textField.keyboardAppearance = .dark
		textField.backgroundColor = .black
		textField.autocapitalizationType = .sentences
		textField.textColor = UIColor.white
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"Chat with the club...",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyWhite()])
		textField.returnKeyType = .default
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
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
	
	
	let line: UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor(fromHexString: "282C36")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	
	lazy var addImageButton: UIImageView = {
		
		let sendImageButton = UIImageView()
		sendImageButton.image = UIImage(named: "postImage")
		sendImageButton.contentMode = .scaleAspectFill
		sendImageButton.isUserInteractionEnabled = true
		sendImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImage)))
		sendImageButton.translatesAutoresizingMaskIntoConstraints = false
		return sendImageButton
		
	}()
	
	lazy var chatContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.black
		containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56)
		
		containerView.addSubview(self.addImageButton)
		self.addImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
		self.addImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.addImageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
		self.addImageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		
		containerView.addSubview(self.sendButton)
		self.sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
		self.sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.sendButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
		self.sendButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
		
		
		containerView.addSubview(self.line)
		self.line.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.line.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.line.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		self.line.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
		
		
		containerView.addSubview(self.inputTextField)
		self.inputTextField.leftAnchor.constraint(equalTo: self.addImageButton.rightAnchor, constant: 16).isActive = true
		self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -16).isActive = true
		self.inputTextField.topAnchor.constraint(equalTo: self.line.bottomAnchor).isActive = true
		self.inputTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
		
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
	
	let selectImageBar : ChatImageSelectionBarView = {
		
		let imageSelection = ChatImageSelectionBarView()
		imageSelection.translatesAutoresizingMaskIntoConstraints = false
		return imageSelection
		
	}()
	
	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()
	
	lazy var clubChatCollectionView: UICollectionView = {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 16
		flowLayout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.closeBlack()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 56.0, right: 0.0)
		collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 56.0, right: 0.0)
		collectionView.alwaysBounceVertical = true
		collectionView.alwaysBounceHorizontal = false
		collectionView.allowsSelection = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.closeBlack()
		self.setupNavBar()
		self.setupKeyboardObservers()
		
		self.observeTeamMessages(clubID: (clubModel?.clubID)!, completion: { (clubMessagesArray) in
			
			self.messagesArray = clubMessagesArray
			self.setupCollectionView()
			
			self.clubChatCollectionView.reloadData()
			self.clubChatCollectionView.keyboardDismissMode = .interactive
			
			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			self.clubChatCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
			
		})
		
	}
	
	func setupNavBar() {
		
		// Title
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBackgroundBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.paceBackgroundBlack()
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
		//	Title
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = clubModel?.name
		titleLabel.textAlignment = .center
		titleLabel.isUserInteractionEnabled = true
		titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowGroup)))
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		//	Right Bar
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "create").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleMoreOptions), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	
	func setupCollectionView() {
		
		view.addSubview(startWorkoutBar)
		startWorkoutBar.clubChatVC = self
		
		view.addSubview(clubChatCollectionView)
		clubChatCollectionView.register(ClubChatCell.self, forCellWithReuseIdentifier: ClubChatCellID)
		
		startWorkoutBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		startWorkoutBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		startWorkoutBar.heightAnchor.constraint(equalToConstant: 62).isActive = true
		startWorkoutBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		
		clubChatCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		clubChatCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		clubChatCollectionView.topAnchor.constraint(equalTo: startWorkoutBar.bottomAnchor).isActive = true
		clubChatCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		
		clubChatCollectionView.collectionViewLayout.invalidateLayout()
	
	}
	
	
	func setupKeyboardObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
		
	}
	
	func handleKeyboardNotification(notification: NSNotification) {
		
		let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
		
		if isKeyboardShowing {
			
			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			self.clubChatCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
		
		}
		
		//		UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
		//
		//			self.view.layoutIfNeeded()
		//
		//		}, completion: { (completed) in
		//
		//
		//		})

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
	
	func handleMoreOptions() {
		
		//	TO DO
		
	}
	
	func handleSend() {
		
		let clubID = (clubModel?.clubID)!
		let ref = FIRDatabase.database().reference().child("ClubMessages")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		//	Code to send a message with an image
		if self.imageUrl != nil {
			
			let values = ["imageUrl": imageUrl!,
			              "message" : inputTextField.text!,
			              "userSending": userID,
			              "userSendingName": userName!,
			              "userSendingImageURL": userImageURL!,
			              "timeStamp": Int(NSDate().timeIntervalSince1970),
			              "teamID": clubID] as [String : Any]
			
			childRef.updateChildValues(values) { (error, ref) in
				
				if error != nil {
					print((error?.localizedDescription)!)
					return
				}
				
				let userPostsRef = FIRDatabase.database().reference().child("fan-user-messages").child(userID)
				let messageId = childRef.key
				userPostsRef.updateChildValues([messageId: 1])
				
				let workoutTeamMessagesRef = FIRDatabase.database().reference().child("fan-club-messages").child(clubID)
				workoutTeamMessagesRef.updateChildValues([messageId: 1])
				
				
			}
			
			
		} else { //	Code to send a message without an image
			
			let values = ["imageUrl": "",
			              "message" : inputTextField.text!,
			              "userSending": userID,
			              "userSendingName": userName!,
			              "userSendingImageURL": userImageURL!,
			              "timeStamp": Int(NSDate().timeIntervalSince1970),
			              "teamID": clubID] as [String : Any]
			
			childRef.updateChildValues(values) { (error, ref) in
				
				if error != nil {
					print((error?.localizedDescription)!)
					return
				}
				
				let userPostsRef = FIRDatabase.database().reference().child("fan-user-messages").child(userID)
				let messageId = childRef.key
				userPostsRef.updateChildValues([messageId: 1])
				
				let workoutTeamMessagesRef = FIRDatabase.database().reference().child("fan-club-messages").child(clubID)
				workoutTeamMessagesRef.updateChildValues([messageId: 1])
				
			}
			
			
		}
		
		
		imageUrl = nil
		addImageButton.image = UIImage(named: "postImage")
		inputTextField.text = nil
		sendButton.isEnabled = false
		sendButton.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		
	}
	
	func handleSelectImage() {
		
		//	TO DO
		print("Select Image")
		
	}
	
	func handleShowGroup() {
		
		print("Show Club Details")
		
	}
	
	
	func handleStartWorkout() {
		
		let readyToRunVC = ReadyViewController()
		readyToRunVC.club = self.clubModel
		let readyNavBar = UINavigationController(rootViewController: readyToRunVC)
		self.navigationController?.present(readyNavBar, animated: true, completion: {
			
			//	TO DO
			
		})
	}
	
	

	
}

extension ClubChatViewController {
	
	func observeTeamMessages(clubID: String, completion: @escaping (_ result: [TeamMessagesModel]) -> Void) {
		
		var teamMessagesArray = [TeamMessagesModel]()
		
		let fanTeamMessagesRef = FIRDatabase.database().reference().child("fan-club-messages").child(clubID)
		
		fanTeamMessagesRef.observe(.childAdded, with: { (snapshot) in
			
			let messageId = snapshot.key
			let messagesRef = FIRDatabase.database().reference().child("ClubMessages").child(messageId)
			messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
				
				if let dictionary = snapshot.value as? [String: AnyObject] {
					
					let workoutTeamMessage = TeamMessagesModel()
					
					workoutTeamMessage.imageURL = dictionary["imageUrl"] as? String
					workoutTeamMessage.userSending = dictionary["userSending"] as? String
					workoutTeamMessage.message = dictionary["message"] as? String
					workoutTeamMessage.timeStamp = dictionary["timeStamp"] as? Int
					workoutTeamMessage.userSendingName = dictionary["userSendingName"] as? String
					workoutTeamMessage.userSendingImageURL = dictionary["userSendingImageURL"] as? String
					teamMessagesArray.append(workoutTeamMessage)
					//teamMessagesArray.sort(by: {$0.timeStamp! > $1.timeStamp!})
					
					completion(teamMessagesArray)
					
				}
				
				
			}, withCancel: nil)
			
		}, withCancel: nil)
		
		
	}
	
}
