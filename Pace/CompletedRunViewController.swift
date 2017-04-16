//
//  CompletedRunViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/23.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import HealthKit

class CompletedRunViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
	
	var headerView =  CompletedRunHeaderView()
	var trainer = User()
	let exerciseCellID = "exerciseCellID"
	
	var run: RunModel?
	var mapOverlay: MKTileOverlay?
	
	
	lazy var paceAppService: PaceAppServices = {
		
		let postWorkoutToClubDetails = PaceAppServices()
		return postWorkoutToClubDetails
		
	}()
	
	override var prefersStatusBarHidden: Bool {
		
		return false
		
	}
	
	let shareWorkoutBar : ShareButtonView = {
		
		let shareWorkoutBar = ShareButtonView()
		shareWorkoutBar.translatesAutoresizingMaskIntoConstraints = false
		return shareWorkoutBar
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupNavigationBar()
		self.setupshareWorkoutBar()
		view.backgroundColor = UIColor.black
		self.setupWorkoutCompletedTableView()
		self.setupHeaderView()
		self.configureViewDetails()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Run Completed"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
		
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleNothing))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(handleDoneWorkout))
		self.navigationController?.navigationBar.barTintColor = UIColor.darkerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkerBlack()
		
	}
	
	lazy var workoutCompletedTableView : UITableView = {
		
		let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
		tableView.backgroundColor = .closeBlack()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
		
	}()
	
	func setupWorkoutCompletedTableView() {
		
		view.addSubview(workoutCompletedTableView)
		workoutCompletedTableView.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		
		workoutCompletedTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		workoutCompletedTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		workoutCompletedTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		workoutCompletedTableView.bottomAnchor.constraint(equalTo: shareWorkoutBar.topAnchor).isActive = true
		
		
		
	}
	
	func setupshareWorkoutBar() {
		
		view.addSubview(shareWorkoutBar)
		shareWorkoutBar.completedWorkoutVC = self
		
		shareWorkoutBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		shareWorkoutBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		shareWorkoutBar.heightAnchor.constraint(equalToConstant: 62).isActive = true
		shareWorkoutBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func sizeHeaderToFit() {
		
		headerView.setNeedsLayout()
		headerView.layoutIfNeeded()
		
		let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = headerView.frame
		frame.size.height = height
		headerView.frame = frame
		
	}
	
	func setupHeaderView() {
		
		headerView  = CompletedRunHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 520.0))
		headerView.runMapView?.delegate = self
		workoutCompletedTableView.tableHeaderView = headerView
		
	}
	
	
	//	Time
	var mins : Int?
	var secs : Int?
	
	//	Distance
	var distance: String?
	
	//	Pace 
	var pace: String?
	
	func configureViewDetails() {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		self.navigationController?.navigationItem.title = dateFormatter.string(from: (run?.timestamp as Date?)!)
		
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int((run?.duration)!))
		let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: Double(s))
		let minutesQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: Double(m))
		_ = HKQuantity(unit: HKUnit.hour(), doubleValue: Double(h))
		
		secs = Int(secondsQuantity.doubleValue(for: HKUnit.second()))
		mins = Int(minutesQuantity.doubleValue(for: HKUnit.minute()))
		headerView.runningDurationLabel?.text = "\(String(format: "%02d", mins!)):\(String(format: "%02d", secs!))"
		
		
		let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: Double((run?.distance)!)).doubleValue(for: HKUnit.meter())
		distance = "\((distanceQuantity/1000).roundToPlaces(places: 2))"
		headerView.distanceLabel?.text = distance
		
		let minutes = Double((run?.duration)!)/60.0
		let kilometers = Double((run?.distance)!)/1000
		if minutes/kilometers == Double.infinity {
			
			headerView.paceNumberLabel?.text = "0.00"
			
		} else {
			
			pace = "\(String((minutes/kilometers).roundToPlaces(places: 2)))"
			headerView.paceNumberLabel?.text = "\(String((minutes/kilometers).roundToPlaces(places: 2)))"
			
		}
		
		
		self.loadMap()
		
	}
	
	func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
		
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
		
	}
	
	func loadMap() {
		
		if (run?.locations?.count)! > 0 {
			
			headerView.runMapView?.isHidden = false
//			let template = "https://api.mapbox.com/styles/v1/spitfire4466/citl7jqwe00002hmwrvffpbzt/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic3BpdGZpcmU0NDY2IiwiYSI6Im9jX0JHQUUifQ.2QarbK_LccnrvDg7FobGjA"
//			
//			mapOverlay = MKTileOverlay(urlTemplate: template)
//			mapOverlay?.canReplaceMapContent = true
//			
//			headerView.runMapView?.add(mapOverlay!,level: .aboveLabels)
			
			// Set the map bounds
			headerView.runMapView?.region = mapRegion()
			
			// Make the line(s!) on the map
			let colorSegments = MulticolorPolylineSegment.colorSegments(forLocations: run?.locations?.array as! [LocationModel])
			
			headerView.runMapView?.addOverlays(colorSegments)
			
		} else {
			
			// No locations were found!
			headerView.runMapView?.isHidden = true
			
			print("Sorry, this run has no locations saved")
			
		}
	}
	
	func mapRegion() -> MKCoordinateRegion {
		let initialLoc = run?.locations?.firstObject as! LocationModel
		
		var minLat = Double(initialLoc.latitude)
		var minLng = Double(initialLoc.longitude)
		var maxLat = minLat
		var maxLng = minLng
		
		let locations = run?.locations?.array as! [LocationModel]
		
		for location in locations {
			
			minLat = min(minLat, Double(location.latitude))
			minLng = min(minLng, Double(location.longitude))
			maxLat = max(maxLat, Double(location.latitude))
			maxLng = max(maxLng, Double(location.longitude))
		}
		
		return MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
			                               longitude: (minLng + maxLng)/2),
			span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.1,
			                       longitudeDelta: (maxLng - minLng)*1.1))
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
	
		if overlay is MKTileOverlay{
			guard let tileOverlay = overlay as? MKTileOverlay else {
				return MKOverlayRenderer()
			}
			
			return MKTileOverlayRenderer(tileOverlay: tileOverlay)
		}
		if overlay is MulticolorPolylineSegment {
			let polyline = overlay as! MulticolorPolylineSegment
			let renderer = MKPolylineRenderer(polyline: polyline)
			renderer.strokeColor = polyline.color
			renderer.lineWidth = 3
			return renderer
		}
		return MKOverlayRenderer()
	}
	
	func polyline() -> MKPolyline {
		
		var coords = [CLLocationCoordinate2D]()
		
		let locations = run?.locations?.array as! [LocationModel]
		for location in locations {
			coords.append(CLLocationCoordinate2D(latitude: Double(location.latitude),
			                                     longitude: Double(location.longitude)))
		}
		
		return MKPolyline(coordinates: &coords, count: run!.locations!.count)
	
	}
	
	
	func handlePostDataToUser(completion: @escaping ()->()) {
		 
		let ref = FIRDatabase.database().reference().child("ClubRuns")
		let childRef = ref.childByAutoId()
		let userID = FIRAuth.auth()!.currentUser!.uid
		
		
		let values = ["userRunning": userID,
		              "userName": usersName,
		              "userImageURL": usersImageURL,
		              "timeStamp": Int(NSDate().timeIntervalSince1970),
		              "minutes" : mins!,
		              "seconds" : secs!,
		              "distance" : distance!,
		              "pace" : pace!,
		              "teamID": clubID] as [String : Any]
		
		childRef.updateChildValues(values) { (error, ref) in
			
			if error != nil {
				print((error?.localizedDescription)!)
				return
			}
			
			let clubRunsRef = FIRDatabase.database().reference().child("fan-club-runs").child(clubID)
			let clubRunId = childRef.key
			clubRunsRef.updateChildValues([clubRunId: 1])
			
			let userRunsRef = FIRDatabase.database().reference().child("fan-user-runs").child(userID)
			let messageId = childRef.key
			userRunsRef.updateChildValues([messageId: 1])
			
			//self.handlePostDataToClub()
			
			completion()
			
		}
		
	}
	
	func handlePostDataToClub() {
		
		let runningClubRef = FIRDatabase.database().reference().child("ClubRunningData")
		let childRef_2 = runningClubRef.childByAutoId()
		let values_2 = ["timeStamp": Int(NSDate().timeIntervalSince1970),
		                "minutes" : self.mins!,
		                "seconds" : self.secs!,
		                "distance" : self.distance!,
		                "pace" : self.pace!,
		                "teamID": clubID] as [String : Any]
		childRef_2.updateChildValues(values_2)
		
		
		let workoutTeamMessagesRef = FIRDatabase.database().reference().child("fan-club-RunningData").child(clubID)
		let messageId_2 = childRef_2.key
		workoutTeamMessagesRef.updateChildValues([messageId_2: 1])
		
	}
	
	
	func handleDoneWorkout() {
		
		self.handlePostDataToUser {
				
			self.dismiss(animated: true) {
				
			}
			
		}
		
	}
	
	func handleNothing() {
	
		//	DO NOTHING
	
	}

	func handleShareWorkout() {
		
		shareLinkVC(linkString: "You've got to check out this workout on Pace. Download the app here : AppLink")
		
	}
	
}

