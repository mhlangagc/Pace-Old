//
//  ConversationViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/26.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
	
	var chatModel: ChatGroupModel?
	var containerViewBottomAnchor: NSLayoutConstraint?
	let ChatMessageCellID = "ChatMessageCellID"
	
	lazy var inputTextField: UITextField = {
		
		let textField = TextField()
		textField.borderStyle = .none
		textField.keyboardType = .default
		textField.keyboardAppearance = .dark
		textField.backgroundColor = .black
		textField.autocapitalizationType = .sentences
		textField.textColor = UIColor.white
		textField.layer.cornerRadius = 42.0 * 0.5
		textField.layer.borderWidth = 1.0
		textField.layer.borderColor = UIColor.darkBlack().cgColor
		textField.tintColor = UIColor.paceBrandColor()
		textField.attributedPlaceholder = NSAttributedString(string:"talk to the team...",
		                                                     attributes:[NSForegroundColorAttributeName: UIColor.greyBlackColor()])
		textField.returnKeyType = .send
		textField.sizeToFit()
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
		
	}()
	
	let chatContainerView : UIView = {
	
		let view = UIView()
		view.backgroundColor = UIColor.black
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	
	}()
	
	lazy var sendButton: UIButton = {
		
		let button = UIButton()
		button.isEnabled = false
		button.setImage(UIImage(named: "send_inActive"), for: UIControlState.normal)
		button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()

	
	let chatMenuBar: ChatMenuBar = {
		
		let menuBar = ChatMenuBar()
		menuBar.translatesAutoresizingMaskIntoConstraints = false
		return menuBar
		
	}()
	
	func setupCollectionView() {
		
		collectionView?.contentInset = UIEdgeInsets(top: 58, left: 0, bottom: 62, right: 0)
		collectionView?.alwaysBounceVertical = true
		collectionView?.backgroundColor = UIColor.black
		collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: ChatMessageCellID)
		collectionView?.keyboardDismissMode = .interactive
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black
		navigationItem.title = chatModel?.groupWorkout
		self.setupCollectionView()
		navigationNoLineBar()
		self.setupChatMenuBar()
		//self.setupNavBarItems()
		self.setupInputComponents()
		self.setupKeyboardObservers()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.tintColor = UIColor.white
		
	}
	
	private func setupChatMenuBar() {
		
		view.addSubview(chatMenuBar)
		
		chatMenuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		chatMenuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		chatMenuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		chatMenuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
	}
	
	func setupNavBarItems() {
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleClose))
		
	}
	
	func setupInputComponents() {
		
		view.addSubview(chatContainerView)
		chatContainerView.addSubview(sendButton)
		chatContainerView.addSubview(inputTextField)
		inputTextField.delegate = self
		
		
		chatContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		chatContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		chatContainerView.heightAnchor.constraint(equalToConstant: 56).isActive = true
		containerViewBottomAnchor = chatContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		containerViewBottomAnchor?.isActive = true
		
		
		sendButton.rightAnchor.constraint(equalTo: chatContainerView.rightAnchor, constant: -20.0).isActive = true
		sendButton.centerYAnchor.constraint(equalTo: chatContainerView.centerYAnchor).isActive = true
		sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		inputTextField.leftAnchor.constraint(equalTo: chatContainerView.leftAnchor, constant: 15).isActive = true
		inputTextField.centerYAnchor.constraint(equalTo: chatContainerView.centerYAnchor).isActive = true
		inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10.0).isActive = true
		inputTextField.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
		
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
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		handleSend()
		return true
		
	}
	
	override var inputAccessoryView: UIView? {
		get {
			return chatContainerView
		}
	}
	
	
	func handleSendingInvitation() {
		
		// TO DO
		print("Sending Invitation to Friend")
		
		
	}
	
	func handleSend() {
		
		//	TO DO
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

