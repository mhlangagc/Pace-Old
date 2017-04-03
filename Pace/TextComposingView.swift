//
//  TextComposingView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class TextComposingView: BaseView {
	
	var clubChatVC: ClubChatViewController?
	
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

	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .black
		self.handleConfigureView()
		
	}
	
	func handleConfigureView() {
		
		addSubview(sendButton)
		addSubview(addImageButton)
		addSubview(inputTextField)
		addSubview(line)
		
		addImageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		addImageButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		addImageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
		addImageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
		
		
		sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		sendButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
		sendButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
		
		
		line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		line.topAnchor.constraint(equalTo: topAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
		
		
		inputTextField.leftAnchor.constraint(equalTo: addImageButton.rightAnchor, constant: 16).isActive = true
		inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -16).isActive = true
		inputTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
		inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
	}
	
	func handleSelectImage() {
		
		//	TO DO
		
	}
	
	
	func textFieldDidChange() {
		
		clubChatVC?.textFieldDidChange()
		
	}
	
	
	func handleSend() {
		
		
		
	}
	
}

