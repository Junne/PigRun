//
//  HomeViewController.swift
//  PigRun
//
//  Created by baijf on 22/02/2017.
//  Copyright © 2017 Junne. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var homeMap: MKMapView!
    let locationManager = CLLocationManager()
    var locations: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup locationManager
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // setup homeMap
        
        homeMap.delegate = self
        homeMap.showsUserLocation = true
        homeMap.userTrackingMode = .follow
        
        self.locations = NSMutableArray()
        
        setupData()

    }
    
    func setupData() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
        
            let title = "Lorrenzillo's"
            let coordinate = CLLocationCoordinate2DMake(39.92, 116.46)
            let regionRadius = 300.0
            
            let region = CLCircularRegion(center: CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate
            restaurantAnnotation.title = "\(title)"
            self.homeMap.addAnnotation(restaurantAnnotation)
            
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            self.homeMap.add(circle)
            
            locationManager.startUpdatingLocation()
            
        } else {
            print("Syster can't track regions")
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        else if CLLocationManager.authorizationStatus() == .denied {
            
        }
        
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter\(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit \(region.identifier)")
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for newLocation:CLLocation in locations {
            let eventDate = newLocation.timestamp;
            let howRecent = eventDate.timeIntervalSinceNow
            if fabs(howRecent) < 10.0 && newLocation.horizontalAccuracy < 20 {
                if (self.locations?.count)! > 0 {
                    var coords[2]:CLLocationCoordinate2D
                    coords[0] = self.locations.lastObject.coordinate
                }
                
                self.locations?.add(newLocation)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
