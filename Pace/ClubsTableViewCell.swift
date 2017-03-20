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

class ClubsTableViewCell : TableBaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

	let ClubViewCellID = "ClubCellID"
	var userName = String()
	var userImageURL = String()
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
	
	lazy var clubsCollectionView : UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 16.0
		layout.minimumLineSpacing = 16.0
		layout.scrollDirection = .horizontal
		let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 210)
		let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor.closeBlack()
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
		
	}()
	
	
	
	
	override func setupViews() {
		super.setupViews()
		
		clubsCollectionView.dataSource = self
		clubsCollectionView.delegate = self
		clubsCollectionView.register(ClubCollectionViewCell.self, forCellWithReuseIdentifier: ClubViewCellID)
		addSubview(clubsCollectionView)
		
		profileSetup.retrieveUser(completion: { (userFound) in
			
			if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
				
				self.userName = userName
				self.userImageURL = profileImageURL
				
			}
			
		})
		
		teamsSetup.retrieveUserClubs { (clubsArray) in
			
			self.clubsArray = clubsArray
			self.clubsCollectionView.reloadData()
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			
		}
		
		backgroundColor = .closeBlack()
		
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
	
		return 1
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return 5
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	
		var clubCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClubViewCellID, for: indexPath) as? ClubCollectionViewCell
		
		if (clubCell == nil) {
			collectionView.register(ClubCollectionViewCell.self, forCellWithReuseIdentifier: ClubViewCellID)
			clubCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClubViewCellID, for: indexPath) as? ClubCollectionViewCell
		}
		
		if (clubCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: clubCell!.frame.size.width, height: clubCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.yellow
			clubCell!.selectedBackgroundView = backgroundView
		}
		
		clubCell?.backgroundColor = .yellow
		
		return clubCell!
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 130, height: 200)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 5.0, left: 16.0, bottom: 5.0, right: 16.0)
	}
	
}



