//
//  ClubViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/06.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension ClubViewController {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 42))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 15.0, width: tableView.frame.width - 20, height: 24))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyBlackColor()
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 55.0
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return "\(members.count) MEMBERS"
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 70.0
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return members.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var clubCell = tableView.dequeueReusableCell(withIdentifier: ClubDetailsCellID) as? ClubDetailsCell
		
		if (clubCell == nil) {
			tableView.register(ClubDetailsCell.self, forCellReuseIdentifier: ClubDetailsCellID)
			clubCell = tableView.dequeueReusableCell(withIdentifier: ClubDetailsCellID) as? ClubDetailsCell
		}
		
		
		if (clubCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: clubCell!.frame.size.width, height: clubCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			clubCell!.selectedBackgroundView = backgroundView
		}
		
		clubCell?.userMember = members[indexPath.item]
		clubCell?.backgroundColor = UIColor.black
		
		return clubCell!
		
	}
	
	//  TableView Delegation
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath as IndexPath, animated: true)
		
		let profileVC = UserProfileViewController()
		profileVC.user = self.members[indexPath.item]
		self.navigationController?.pushViewController(profileVC, animated: true)
		
	}
	
	
}

