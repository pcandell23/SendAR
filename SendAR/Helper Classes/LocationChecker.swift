//
//  LocationChecker.swift
//  SendAR
//
//  Created by Bennett Baker on 7/6/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import CoreLocation
import UIKit

class LocationChecker: CLLocationManager, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
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
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        print("Location manager set up")
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // sets up the location manager
            setupLocationManager()
            checkLocationAuthorization()
            print("Checking location")
        } else {
            // show alert letting user know they have to turn this on
            
            print("Locations disabled")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            print("Case: authorized always")
            break
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            print("Case: authorized when in use")
            break
            
        case .denied:
            // show alert instructing them how to turn on permissions
            
            print("Case: location service denied")
            break
            
        case .notDetermined:
            // request permission
            locationManager.requestAlwaysAuthorization()
            print("Case: requesting location authorization")
            break
            
        case .restricted:
            // show alert that user can't change this setting (parental controls)

            print("Case: location restricted")
            break
            
        @unknown default:
            //covers future cases with break to avoid crash
            break
            
        }
    }

}
