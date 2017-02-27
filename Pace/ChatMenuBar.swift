//
//  ChatMenuBar.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/27.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ChatMenuBar: BaseView, UICollectionViewDataSource, UICollectionViewDelegate {

	var chatVC : ChatViewController?
	 let teamProfileCellID = "teamProfileCellID"
	
	lazy var teamMembersCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 15
		layout.minimumLineSpacing = 15
		layout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor.black
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.isScrollEnabled = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
		
	}()
	
	let dividerLineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.addViews()
		
	}
	
	func addViews() {
		
		teamMembersCollectionView.register(TeamMemberCell.self, forCellWithReuseIdentifier: teamProfileCellID)
		addSubview(teamMembersCollectionView)
		addSubview(dividerLineView)
		
		teamMembersCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		teamMembersCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		teamMembersCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		teamMembersCollectionView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
		
		dividerLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
		dividerLineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		dividerLineView.heightAnchor.constraint(equalToConstant: 0.9).isActive = true
		
	}
	
	
}

extension ChatMenuBar {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		
		return 1
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return 7
	
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let chatProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: teamProfileCellID, for: indexPath) as! TeamMemberCell
		
		return chatProfileCell
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		
		return CGSize(width: 30.0, height: 30.0)
	
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if indexPath.item == 6 {
			
			chatVC?.handleSendingInvitation()
			
		}
	}
	
}
