//
//  ClubsTableViewCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ClubsTableViewCell : TableBaseCell {

	/*
	let ClubCellID = "ClubCellID"
	var userName = String()
	var userImageURL = String()
	var clubsCollectionView : UICollectionView?
	var clubsArray = [ClubModel]()
	var usersUsingWorkoutArray = [User]()
	var trainer = User()
	
	lazy var teamsSetup: PaceAppServices = {
		
		let teamSetup = PaceAppServices()
		return teamSetup
		
	}()
	
	lazy var profileSetup: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	func setupClubsCollectionView() {
		
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .vertical
		flowLayout.minimumInteritemSpacing  = 10
		flowLayout.minimumLineSpacing       = 10
		flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 20.0, right: 5.0)
		clubsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		
		profileSetup.retrieveUser(completion: { (userFound) in
			
			if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
				
				self.userName = userName
				self.userImageURL = profileImageURL
				
			}
			
		})
		
		teamsSetup.retrieveUserClubs { (clubsArray) in
			
			self.clubsArray = clubsArray
			self.clubsCollectionView?.reloadData()
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			
		}
		
		
	}
	*/
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .red
		
	}
	
//	func numberOfSections(in collectionView: UICollectionView) -> Int {
//	
//		return 1
//		
//	}
//	
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		
//		return 3
//		
//	}
	
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	
//		var clubCell = tableView.dequeueReusableCell(withIdentifier: ClubCellID) as? ClubCollectionViewCell
//		
//		if (clubCell == nil) {
//			tableView.register(ClubsTableViewCell.self, forCellReuseIdentifier: clubCellID)
//			clubCell = tableView.dequeueReusableCell(withIdentifier: ClubCellID) as? ClubsTableViewCell
//		}
//		
//		if (clubCell!.selectedBackgroundView != nil) {
//			
//			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: clubCell!.frame.size.width, height: clubCell!.frame.size.height))
//			backgroundView.backgroundColor = .red //UIColor.closeBlack()
//			clubCell!.selectedBackgroundView = backgroundView
//		}
//		
//		clubCell?.backgroundColor = .red
//		
//		return clubCell!
		
//	}
	
}


class ClubCollectionViewCell : CollectionBaseCell  {

	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .yellow
		
	}
	
}
