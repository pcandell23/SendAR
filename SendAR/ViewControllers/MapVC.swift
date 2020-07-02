//
//  MapVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func refreshLocation(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            print("Refreshing Location")
        } else {
            print("Unable to refresh")
        }
        
    }
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // prints true
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        centerViewOnUserLocation()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        print("Location manager set up")
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // sets up the location manager
            setupLocationManager()
            checkLocationAuthorization()
            print("Checking location")
        } else {
            // show alert letting user know they have to turn this on
            locationServiceDeniedAlert()
            print("Locations disabled")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            print("Case: authorized when in use")
            
        case .denied:
            // show alert instructing them how to turn on permissions
            locationServiceDeniedAlert()
            print("Case: location service denied")
            
        case .notDetermined:
            // request permission
            locationManager.requestWhenInUseAuthorization()
            print("Case: requesting location authorization")
            
        case .restricted:
            // show alert that user can't change this setting (parental controls)
            locationServiceRestrictedAlert()
            print("Case: location restricted")
            
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            print("Case: authorized always")
            
        @unknown default:
            //covers future cases with break to avoid crash
            break
            
        }
    }
    
    func locationServiceDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Denied", message: "Please enable location services for SendAR in your device settings", preferredStyle: .alert)
        // settings button
        alert.addAction(settingsAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func locationServiceRestrictedAlert() {
        let alert = UIAlertController(title: "Location Services Restricted", message: "Location services are restricted on this device", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        
        mapView.setRegion(region, animated: true)
        
        //self.locationManager.stopUpdatingLocation()
        //self.locationManager.stopUpdatingHeading()
    }
 */
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
