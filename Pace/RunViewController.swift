//
//  RunViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/22.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import HealthKit

class RunViewController: UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var kmLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var paceLabel: UILabel!
	@IBOutlet weak var runButtton: UIButton!
	
	
	@IBOutlet weak var resumeRun: UIButton!
	@IBOutlet weak var stopRun: UIButton!
	
	var musicPlayerView : MusicPlayerView?
	var run: RunModel?
	lazy var locations = [CLLocation]()
	lazy var timer = Timer()
	var seconds = 0.0
	var distance = 0.0
	var instantPace = 0.0
	var vertClimb = 0.0
	var vertDescent = 0.0
	var previousAlt = 0.0
	
	lazy var locationManager: CLLocationManager = {
  
		var locationManage = CLLocationManager()
		locationManage.delegate = self
		locationManage.desiredAccuracy = kCLLocationAccuracyBest
		locationManage.activityType = .fitness
		//locationManager.pausesLocationUpdatesAutomatically = false
		locationManage.distanceFilter = 10.0
		return locationManage
		
	}()

	var isRunning = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.resumeRun.isHidden = true
		self.stopRun.isHidden = true
        self.configureView()
		self.setupPlayerView()
		self.handleStartRunning()
		
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		navigationNoLineBar()
		self.navigationItem.setHidesBackButton(true, animated: true)
		self.navigationController?.navigationBar.isHidden = false
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		self.navigationController?.navigationBar.isHidden = true
		self.setupLogoNavItem()
		
	}
	
	func eachSecond(_ timer: Timer) {
		
		seconds += 1
		
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(seconds))
		let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: Double(s))
		let minutesQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: Double(m))
		_ = HKQuantity(unit: HKUnit.hour(), doubleValue: Double(h)) //	Hours
		//timeLabel.text = "Time: "+hoursQuantity.description+" "+minutesQuantity.description+" "+secondsQuantity.description
		let secs = Int(secondsQuantity.doubleValue(for: HKUnit.second()))
		let mins = Int(minutesQuantity.doubleValue(for: HKUnit.minute()))
		timeLabel.text = "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
		
		
		let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance.rounded()).doubleValue(for: HKUnit.meter())
		let distanceInKm = (distanceQuantity/1000).roundToPlaces(places: 2)
		kmLabel.text = "\(distanceInKm)"
		
		
		let minutes = seconds/60.0
		let kilometers = distance/1000
		//let pace = minutes/kilometers
		/*
		if pace < 1.0 {
			let paceSeconds = (pace * 60.0).roundToPlaces(places: 0)
			print(paceSeconds)
			paceLabel.text = "00:\(paceSeconds)"
			print(paceLabel.text!)
			
		} else {
			
			paceLabel.text = "\(String(format: "%02d", pace.rounded())):\(String(format: "%02d", pace.truncatingRemainder(dividingBy: pace.rounded())))"
			
		}
		*/
		
		if minutes/kilometers == Double.infinity {
			
			paceLabel.text = "0.00"
			
		} else {
			
			paceLabel.text = "\(String((minutes/kilometers).roundToPlaces(places: 2)))"
			
		}
		
		
	}
	
	func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
	
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
	
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		for location in locations {
			
			if location.horizontalAccuracy < 20 {
				//update distance
				if self.locations.count > 0 {
					distance += location.distance(from: self.locations.last!)
				}
				
				//save location
				self.locations.append(location)
				
			}
			
		}
		
	}
	
	func saveRun(completion: () ->()) {
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context = appDelegate.managedObjectContext
		let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: "RunModel", in: context)!
		let saveRun = RunModel(entity: entityDescription, insertInto: context)
		saveRun.distance = Float(distance)
		saveRun.duration = Int64(seconds)
		saveRun.timestamp = NSDate()
		
		
		var savedLocations = [LocationModel]()
		for location in locations {
			
			let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "LocationModel", in: context)!
			let savedLocation = LocationModel(entity: entity, insertInto: context)
			savedLocation.timestamp = location.timestamp as NSDate?
			savedLocation.latitude = location.coordinate.latitude
			savedLocation.longitude = location.coordinate.longitude
			savedLocations.append(savedLocation)
			
		}
		
		saveRun.locations = NSOrderedSet(array: savedLocations)
		self.run = saveRun
		
		appDelegate.saveContext()
		
		completion()
		
	}
	
	func handleStartRunning() {
		
		isRunning = true
		runButtton.isHidden = false
		runButtton.setImage(#imageLiteral(resourceName: "PauseWorkout"), for: UIControlState.normal)
		locations.removeAll(keepingCapacity: false)
		timer = Timer.scheduledTimer(timeInterval: 1,
		                             target: self,
		                             selector: #selector(eachSecond(_:)),
		                             userInfo: nil,
		                             repeats: true)
		locationManager.startUpdatingLocation()
	}
	
	@IBAction func handlePauseRun(_ sender: Any) {
		
		if isRunning == false {
			
			runButtton.isHidden = false
			runButtton.setImage(#imageLiteral(resourceName: "PauseWorkout"), for: UIControlState.normal)
			isRunning = true
			
			locations.removeAll(keepingCapacity: false)
			timer = Timer.scheduledTimer(timeInterval: 1,
			                             target: self,
			                             selector: #selector(eachSecond(_:)),
			                             userInfo: nil,
			                             repeats: true)
			locationManager.startUpdatingLocation()
			
		} else if isRunning == true {
			
			runButtton.isHidden = true
			resumeRun.isHidden = false
			stopRun.isHidden = false
			
			locationManager.stopUpdatingLocation()
			timer.invalidate()
			isRunning = false
			
		}
		
		
	}
	
	
	@IBAction func handleResumeRun(_ sender: Any) {
		
		isRunning = true
		runButtton.isHidden = false
		resumeRun.isHidden = true
		stopRun.isHidden = true
		
		locations.removeAll(keepingCapacity: false)
		timer = Timer.scheduledTimer(timeInterval: 1,
		                             target: self,
		                             selector: #selector(eachSecond(_:)),
		                             userInfo: nil,
		                             repeats: true)
		locationManager.startUpdatingLocation()
		
	}
	
	@IBAction func handleStopRun(_ sender: Any) {
	
		self.saveRun { 
			
			print("Run Saved")
			let runCompleteVC = CompletedRunViewController()
			runCompleteVC.run = self.run
			self.navigationController?.pushViewController(runCompleteVC, animated: true)
		}
	
	}
	
}

extension RunViewController {
	
	func setupLogoNavItem() {
		
		let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
		titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		titleImageView.contentMode = .scaleAspectFit
		
		navigationItem.titleView = titleImageView
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
	
	}
	
	func configureView() {
		
		kmLabel.font = UIFont(name: "BebasNeueBold", size: 120)
		timeLabel.font = UIFont(name: "BebasNeueBold", size: 42)
		paceLabel.font = UIFont(name: "BebasNeueBold", size: 42)
		textSpacing(timeLabel, spacing: 2.4)
		textSpacing(paceLabel, spacing: 2.4)
		
	}
	
	func setupPlayerView() {
		
		musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: view.frame.height - 149.0, width: view.frame.width, height: 85.0))
		view.addSubview(musicPlayerView!)
	
	}
	
}
