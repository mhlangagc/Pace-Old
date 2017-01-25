//
//  CollectionNodeBaseCell.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/10.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class BaseCell : ASCellNode {
	
	
	override init() {
		super.init()
		
		self.setupNodes()
		
	}
	
	func setupNodes() {
		
		
	}
	
}


class CollectionBaseCell: UICollectionViewCell {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews() {
		
	}
}



class TableBaseCell: UITableViewCell {
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		
		super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
		
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews() {
		
		
		
	}
	
}
