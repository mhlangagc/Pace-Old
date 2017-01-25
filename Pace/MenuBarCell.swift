//
//  MenuBarCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/16.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit

class MenuBarCell: CollectionViewBaseCell {
	
	let barLabel: UILabel = {
		
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
		label.textAlignment = .center
		label.textColor = UIColor.greyBlackColor()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let roundedBackground : UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor.darkBlack()
		view.layer.cornerRadius = 6.0
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
		
	}()
	
	
	
	override var isHighlighted: Bool {
		didSet {
			barLabel.textColor = isHighlighted ? UIColor.white : UIColor.greyBlackColor()
			roundedBackground.backgroundColor = isHighlighted ? UIColor.black : UIColor.darkBlack()
		}
	}
	
	override var isSelected: Bool {
		didSet {
			barLabel.textColor = isSelected ? UIColor.white : UIColor.greyBlackColor()
			roundedBackground.backgroundColor = isSelected ? UIColor.black : UIColor.darkBlack()
		}
	}
	
	override func setupViews() {
		super.setupViews()
		
		addSubview(roundedBackground)
		roundedBackground.addSubview(barLabel)
		
		
		roundedBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 2.0).isActive = true
		roundedBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: -2.0).isActive = true
		roundedBackground.topAnchor.constraint(equalTo: topAnchor, constant: -16.0).isActive = true
		roundedBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22.0).isActive = true
		
		
		barLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		barLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		barLabel.topAnchor.constraint(equalTo: topAnchor, constant: -10).isActive = true
		barLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
		
	}
	
}
