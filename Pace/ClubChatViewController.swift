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
import MessageUI

class ClubChatViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
	
	let ClubChatCellID = "ClubChatCellID"
	var clubModel: ClubModel?
	var imageContainerViewTopAnchor: NSLayoutConstraint?
	
	var messagesArray = [TeamMessagesModel]()
	var imageUrl: String?
	let messageComposer = MessageComposer()
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
		textField.backgroundColor = .clear
		textField.autocapitalizationType = .sentences
		textField.textColor = UIColor.white
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"Chat with the club...",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyWhite()])
		textField.returnKeyType = .default
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
		//textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	lazy var sendButton: UIButton = {
		
		let button = UIButton()
		button.isEnabled = false
		button.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		//button.addTarget(self, action: #selector(handleSend), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
		
	}()
	
	
	let line: UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor(fromHexString: "282C36")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	
	lazy var addImageButton: UIButton = {
		
		let sendImageButton = UIButton()
		sendImageButton.setImage(UIImage(named: "postImage"), for: UIControlState.normal)
		sendImageButton.imageView?.contentMode = .scaleAspectFit
		sendImageButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		//sendImageButton.addTarget(self, action: #selector(handleSelectImage), for: UIControlEvents.touchUpInside)
		sendImageButton.translatesAutoresizingMaskIntoConstraints = false
		return sendImageButton
		
	}()
	
	lazy var chatContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.headerBlack()
		containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56)
		
