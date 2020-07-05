//
//  HomeVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var timer = Timer()
    var tracker: Tracker?
    var tracking: Bool = false
    
    @IBOutlet weak var routeName: UITextField!
    
    @IBOutlet weak var startingAltitude: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLocation = locationManager.location!
            
            startingAltitude.text = "Ready"
            currentAltitude.text = "\(currentLocation.altitude)"
            startTime.text = "Ready"
            elapsedTime.text = "0.0"
            
        }
        
        routeName.delegate = self
    }
    
    //MARK: - Tracker
    
    
    @IBAction func startTrackingButton(_ sender: Any) {
        if !tracking {
            if let route = routeName.text, !route.isEmpty {
                tracking = true
                tracker = Tracker(routeName: routeName.text!, data: "", startTime: "\(Date())", stopTime: "", timer: timer, currentLocation: currentLocation, locationAccess: locationManager)
                
                tracker?.startTracking()
                startingAltitude.text = "\(currentLocation.altitude)"
                startTime.text = "\(Date())"
            } else {
                let alert = UIAlertController(title: "Route Name Invalid", message: "Please enter a route name before tracking", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Already Tracking", message: "Please end the current tracking session before attempting to start a new tracking session", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func stopTrackingButton(_ sender: Any) {
        if tracker != nil && routeName.text != nil && tracking {
            tracker!.stopTracking(stopTime: "\(Date())")
            
            let saveToFile = UIActivityViewController(activityItems:[tracker!.data], applicationActivities: nil)
            self.present(saveToFile, animated: true, completion: nil)
            tracking = false
            currentAltitude.text = "\(currentLocation.altitude)"
            elapsedTime.text = "stopTime - startTime"
        } else if !tracking {
            startingAltitude.text = "Ready"
            startTime.text = "Ready"
            currentAltitude.text = "\(currentLocation.altitude)"
            elapsedTime.text = "0.0"
            routeName.text = nil
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        return true
    }
    
}
