//
//  ProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension ProfileViewController {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let sectionHeaderView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
		sectionHeaderView.backgroundColor = UIColor.black
		
		
		let sectionHeaderLabel: UILabel = UILabel.init(frame: CGRect(x: 20.0, y: 16.0, width: tableView.frame.width - 20, height: 24))
		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
		sectionHeaderLabel.textColor = UIColor.greyWhite()
		sectionHeaderLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
		sectionHeaderView.addSubview(sectionHeaderLabel)
		
		
		return sectionHeaderView
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 55.0
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return "ALL RUNS"
		
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
	
		return 1
	
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	
		return 120
	
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return userRunsArray.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var runsCell = tableView.dequeueReusableCell(withIdentifier: runsCellID) as? RunsCellView
		
		if (runsCell == nil) {
			tableView.register(RunsCellView.self, forCellReuseIdentifier: runsCellID)
			runsCell = tableView.dequeueReusableCell(withIdentifier: runsCellID) as? RunsCellView
		}
		
		if (runsCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: runsCell!.frame.size.width, height: runsCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			runsCell!.selectedBackgroundView = backgroundView
		}
		
		runsCell?.runsModel = userRunsArray[indexPath.item]
		return runsCell!
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}