//		containerView.addSubview(self.addImageButton)
//		self.addImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//		self.addImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//		self.addImageButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
//		self.addImageButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
		
		
		containerView.addSubview(self.sendButton)
		self.sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.sendButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
		self.sendButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
		
		
		containerView.addSubview(self.line)
		self.line.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.line.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
		self.line.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		self.line.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
		
		
		containerView.addSubview(self.inputTextField)
		self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
		self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -16).isActive = true
		self.inputTextField.topAnchor.constraint(equalTo: self.line.bottomAnchor).isActive = true
		self.inputTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
		
		return containerView
		
	}()
	
	/*
	override var inputAccessoryView: UIView? {
		
		get {
			
			return chatContainerView
			
		}
		
	}
	
	override var canBecomeFirstResponder: Bool {
		
		return true
	}
	*/
	
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
		collectionView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 62.0, right: 0.0)
		collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 62.0, right: 0.0)
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
		self.setupStartRunningBar()
		//self.setupKeyboardObservers()
		
		self.observeTeamMessages(clubID: clubID, completion: { (clubMessagesArray) in
			
			self.messagesArray = clubMessagesArray
			self.setupCollectionView()
			
			self.clubChatCollectionView.reloadData()
			//self.clubChatCollectionView.keyboardDismissMode = .interactive
			
			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			self.clubChatCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
			
		})
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavBar()
	}
	
	func setupNavBar() {
		
		// Title
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
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
		moreButton.addTarget(self, action: #selector(handleInviteFriends), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	var selectImageBarBottomConstraint: NSLayoutConstraint?
	
	func setupStartRunningBar() {
		
		view.addSubview(startWorkoutBar)
		startWorkoutBar.clubChatVC = self
		
		startWorkoutBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		startWorkoutBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		startWorkoutBar.heightAnchor.constraint(equalToConstant: 62).isActive = true
		startWorkoutBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		
	}
	func setupCollectionView() {
		
		view.addSubview(clubChatCollectionView)
		clubChatCollectionView.register(ClubChatCell.self, forCellWithReuseIdentifier: ClubChatCellID)
		
		//view.addSubview(selectImageBar)
		//selectImageBar.chatVC = self
		
		clubChatCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		clubChatCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		clubChatCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		clubChatCollectionView.bottomAnchor.constraint(equalTo: startWorkoutBar.topAnchor).isActive = true
		
		/*
		selectImageBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		selectImageBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		selectImageBar.heightAnchor.constraint(equalToConstant: 142).isActive = true
		selectImageBarBottomConstraint = selectImageBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 86)
		selectImageBarBottomConstraint?.isActive = true
		*/
		
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		
		clubChatCollectionView.collectionViewLayout.invalidateLayout()
	
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		//NotificationCenter.default.removeObserver(self)
		
	}
	
	func handleInviteFriends() {
		
		if (messageComposer.canSendText()) {
			
			let messageComposeVC = messageComposer.configuredMessageComposeViewController()
			present(messageComposeVC, animated: true, completion: nil)
		
		} else {
			
			print("Cannot Send Text Message")
			
		}
		
	
	}
	
	func handleShowGroup() {
		
		print("Show Club Details")
		let clubDetailsVC = ClubDetailsViewController()
		clubDetailsVC.club = clubModel
		self.navigationController?.pushViewController(clubDetailsVC, animated: true)
		
		
	}
	
	func handleStartWorkout() {
		
		let readyToRunVC = ReadyViewController()
		let readyNavBar = UINavigationController(rootViewController: readyToRunVC)
		self.navigationController?.present(readyNavBar, animated: true, completion: {
			
			//	TO DO
			
		})
	}
	
	
	/*
	func setupKeyboardObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
	}
	
	
	func handleKeyboardNotification(notification: NSNotification) {
		
		let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
		
		if isKeyboardShowing {
			
			//			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			//			self.clubChatCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
			
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
	
	var imageViewSelectionButtonOpen = false
	
	func handleSelectImage() {
		
		if imageViewSelectionButtonOpen == false {
			
			UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
				
				self.line.isHidden = true
				self.selectImageBarBottomConstraint?.constant = -56
				self.view.layoutIfNeeded()
				
			}, completion: { (completed) in
				
				self.addImageButton.setImage(UIImage(named: "ImageOpened"), for: UIControlState.normal)
				self.imageViewSelectionButtonOpen = true
				
			})
			
		} else {
			
			UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
				
				self.line.isHidden = false
				self.selectImageBarBottomConstraint?.constant = 86
				self.view.layoutIfNeeded()
				self.imageViewSelectionButtonOpen = false
				
			}, completion: { (completed) in
				
				self.addImageButton.setImage(UIImage(named: "postImage"), for: UIControlState.normal)
				self.selectImageBar.imageViewButton.imageEdgeInsets = UIEdgeInsets(top: 44, left: 40, bottom: 44, right: 40)
				self.selectImageBar.imageViewButton.setImage(UIImage(named: "ImageSelection"), for: UIControlState.normal)
				//self.imageSelected = nil
				
			})
			
		}
		
	}
	
	
	func handleSend() {
		
		let ref = FIRDatabase.database().reference().child("ClubMessages")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		//	Code to send a message with an image
		if self.imageSelected != nil {
			
			self.uploadToFirebaseStorageUsingImage {
				
				let values = ["imageUrl": imageUrl!,
				              "message" : inputTextField.text!,
				              "userSending": userID,
				              "userSendingName": usersName,
				              "userSendingImageURL": usersImageURL,
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
			
			
			
			
		} else { //	Code to send a message without an image
			
			let values = ["imageUrl": "",
			              "message" : inputTextField.text!,
			              "userSending": userID,
			              "userSendingName": usersName,
			              "userSendingImageURL": usersImageURL,
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
		
		imageSelected = nil
		imageUrl = nil
		addImageButton.setImage(UIImage(named: "postImage"), for: UIControlState.normal)
		inputTextField.text = nil
		sendButton.isEnabled = false
		sendButton.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		selectImageBar.imageViewButton.imageEdgeInsets = UIEdgeInsets(top: 44, left: 40, bottom: 44, right: 40)
		selectImageBar.imageViewButton.setImage(UIImage(named: "ImageSelection"), for: UIControlState.normal)
		
	}
	
	func handlePickImage() {
		
		//	Moving the Picker Up
		
		let imagePickerController = UIImagePickerController()
		
		imagePickerController.allowsEditing = true
		imagePickerController.delegate = self
		
		present(imagePickerController, animated: true, completion: nil)
		
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		var selectedImageFromPicker: UIImage?
		
		if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
			
			selectedImageFromPicker = editedImage
			
		} else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
			
			selectedImageFromPicker = originalImage
			
			
		}
		
		if let selectedImage = selectedImageFromPicker {
			
			selectImageBar.imageViewButton.setImage(selectedImage, for: UIControlState.normal)
			selectImageBar.imageViewButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
			self.imageSelected = selectedImage
			
		}
		
		dismiss(animated: true, completion: nil)
		
	}
	
	var imageSelected : UIImage?
	
	//	Generate an image URL from the selected image
	private func uploadToFirebaseStorageUsingImage(completion: () -> Void) {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child("post_images").child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(imageSelected!, 0.2) {
			ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
				
				if error != nil {
					print("Failed to upload image:", (error?.localizedDescription)!)
					return
				}
				
				if let imageUrl = metadata?.downloadURL()?.absoluteString {
					
					self.imageUrl = imageUrl
					
				}
				
			})
		}
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		dismiss(animated: true, completion: nil)
		
	}
	
	func handleCameraOpen() {
		
		print("Open Camera")
		
	}
	
	*/
	
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
