//
//  GoButtonView.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/24.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class GoButtonView : BaseView {
	
	var goLabel: UILabel = {
		
		let label = UILabel()
		label.text = "GO"
		label.font =  UIFont(name: "BebasNeueBold", size: 60)
		label.textAlignment = .center
		label.textColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false 
		return label
		
	}()
	
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = .closeBlack()
		self.layer.cornerRadius = 190.0 * 0.5
		self.layer.masksToBounds = true
		self.layer.borderColor = UIColor.paceBrandColor().cgColor
		self.layer.borderWidth = 20.0
		self.configureView()
	}
	
	func configureView() {
		
		addSubview(goLabel)
		
		goLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		goLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		goLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
		goLabel.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
		
	}
	
}

