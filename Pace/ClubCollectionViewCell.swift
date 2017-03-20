//
//  ClubCollectionViewCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/20.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubCollectionViewCell : CollectionBaseCell  {
	
	let clubImage: UIImageView = {
		
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor.darkBlack()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 114 * 0.5
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	let clubNameLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyWhite()
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let clubDetailsLabel: UILabel = {
		
		let label = UILabel()
		label.textColor = UIColor.greyBlackColor()
		label.numberOfLines = 1
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	var clubModel : ClubModel? {
		
		didSet {
			
			if let clubImageURL = clubModel?.backgroundImageUrl {
				
				clubImage.loadImageFromCacheWithUrlString(urlString: clubImageURL)
				
			}
			
			if let clubName = clubModel?.name, let clubRuns = clubModel?.totalRuns {
				
				clubNameLabel.text = clubName
				clubDetailsLabel.text = "\(clubRuns) km"
			}
			
		}
	}
	
	
	override func setupViews() {
		super.setupViews()
		
		self.setupClubCell()
		
	}
	
	
	
	func setupClubCell() {
		
		addSubview(clubImage)
		addSubview(clubNameLabel)
		addSubview(clubDetailsLabel)
		
		clubImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		clubImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		clubImage.heightAnchor.constraint(equalToConstant: 114).isActive = true
		clubImage.widthAnchor.constraint(equalToConstant: 114).isActive = true
		
		clubNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		clubNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		clubNameLabel.topAnchor.constraint(equalTo: clubImage.bottomAnchor, constant: 10).isActive = true
		clubNameLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
		
		clubDetailsLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		clubDetailsLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		clubDetailsLabel.topAnchor.constraint(equalTo: clubNameLabel.bottomAnchor, constant: 8).isActive = true
		clubDetailsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
	
		
	}
	
}
