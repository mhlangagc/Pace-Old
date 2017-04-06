//
//  ChatImageSelectionBarView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatImageSelectionBarView: BaseView {
	
	var chatVC : ClubChatViewController?
	
	lazy var cameraButton: UIButton = {

		let button = UIButton()
		button.setImage(UIImage(named: "cameraSelection"), for: UIControlState.normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.layer.cornerRadius = 8.0
		button.backgroundColor = UIColor(fromHexString: "14161B")
		button.layer.masksToBounds = true
		button.imageEdgeInsets = UIEdgeInsets(top: 44, left: 40, bottom: 44, right: 40)
		button.addTarget(self, action: #selector(handleCameraSelection), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	lazy var imageViewButton: UIButton = {
		
		let button = UIButton()
		button.setImage(UIImage(named: "ImageSelection"), for: UIControlState.normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.layer.cornerRadius = 8.0
		button.layer.masksToBounds = true
		button.backgroundColor = UIColor(fromHexString: "14161B")
		button.imageEdgeInsets = UIEdgeInsets(top: 44, left: 40, bottom: 44, right: 40)
		button.addTarget(self, action: #selector(handleImageSelection), for: UIControlEvents.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
		
	}()
	
	let line: UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor(fromHexString: "282C36")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .black
		self.configureViews()
		
	}
	
	func configureViews() {
		
		addSubview(self.line)
		line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		line.topAnchor.constraint(equalTo: topAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
		
		addSubview(cameraButton)
		cameraButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		cameraButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		cameraButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
		cameraButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
		
		addSubview(imageViewButton)
		imageViewButton.leftAnchor.constraint(equalTo: cameraButton.rightAnchor, constant: 32).isActive = true
		imageViewButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		imageViewButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
		imageViewButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
		
	}
	
	func handleCameraSelection() {
		
		chatVC?.handleCameraOpen()
		
	}
	
	func handleImageSelection() {
		
		chatVC?.handlePickImage()
	}
}
