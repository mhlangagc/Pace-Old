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

class PostViewController : ASViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var teamModel: TeamsModel?
	var containerViewBottomAnchor: NSLayoutConstraint?

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
		textField.attributedPlaceholder = NSAttributedString(string:"Ask the team anything...",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
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
	
	
	lazy var addImageButton: UIImageView = {
		
		let sendImageButton = UIImageView()
		sendImageButton.image = UIImage(named: "postImage")
		sendImageButton.contentMode = .scaleAspectFill
		sendImageButton.isUserInteractionEnabled = true
		sendImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImage)))
		sendImageButton.translatesAutoresizingMaskIntoConstraints = false
		return sendImageButton
		
	}()

	
	init() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 0
		flowLayout.minimumLineSpacing       = 8
		flowLayout.scrollDirection = .vertical
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		collectionNode?.backgroundColor = UIColor.paceBackgroundBlack()
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
		collectionNode?.view.contentInset = UIEdgeInsets(top: 20, left: 0.0, bottom: 56, right: 0.0)
		collectionNode?.view.showsVerticalScrollIndicator = false
		collectionNode?.view.backgroundColor = UIColor.paceBackgroundBlack()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		fatalError("Storyboards are incompatible with truth and beauty")
	
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
		
		containerView.addSubview(self.addImageButton)
		self.addImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15.0).isActive = true
		self.addImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.addImageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
		self.addImageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		
		containerView.addSubview(self.inputTextField)
		self.inputTextField.leftAnchor.constraint(equalTo: self.addImageButton.rightAnchor, constant: 15).isActive = true
		self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -10.0).isActive = true
		self.inputTextField.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		
		
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

	lazy var paceAppService: PaceAppServices = {
		
		let retrieveWorkoutDetails = PaceAppServices()
		return retrieveWorkoutDetails
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavBar()
		navigationNoLineBar()
		
		self.observeTeamMessages { (postsArray) in
			
			self.messagesArray = postsArray
			
			self.setupCollectionView()
			
			//			let indexPath = IndexPath(item: 0, section: 0)
			//			self.collectionNode?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)
			
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavBar()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
	}
	
	var trainerButton: UIButton?
	
	func handleViewTrainerProfile() {
	
		let exploreProfileVC = DiscoverProfileViewController()
		exploreProfileVC.trainer = trainer
		self.navigationController?.pushViewController(exploreProfileVC, animated: true)
	
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
	
	func handleSelectImage() {
		
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

	
	func handleSend() {
		
		guard let teamID = teamModel?.workoutID else {
			return
		}
		
		let ref = FIRDatabase.database().reference().child("TeamMessages")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		if self.imageUrl != nil {
			
			let values = ["imageUrl": imageUrl!,
			              "message" : inputTextField.text!,
			              "userSending": userID,
			              "userSendingName": userName!,
			              "userSendingImageURL": userImageURL!,
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
			
		} else {
			
			let values = ["imageUrl": "",
			              "message" : inputTextField.text!,
			              "userSending": userID,
			              "userSendingName": userName!,
			              "userSendingImageURL": userImageURL!,
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
