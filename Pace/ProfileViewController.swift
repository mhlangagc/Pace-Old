//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var profileTableView : UITableView?
	let runsCellID = "runsCellID"
	var profileHeaderView =  ProfileTabHeaderView()
	var user : User?

	lazy var profileSetup: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.grouped)
		profileTableView?.backgroundColor = UIColor.closeBlack()
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		view.addSubview(profileTableView!)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		profileTableView?.register(RunsCellView.self, forCellReuseIdentifier: runsCellID)
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Me"
		view.backgroundColor = .black
		self.navigationBarItems()
		self.setupWorkoutDetailsTableView()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Me"
		navigationNoLineBar()
		self.navigationBarItems()
		self.setupRightNavItems()
		self.setupHeaderView()
		self.profileTableView?.reloadData()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Me"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	
	}
	
	private func setupRightNavItems() {
		
		let composeButton = UIButton(type: .system)
		composeButton.setImage(#imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), for: .normal)
		composeButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		composeButton.addTarget(self, action: #selector(handleOpenSettings), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: composeButton)
	
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func sizeHeaderToFit() {
		
		profileHeaderView.setNeedsLayout()
		profileHeaderView.layoutIfNeeded()
		
		let height = profileHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = profileHeaderView.frame
		frame.size.height = height
		profileHeaderView.frame = frame
	}
	
	func setupHeaderView() {
		
		profileHeaderView  = ProfileTabHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380.0))
		
		profileSetup.retrieveUser(completion: { (userFound) in
			
			
			
			if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl {
				
				self.profileHeaderView.profileNameButton?.setTitle(userName, for: UIControlState.normal)
				self.profileHeaderView.profileImageView?.loadImageFromUrlString(urlString: profileImageURL)
			}
			
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
			
		})
		
		profileTableView?.tableHeaderView = profileHeaderView
		
	}
	
	
	func handleOpenSettings() {
		
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
		
	}
	
}

