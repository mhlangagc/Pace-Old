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
	var workoutCompletedTableView : UITableView?
	var trainer = User()
	var club : ClubModel?
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupWorkoutCompletedTableView()
		self.setupNavigationBar()
		view.backgroundColor = UIColor.closeBlack()
		workoutCompletedTableView?.register(ExerciseCellView.self, forCellReuseIdentifier: exerciseCellID)
		self.setupHeaderView()
		self.configureViewDetails()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.setupNavigationBar()
		
	}
	
	func setupNavigationBar() {
		
		navigationNoLineBar()
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareVC"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleShareWorkout))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(handleDoneWorkout))
		self.navigationController?.navigationBar.barTintColor = UIColor.darkerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkerBlack()
		
	}
	
	func setupWorkoutCompletedTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		workoutCompletedTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.plain)
		workoutCompletedTableView?.backgroundColor = .closeBlack()
		workoutCompletedTableView?.delegate = self
		workoutCompletedTableView?.dataSource = self
		workoutCompletedTableView?.separatorStyle = .none
		workoutCompletedTableView?.showsVerticalScrollIndicator = false
		view.addSubview(workoutCompletedTableView!)
		
		
		
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
		
		headerView  = CompletedRunHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 667.0))
		headerView.runMapView?.delegate = self
		workoutCompletedTableView?.tableHeaderView = headerView
		
	}
	
	func configureViewDetails() {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		self.navigationController?.navigationItem.title = dateFormatter.string(from: run?.timestamp as! Date)
		
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int((run?.duration)!))
		let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: Double(s))
		let minutesQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: Double(m))
		_ = HKQuantity(unit: HKUnit.hour(), doubleValue: Double(h))
		let secs = Int(secondsQuantity.doubleValue(for: HKUnit.second()))
		let mins = Int(minutesQuantity.doubleValue(for: HKUnit.minute()))
		headerView.runningDurationLabel?.text = "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
		
		
		let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: Double((run?.distance)!)).doubleValue(for: HKUnit.meter())
		let distanceInKm = (distanceQuantity/1000).roundToPlaces(places: 2)
		headerView.distanceLabel?.text = "\(distanceInKm)"
		
		let minutes = Double((run?.duration)!)/60.0
		let kilometers = Double((run?.distance)!)/1000
		headerView.paceNumberLabel?.text = "\(String((minutes/kilometers).roundToPlaces(places: 2)))"
		
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
	
	
	
	func handleDoneWorkout() {
		
		self.dismiss(animated: true) { 
			
			//	post data to Club
			
		}
		
	}

	func handleShareWorkout() {
		
		shareLinkVC(linkString: "You've got to check out this workout on Pace. Download the app here : AppLink")
		
	}
	
}

