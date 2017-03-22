//
//  RunCompletedViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/22.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import MapKit
import HealthKit

class RunCompletedViewController: UIViewController, MKMapViewDelegate {
	
	@IBOutlet weak var runMapView: MKMapView!
	@IBOutlet weak var runMinsLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var paceLabel: UILabel!
	
	var run: RunModel?
	var mapOverlay: MKTileOverlay?

    override func viewDidLoad() {
        super.viewDidLoad()

		self.configureView()
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.closeBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.closeBlack()
		
    }
	
	func configureViewDetails() {
		
		paceLabel.font = UIFont(name: "BebasNeueBold", size: 35)
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		self.navigationController?.navigationItem.title = dateFormatter.string(from: run?.timestamp as! Date)
		
		let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int((run?.duration)!))
		let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: Double(s))
		let minutesQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: Double(m))
		_ = HKQuantity(unit: HKUnit.hour(), doubleValue: Double(h))
		runMinsLabel.text = "\(minutesQuantity.description):\(secondsQuantity.description)"
		
		let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(with: HKMetricPrefix.kilo), doubleValue: Double((run?.distance)!))
		distanceLabel.text = distanceQuantity.description
		
		//let paceUnit = HKUnit.meter().unitDivided(by: HKUnit.second())//HKUnit.second().unitDivided(by: HKUnit.meter())
		//let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: distance / seconds)
		
		let distance = Double((run?.distance)!)
		let duration = Double((run?.duration)!) * 3.6 * 10
		paceLabel.text = String((distance/duration).rounded()/10)
		
		//climbLabel.text = "Total climb: "+String((run.climb.doubleValue).rounded())+" m"
		//descentLabel.text = "Total descent: "+String((run.descent.doubleValue).rounded())+" m"
		
		
		loadMap()
		
	}
	
	func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
		
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
		
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
		//print("hello")
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
	
	func loadMap() {
		
		if (run?.locations?.count)! > 0 {
			
			runMapView.isHidden = false
			let template = "https://api.mapbox.com/styles/v1/spitfire4466/citl7jqwe00002hmwrvffpbzt/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic3BpdGZpcmU0NDY2IiwiYSI6Im9jX0JHQUUifQ.2QarbK_LccnrvDg7FobGjA"
			
			mapOverlay = MKTileOverlay(urlTemplate: template)
			mapOverlay?.canReplaceMapContent = true
			
			runMapView.add(mapOverlay!,level: .aboveLabels)
			
			// Set the map bounds
			runMapView.region = mapRegion()
			
			// Make the line(s!) on the map
			let colorSegments = MulticolorPolylineSegment.colorSegments(forLocations: run.locations.array as! [LocationModel])
			
			mapView.addOverlays(colorSegments)
		
		} else {
		
			// No locations were found!
			runMapView.isHidden = true
			
			print("Sorry, this run has no locations saved")
			
		}
	}

	
	func configureView() {
		
		runMinsLabel.font = UIFont(name: "BebasNeueBold", size: 35)
		distanceLabel.font = UIFont(name: "BebasNeueBold", size: 45)
		paceLabel.font = UIFont(name: "BebasNeueBold", size: 35)
		
		textSpacing(runMinsLabel, spacing: 2.0)
		textSpacing(paceLabel, spacing: 2.0)
		textSpacing(distanceLabel, spacing: 2.5)
		
	}

}
