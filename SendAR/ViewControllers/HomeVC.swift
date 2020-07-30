//
//  HomeVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var timer = Timer()
    var tracker: Tracker?
    var tracking: Bool = false
    var trackedRoutes: [TrackedRoute] = []
    
    @IBOutlet weak var routeName: UITextField!
    
    @IBOutlet weak var startingAltitude: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    @IBOutlet weak var deltaAltitude: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var stopButtonLabel: GreenButton!
    
    
    @IBOutlet weak var logbookTable: UITableView!
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Track"
        stopButtonLabel.setTitle("Reset", for: .normal)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            //currentLocation = locationManager.location!
            
            startingAltitude.text = "Ready"
            currentAltitude.text = "\(currentLocation.altitude) meters"
            deltaAltitude.text = "0.0 meters"
            startTime.text = "Ready"
            elapsedTime.text = "0.0 minutes"
            
        }
        
        routeName.delegate = self
        
        let nib = UINib(nibName: "LogbookCell", bundle: nil)
        logbookTable.register(nib, forCellReuseIdentifier: "LogbookCell")
        logbookTable.delegate = self
        logbookTable.dataSource = self
        
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
                self.title = "Tracking"
                stopButtonLabel.setTitle("Stop Tracking", for: .normal)
            } else {
                Alert.showRouteNameInvalidAlert(on: self)
            }
        } else {
            Alert.showAlreadyTrackingAlert(on: self)
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
            self.title = "Track"
            stopButtonLabel.setTitle("Reset", for: .normal)
        } else if !tracking {
            startingAltitude.text = "Ready"
            startTime.text = "Ready"
            currentAltitude.text = "\(currentLocation.altitude) meters"
            elapsedTime.text = "0.0 minutes"
            deltaAltitude.text = "0.0 meters"
            routeName.text = nil
            self.title = "Track"
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Logbook Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackedRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogbookCell", for: indexPath)
        //initialize cell data fields here
        
        return cell
    }
    
    //Make Editable
    
}
