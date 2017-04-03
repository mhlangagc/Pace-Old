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

class ChatsViewController : ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDelegateFlowLayout, ASCollectionDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var clubModel: ClubModel?
	var imageContainerViewTopAnchor: NSLayoutConstraint?

	var messagesArray = [TeamMessagesModel]()
	var imageUrl: String?
	
	var userName: String?
	var userImageURL : String?
	
	var collectionNode : ASCollectionNode?
	var trainer = User()
	var exploreWorkout : ExploreWorkoutModel?
	
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
		view.backgroundColor = UIColor(fromHexString: "3C4459")
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
	
	
	//	Bottom View
	lazy var captureImageButton: UIImageView = {
		
		let sendImageButton = UIImageView()
		sendImageButton.image = UIImage(named: "cameraSelection")
		sendImageButton.contentMode = .scaleAspectFit
		sendImageButton.isUserInteractionEnabled = true
		sendImageButton.backgroundColor = UIColor.darkBlack()
		sendImageButton.layer.cornerRadius = 8.0
		sendImageButton.layer.masksToBounds = true
		sendImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickImage)))
		sendImageButton.translatesAutoresizingMaskIntoConstraints = false
		return sendImageButton
		
	}()
	
	lazy var selectImageButton: UIImageView = {
		
		let sendImageButton = UIImageView()
				sendImageButton.image = UIImage(named: "ImageSelection")
		sendImageButton.contentMode = .scaleAspectFit
		sendImageButton.isUserInteractionEnabled = true
		sendImageButton.backgroundColor = UIColor.darkBlack()
		sendImageButton.layer.cornerRadius = 8.0
		sendImageButton.layer.masksToBounds = true
		sendImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickImage)))
		sendImageButton.translatesAutoresizingMaskIntoConstraints = false
		return sendImageButton
		
	}()
	
	lazy var imageSelectionContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.closeBlack()
		
		if let window = UIApplication.shared.keyWindow {
			
			containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 143)
			
		}
		
		containerView.addSubview(self.captureImageButton)
		self.captureImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 17.0).isActive = true
		self.captureImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.captureImageButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
		self.captureImageButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
		
		
		containerView.addSubview(self.selectImageButton)
		self.selectImageButton.leftAnchor.constraint(equalTo: self.captureImageButton.rightAnchor, constant: 28.0).isActive = true
		self.selectImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.selectImageButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
		self.selectImageButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
		
		
		return containerView

		
	}()

	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 8
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		collectionNode?.backgroundColor = UIColor.closeBlack()
		super.init(node: collectionNode!)
		navigationNoLineBar()
		
	}
	
	func setupCollectionView() {
		
		collectionNode?.delegate   = self
		collectionNode?.dataSource = self
		collectionNode?.view.leadingScreensForBatching = 1.0
		collectionNode?.view.alwaysBounceVertical = true
		collectionNode?.view.allowsSelection = false
		collectionNode?.view.keyboardDismissMode = .interactive
		//collectionNode?.view.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0.0, bottom: 64, right: 0.0)
		collectionNode?.view.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 64, right: 0.0)
		collectionNode?.view.showsVerticalScrollIndicator = false
		collectionNode?.view.backgroundColor = UIColor.closeBlack()
		
	}
	
	private func setupRightNavItem() {
		
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "moreGreen").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleMoreOptions), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	private func setupLeftNavItem() {
		
		let moreButton = UIButton(type: .system)
		moreButton.setImage(#imageLiteral(resourceName: "backArrow").withRenderingMode(.alwaysOriginal), for: .normal)
		moreButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		moreButton.addTarget(self, action: #selector(handleBack), for: UIControlEvents.touchUpInside)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: moreButton)
		
	}
	
	var startRunButtonView : StartRunView?
	
	func setupStartRunButton() {
		
		startRunButtonView = StartRunView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70.0))
		startRunButtonView?.startRun?.setTitle("START RUN", for: UIControlState.normal)
		startRunButtonView?.startRun?.setTitleColor(UIColor.paceBrandColor(), for: UIControlState.normal)
		startRunButtonView?.startRun?.backgroundColor = UIColor(fromHexString: "14161B")
		startRunButtonView?.backgroundColor = .paceBackgroundBlack()
		startRunButtonView?.postsVC = self
		startRunButtonView?.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(startRunButtonView!)
		
		startRunButtonView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		startRunButtonView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		startRunButtonView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		startRunButtonView?.heightAnchor.constraint(equalToConstant: 70.0).isActive = true

		
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		fatalError("Storyboards are incompatible with truth and beauty")
	
	}
	
	func setupImageSelectionContainerView() {
		
		//self.view.addSubview(imageSelectionContainerView)
		
	}
	
	lazy var chatContainerView : UIView = {
		
		let containerView = UIView()
		containerView.backgroundColor = UIColor.black
		containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56)
		
		
		containerView.addSubview(self.sendButton)
		self.sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15.0).isActive = true
		self.sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.sendButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
		self.sendButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
		
