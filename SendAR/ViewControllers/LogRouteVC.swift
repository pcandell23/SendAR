//
//  LogRouteVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class LogRouteViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // Stores delegate information for use of storing and fetching from persistant store
    let delegate = AppDelegate.shared()
    
    // MARK: - First Page
    @IBOutlet weak var routeName: UITextField!
    @IBOutlet weak var routeGrade: UITextField!
    @IBOutlet weak var routeType: UITextField!
    @IBOutlet weak var routeHeight: UITextField!
    @IBOutlet weak var routePitches: UITextField!
    @IBOutlet weak var routeRating: UITextField!
    
    var newRouteName: String? = nil
    var newRouteGrade: String? = nil
    var newRouteType: String? = nil
    var newRoutePitches: Int16 = 0
    var newRouteRating: Double = 0.0
    var newRouteHeight: Int64 = 0
    var newRouteLatitude: String? = nil
    var newRouteLongitude: String? = nil
    var newRouteAltitude: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //First Page Setup
        
        //Second Page Setup
        
        //Third Page Setup
        let nib = UINib(nibName: "SuggestedAreaCell", bundle: nil)
        
        if nearbyAreasTable != nil {
            nearbyAreasTable.register(nib, forCellReuseIdentifier: "SuggestedAreaCell")
            nearbyAreasTable.delegate = self
            nearbyAreasTable.dataSource = self
        }
        
    }

    //first page "Continue" button
    @IBAction func saveRouteDetails(_ sender: Any) {
        newRouteName = routeName.text
        newRouteGrade = routeGrade.text
        newRouteType = routeType.text
        newRoutePitches = Int16(routePitches.text ?? "0") ?? 0
        newRouteHeight = Int64(routeHeight.text ?? "0") ?? 0
        
        //newRouteLatitude = routeLatitude.text
        //newRouteLongitude = routeLongitude.text
        //newRouteAltitude = Int16(routeAltitude.text ?? "0") ?? 0
        
        if routeRating.text != nil{
            newRouteRating = (routeRating.text! as NSString).doubleValue
        } else {
            newRouteRating = 0.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        routeGrade.resignFirstResponder()
        routeType.resignFirstResponder()
        routePitches.resignFirstResponder()
        routeRating.resignFirstResponder()
        return true
    }
    
    //MARK: - Second Page
    @IBOutlet weak var routeLocationMap: MKMapView!
    
    //second page "Confirm Location" button
    @IBAction func confirmLocation(_ sender: Any) {
        //record user location
    }
    
    //MARK: - Third Page
    let areas = ["Half Dome", "Road Cut", "Blackwall"]
    let proximity = ["50 m", "150 mi", "200 mi"]
    
    @IBOutlet weak var nearbyAreasTable: UITableView!
        //show all crags in X (small) radius, allow user to tap to select
    
    @IBAction func confirmButton(_ sender: Any) {
        //save new route with selected area
        
    }
    
    @IBAction func newAreaButton(_ sender: Any) {
        //create a new area to save the route under
    }
    
    @IBAction func notSureButton(_ sender: Any) {
        //save route without explicit area
        //save closest crag(s) info
        storeNewRouteInfo()
    }
    
    //Stores the route in the data base. Takes an optional crag so that it can be used in any of the three above buttons.
    func storeNewRouteInfo(crag: Crag? = nil){
        
        let newRoute = NSEntityDescription.insertNewObject(forEntityName: "Route", into: delegate.dataController!.persistentContainer.viewContext) as! Route
        
        newRoute.setInitialValues(name: newRouteName, grade: newRouteGrade, rating: newRouteRating, height: newRouteHeight, type: newRouteType, pitches: newRoutePitches, crag: crag, latitude: newRouteLatitude, longitude: newRouteLongitude, altitude: newRouteAltitude)
        
        delegate.dataController!.saveContext()
    }
    
    // TODO finish this method once board in created
    func storeNewCragInfo(route: Route){
        let newCrag = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: delegate.dataController!.persistentContainer.viewContext) as! Crag
        
        //Blank for now but once it is set up values can be added
        newCrag.setInitialValues()
        
        delegate.dataController!.saveContext()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedAreaCell", for: indexPath) as! SuggestedAreaCell
        cell.areaName.text = areas[indexPath.row]
        cell.proximityToUser.text = proximity[indexPath.row]
        
        return cell
    }
    
    
}

