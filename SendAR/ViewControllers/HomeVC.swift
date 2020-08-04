//
//  HomeVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class HomeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let delegate = AppDelegate.shared()
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var timer = Timer()
    var tracker: Tracker?
    var tracking: Bool = false
    var trackedRoutes: [TrackedRoute] = []
    var routeIndex: Int = 0
    
    @IBOutlet weak var routeName: UITextField!
    
    @IBOutlet weak var startingAltitude: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    @IBOutlet weak var deltaAltitude: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var stopButtonLabel: GreenButton!
    
    
    @IBOutlet weak var logbookTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        resetFields()
        logbookTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Track"
        stopButtonLabel.setTitle("Reset", for: .normal)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        fetchLoggedRoutes()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            //currentLocation = locationManager.location!
            
            startingAltitude.text   = "Ready"
            currentAltitude.text    = "\(currentLocation.altitude) meters"
            deltaAltitude.text      = "0.0 meters"
            startTime.text          = "Ready"
            elapsedTime.text        = "0.0 minutes"
            
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
                tracker = Tracker(routeName: routeName.text!, data: "", startTime: Date(), timer: timer, currentLocation: currentLocation, locationAccess: locationManager)
                
                tracker?.startTracking()
                startingAltitude.text   = "\(currentLocation.altitude)"
                startTime.text          = "\(Date())"
                self.title              = "Tracking"
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
            
            tracker!.stopTracking(stopTime: Date())
            tracking = false
            currentAltitude.text    = "\(currentLocation.altitude)"
            elapsedTime.text        = "\(tracker!.timeCount)"
            self.title              = "Track"
            stopButtonLabel.setTitle("Reset", for: .normal)
            let storedRoute = tracker?.saveTrackedRoute()
            if storedRoute != nil{
                trackedRoutes.append(storedRoute!)
            }
        } else if !tracking {
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
        self.title              = "Track"
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Logbook Table
    
    func fetchLoggedRoutes(){
        let moc = AppDelegate.shared().dataController?.persistentContainer.viewContext
           if moc == nil{
               print("Failed to fetch Logged routes.")
               return
           }
           let requestRoutes = NSFetchRequest<TrackedRoute>(entityName: "TrackedRoute")
           var fetched: [TrackedRoute]?
           do {
               fetched = try moc?.fetch(requestRoutes)
           } catch {
               print("Could not fetch. \(error)")
           }
           
           if fetched != nil {
               trackedRoutes = fetched!
           }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackedRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogbookCell", for: indexPath) as! LogbookCell
        //initialize cell data fields here
        cell.routeName.text     = trackedRoutes[indexPath.row].getName()
        let timeInMinutes       = (trackedRoutes[indexPath.row].getElapsedTime() / 60.0)
        cell.routeTime.text     = String(format: "%.2f minutes", timeInMinutes)
        let heightInMeters      = trackedRoutes[indexPath.row].getElapsedAltitude()
        cell.routeHeight.text   = String(format: "%.1f m", heightInMeters)
        if let routeStartTime   = trackedRoutes[indexPath.row].getStartTime() {
            cell.routeDate.text = "\(routeStartTime)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        routeIndex = indexPath.row
        
        performSegue(withIdentifier: "HomeToTrackedRoute", sender: cell)
    }
    
    //Make Editable
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete {
                let moc = delegate.dataController?.persistentContainer.viewContext
                if moc == nil {
                    return
                }
                let commit = trackedRoutes[indexPath.row]
                moc!.delete(commit)
                trackedRoutes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                delegate.dataController?.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToTrackedRoute" {
            let vc = segue.destination as! TrackedRouteVC
            vc.trackedRoute = trackedRoutes[routeIndex]
        }
    }
    
}