//		containerView.addSubview(self.addImageButton)
//		self.addImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15.0).isActive = true
//		self.addImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//		self.addImageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
//		self.addImageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		
		containerView.addSubview(self.inputTextField)
//		self.inputTextField.leftAnchor.constraint(equalTo: self.addImageButton.rightAnchor, constant: 15).isActive = true
		self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
		self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -10.0).isActive = true
		self.inputTextField.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		
		containerView.addSubview(self.line)
		self.line.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.line.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1.0).isActive = true
		self.line.rightAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
		self.line.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		return containerView
		
	}()
	
	func setupKeyboardObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
		
	}
	
	func handleKeyboardNotification(notification: NSNotification) {
		
		let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
		
		if isKeyboardShowing {
			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			self.collectionNode?.scrollToItem(at: indexPath, at: .bottom, animated: true)
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


	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self)
	
	}
	
	override var inputAccessoryView: UIView? {
		
		get {
			
			return chatContainerView
			
		}
		
	}
	
	override var canBecomeFirstResponder: Bool {
		
		return true
	}

	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupImageSelectionContainerView()
		navigationNoLineBar()
		self.setupNavBar()
		self.setupRightNavItem()
		self.setupLeftNavItem()
		self.setupKeyboardObservers()
		
		self.observeTeamMessages(clubID: (clubModel?.clubID)!, completion: { (clubMessagesArray) in
			
			self.messagesArray = clubMessagesArray
			self.setupCollectionView()
			self.collectionNode?.reloadData()
			
			let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
			self.collectionNode?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
			
		})
		
		//self.setupStartRunButton()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.paceBackgroundBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.paceBackgroundBlack()
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
		
	}
	
	func handleViewTrainerProfile() {
	
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.trainer = trainer
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
	
	}
	
	func setupNavBar() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = clubModel?.name
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
	}
	
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
	
	func handleMoreOptions() {
		
		
		//	TO DO
		
	}
	
	func handleStartWorkout() {
		
		let readyToRunVC = ReadyViewController()
		readyToRunVC.club = self.clubModel
		let readyNavBar = UINavigationController(rootViewController: readyToRunVC)
		self.navigationController?.present(readyNavBar, animated: true, completion: { 
			
			//	TO DO
			
		})
		
	}
	
	func handleBack() {
		
		if let navController = self.navigationController {
			
			navController.popViewController(animated: true)
			
		}
	
	}
	
	var viewOpened = false
	func handleSelectImage() {
		
//		if let window = UIApplication.
		
		if viewOpened == false {
			
			UIView.animate(withDuration: 0.25) {
				
				self.addImageButton.image = #imageLiteral(resourceName: "ImageOpened")
				
				if let window = UIApplication.shared.keyWindow {
					
					self.imageSelectionContainerView.frame = CGRect(x: 0, y: window.frame.height - 143, width: window.frame.width, height: 143)
					self.view.layoutIfNeeded()
					
				}
			
				
				
			}
			viewOpened = true
			
		} else {
			
			UIView.animate(withDuration: 0.3) {
				
				self.addImageButton.image = #imageLiteral(resourceName: "postImage")
				if let window = UIApplication.shared.keyWindow {
					
					self.imageSelectionContainerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 143)
					self.view.layoutIfNeeded()
					
				}
				
				
			}
			
			viewOpened = false
			
			
		}
		
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
			
			self.addImageButton.image = selectedImage
			uploadToFirebaseStorageUsingImage(image: selectedImage)
			
		}
		
		dismiss(animated: true, completion: nil)
		
	}
	
	//	Generate an image URL from the selected image
	private func uploadToFirebaseStorageUsingImage(image: UIImage) {
		
		let imageName = NSUUID().uuidString
		let ref = FIRStorage.storage().reference().child("post_images").child(imageName)
		
		if let uploadData = UIImageJPEGRepresentation(image, 0.2) {
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
	
	//	Send Message
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
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		dismiss(animated: true, completion: nil)
		
	}

}
