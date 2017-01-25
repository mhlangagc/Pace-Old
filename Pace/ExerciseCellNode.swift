//
//  ExerciseCellNode.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2016/12/12.
//  Copyright © 2016 Pace. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ExerciseCellNode: BaseCell {
	
	let exerciseImageNode = ASImageNode()
	let exerciseNameText = ASTextNode()
	let exerciseDetailsText = ASTextNode()
	let downFacingDisclosureIndicator = ASImageNode()
	let lineNode = ASDisplayNode()
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.darkBlack() : UIColor.black
		}
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? UIColor.darkBlack() : UIColor.black
		}
	}
	
	override func setupNodes() {
		
		super.setupNodes()
		self.setupExerciseDetails()
		
		backgroundColor = .black
		
	}
	
	func setupExerciseDetails() {
		
		exerciseImageNode.image = UIImage(named: "box")
		exerciseImageNode.contentMode = .scaleAspectFit
		exerciseImageNode.clipsToBounds = true
		exerciseImageNode.layer.cornerRadius = 6.0
		addSubnode(exerciseImageNode)
		
		exerciseNameText.attributedText = NSAttributedString(
			string: "Leg Stretches",
			attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold),
			             NSForegroundColorAttributeName: UIColor.white,
			             NSKernAttributeName: 0.0
			])
		addSubnode(exerciseNameText)
		
		
		
		
		exerciseDetailsText.attributedText = NSAttributedString(
			string: "3 mins",
			attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold),
			             NSForegroundColorAttributeName: UIColor.greyBlackColor(),
			             NSKernAttributeName: 0.0
			])
		addSubnode(exerciseDetailsText)
		
		
		
		downFacingDisclosureIndicator.image = UIImage(named: "downIndicator")
		downFacingDisclosureIndicator.contentMode = .scaleAspectFit
		downFacingDisclosureIndicator.layer.masksToBounds = true
		addSubnode(downFacingDisclosureIndicator)
		
		
		lineNode.backgroundColor = UIColor.headerBlack()
		addSubnode(lineNode)
		
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		exerciseImageNode.style.preferredSize = CGSize(width: 90.0, height: 90.0)
		exerciseNameText.style.preferredSize = CGSize(width: constrainedSize.max.width - 155.0, height: 25.0)
		exerciseDetailsText.style.preferredSize = CGSize(width: constrainedSize.max.width - 155.0, height: 20.0)
		downFacingDisclosureIndicator.style.preferredSize = CGSize(width: 13.0, height: 13.0)
		lineNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1.0)
		
		let textDetailsSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 10.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [exerciseNameText, exerciseDetailsText])
		
		let imageAndTextSpec = ASStackLayoutSpec(direction: .horizontal,
		                                         spacing: 15.0,
		                                         justifyContent: .center,
		                                         alignItems: .center,
		                                         children: [exerciseImageNode, textDetailsSpec])
		
		let detailAndDisclosureIndicatorSpec = ASStackLayoutSpec(direction: .horizontal,
		                                                         spacing: 10.0,
		                                                         justifyContent: .center,
		                                                         alignItems: .center,
		                                                         children: [imageAndTextSpec, downFacingDisclosureIndicator])
		
		let exerciseWithoutLinesInserts = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 20.0, bottom: 9.0, right: 20.0), child: detailAndDisclosureIndicatorSpec)
		
		let lineAndDetailSpec = ASStackLayoutSpec(direction: .vertical,
		                                          spacing: 1.0,
		                                          justifyContent: .start,
		                                          alignItems: .start,
		                                          children: [exerciseWithoutLinesInserts, lineNode])
		
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), child: lineAndDetailSpec)
		
	}
	
	
}

