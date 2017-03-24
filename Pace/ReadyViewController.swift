//
//  ReadyViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/23.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController {
	
	var club: ClubModel?
	var musicPlayerView : MusicPlayerView?
	lazy var goButtonView: GoButtonView = {
		
		let view = GoButtonView()
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleStartRunning)))
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	
	}()
	
	@IBOutlet weak var totalKMLabel: UILabel!
	@IBOutlet weak var totalRunsLabel: UILabel!
	@IBOutlet weak var averagePaceLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = .closeBlack()
		self.setupNavBar()
		self.configureViews()
		self.setupPlayerView()
		self.setupGoButtonView()
       
    }
	
	func setupGoButtonView() {
	
		self.view.addSubview(goButtonView)
		
		goButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		goButtonView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		goButtonView.heightAnchor.constraint(equalToConstant: 190).isActive = true
		goButtonView.widthAnchor.constraint(equalToConstant: 190).isActive = true
		
	}
	
	func setupNavBar() {
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Ready"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		
		let closeButton = UIButton(type: .system)
		closeButton.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
		closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		closeButton.addTarget(self, action: #selector(handleClose), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
		
		
	}
	
	func configureViews() {
		
		totalKMLabel.font = UIFont(name: "BebasNeueBold", size: 42)
		totalRunsLabel.font = UIFont(name: "BebasNeueBold", size: 42)
		averagePaceLabel.font = UIFont(name: "BebasNeueBold", size: 42)
		
		textSpacing(totalKMLabel, spacing: 2.4)
		textSpacing(totalRunsLabel, spacing: 2.4)
		textSpacing(averagePaceLabel, spacing: 2.4)
		
		
	}
	
	func setupPlayerView() {
		
		var frameHeight = CGFloat()
		var frameWidth = CGFloat()
		
		if let window = UIApplication.shared.keyWindow {
			
			frameHeight = window.frame.height
			frameWidth = window.frame.width
			
		}
		musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: frameHeight - 149, width: frameWidth, height: 85.0))
		self.view.addSubview(musicPlayerView!)
		
	}
	
	func handleClose() {
		
		self.dismiss(animated: true) { 
			
			//	TO DO
			
			
		}
	}
	
	func handleStartRunning() {
		
		self.navigationController?.pushViewController(RunViewController(), animated: true)
		
	}

    
}
