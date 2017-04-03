//
//  ClubChatCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/03.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ClubChatCell: CollectionBaseCell {
	
	var  messagesModel : TeamMessagesModel? {
		
		didSet {
			
		
		}
	
		
	}
	
	override func setupViews() {
		super.setupViews()
		
		backgroundColor = UIColor.yellow //.closeBlack()
		
	}
	
}
