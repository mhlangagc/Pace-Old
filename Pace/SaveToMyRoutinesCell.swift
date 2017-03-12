//
//  SaveToMyRoutines.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/12.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class SaveToMyRoutinesCell: TableBaseCell {
	
	let backgroundButtonView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 8.0
		view.layer.masksToBounds = true
		view.backgroundColor = UIColor.darkBlack()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let buttonLabel: UILabel = {
		
		let label = UILabel()
		label.text = "SAVE TO MY ROUTINES".uppercased()
		label.textColor = UIColor.paceBrandColor()
		label.textAlignment = .center
		textSpacing(label, spacing: 0.5)
		label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()

	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.headerBlack() : UIColor.black
		}
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.black
		self.setupObjectsView()
	}
	
	
	func setupObjectsView() {
		
		self.contentView.addSubview(backgroundButtonView)
		self.backgroundButtonView.addSubview(buttonLabel)
		
		backgroundButtonView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
		backgroundButtonView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
		backgroundButtonView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
		backgroundButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
		
		buttonLabel.leftAnchor.constraint(equalTo: backgroundButtonView.rightAnchor).isActive = true
		buttonLabel.topAnchor.constraint(equalTo: backgroundButtonView.topAnchor).isActive = true
		buttonLabel.rightAnchor.constraint(equalTo: backgroundButtonView.leftAnchor).isActive = true
		buttonLabel.bottomAnchor.constraint(equalTo: backgroundButtonView.bottomAnchor).isActive = true

		
	}
	
}

