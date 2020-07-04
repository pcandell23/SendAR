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
    
    @IBOutlet weak var trackButtonLabel: TrackButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        routeName.delegate = self
    }
    
    //MARK: - Tracker
    
    @IBAction func trackButton(_ sender: UIButton) {
        if !trackButtonLabel.buttonState {
            if !tracking {
                if routeName.text != nil {
                    tracking = true
                    tracker = Tracker(routeName: routeName.text!, data: "", startTime: "\(Date())", stopTime: "", timer: timer, currentLocation: currentLocation, locationAccess: locationManager)
                    
                    tracker?.startTracking()
                    startingAltitude.text = "\(currentLocation.altitude)"
                    startTime.text = "\(Date())"
                    
                    //set track button to say Stop Tracking
                    trackButtonLabel.buttonPressed()
                    
                }
            }
        } else if trackButtonLabel.buttonState {
            if tracker != nil && routeName.text != nil && tracking {
                tracker!.stopTracking(stopTime: "\(Date())")
                
                let saveToFile = UIActivityViewController(activityItems:[tracker!.data], applicationActivities: nil)
                self.present(saveToFile, animated: true, completion: nil)
                tracking = false
                currentAltitude.text = "\(currentLocation.altitude)"
                elapsedTime.text = "stopTIme - startTime"
                
                //set track button to say Reset
                trackButtonLabel.buttonPressed()
                
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        return true
    }
    
}
