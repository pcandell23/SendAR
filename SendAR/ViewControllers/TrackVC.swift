//
//  TrackVC.swift
//  SendAR
//
//  Created by Bennett Baker on 8/4/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class TrackVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var trackUnitView: UIView!
    @IBOutlet weak var statUnitView: UIView!
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var timer = Timer()
    var tracker: Tracker?
    var isTracking: Bool = false
    
    @IBOutlet weak var routeName: UITextField!
    
    @IBOutlet weak var startingAltitude: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    @IBOutlet weak var deltaAltitude: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var stopButtonLabel: GreenButton!
    
    override func viewWillAppear(_ animated: Bool) {
        resetFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUnitViews()
        
        stopButtonLabel.setTitle("Reset", for: .normal)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            //currentLocation = locationManager.location!
            
            startingAltitude.text   = "Ready"
            currentAltitude.text    = "\(currentLocation.altitude) meters"
            deltaAltitude.text      = "0.0 meters"
            startTime.text          = "Ready"
            elapsedTime.text        = "0.0 minutes"
            
        }
        
        routeName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setupUnitViews() {
        trackUnitView.clipsToBounds = true
        trackUnitView.layer.cornerRadius = 10.0
        
        statUnitView.clipsToBounds = true
        statUnitView.layer.cornerRadius = 10.0
    }
    
    //MARK: Tracker
    @IBAction func startTrackingButton(_ sender: Any) {
           if !isTracking {
               if let route = routeName.text, !route.isEmpty {
                   isTracking = true
                   tracker = Tracker(routeName: routeName.text!, data: "", startTime: Date(), timer: timer, currentLocation: currentLocation, locationAccess: locationManager)
                   
                   tracker?.startTracking()
                   startingAltitude.text   = "\(currentLocation.altitude)"
                   startTime.text          = "\(Date())"
                   stopButtonLabel.setTitle("Stop Tracking", for: .normal)
               } else {
                   Alert.showRouteNameInvalidAlert(on: self)
               }
           } else {
               Alert.showAlreadyTrackingAlert(on: self)
           }
       }
       
    @IBAction func stopTrackingButton(_ sender: Any) {
        if tracker != nil && routeName.text != nil && isTracking {
            //When finished tracking, presents Half Sheet Modal for save or discard
            guard let reactionVC = storyboard?.instantiateViewController(withIdentifier: "DoneTrackingVC") as? DoneTrackingVC else {
                assertionFailure("No view controller ID DoneTrackingVC in storyboard")
                return
            }
               
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                reactionVC.backingImage             = self.tabBarController?.view.asImage()
                reactionVC.modalPresentationStyle   = .fullScreen
                // should pass saved tracked route with below
                reactionVC.trackedRoute             = self.tracker?.saveTrackedRoute()
                self.present(reactionVC, animated: false, completion: nil)
            })
            
            _ = tracker?.saveTrackedRoute()
            tracker!.stopTracking(stopTime: Date())
            isTracking = false
            currentAltitude.text    = "\(currentLocation.altitude)"
            elapsedTime.text        = "\(tracker!.timeCount)"
            stopButtonLabel.setTitle("Reset", for: .normal)
            
        } else if !isTracking {
            resetFields()
        }
    }
       
    func resetFields() {
        startingAltitude.text   = "Ready"
        startTime.text          = "Ready"
        currentAltitude.text    = "\(currentLocation.altitude) meters"
        elapsedTime.text        = "0.0 minutes"
        deltaAltitude.text      = "0.0 meters"
        routeName.text          = nil
    }
       
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        return true
    }

}
