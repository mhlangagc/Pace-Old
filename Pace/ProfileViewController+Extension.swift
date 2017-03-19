//
//  ProfileViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

extension ProfileViewController {
	
	func numberOfSections(in tableView: UITableView) -> Int {
	
		return 1
	
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 4
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var settingsCell = tableView.dequeueReusableCell(withIdentifier: runsCellID) as? SettingsCellView
		
		if (settingsCell == nil) {
			tableView.register(SettingsCellView.self, forCellReuseIdentifier: runsCellID)
			settingsCell = tableView.dequeueReusableCell(withIdentifier: runsCellID) as? SettingsCellView
		}
		
		if (settingsCell!.selectedBackgroundView != nil) {
			
			let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: settingsCell!.frame.size.width, height: settingsCell!.frame.size.height))
			backgroundView.backgroundColor = UIColor.darkBlack()
			settingsCell!.selectedBackgroundView = backgroundView
		}
		
		return settingsCell!
		
	}
	
}
