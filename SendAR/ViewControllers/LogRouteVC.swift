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
    @IBOutlet weak var routeDescription: UITextField!
    
    var newRouteName: String? = nil
    var newRouteGrade: String? = nil
    var newRouteType: String? = nil
    var newRoutePitches: Int16 = 0
    var newRouteRating: Double = 0.0
    var newRouteHeight: Int32 = 0
    var newRouteLatitude: String? = nil
    var newRouteLongitude: String? = nil
    var newRouteAltitude: Int16 = 0
    var newRouteDescription: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //First Page Setup
        
        //Second Page Setup
        
        //Third Page Setup
        
        if nearbyAreasTable != nil {
            fetchNearbyCrags()
            let nib = UINib(nibName: "SuggestedAreaCell", bundle: nil)
            nearbyAreasTable.register(nib, forCellReuseIdentifier: "SuggestedAreaCell")
            nearbyAreasTable.delegate = self
            nearbyAreasTable.dataSource = self
        }
        
        centerViewOnUserLocation()
        
    }

    //first page "Continue" button
    @IBAction func saveRouteDetails(_ sender: Any) {
        newRouteName = routeName.text
        newRouteGrade = routeGrade.text
        newRouteType = routeType.text
        newRoutePitches = Int16(routePitches.text ?? "0") ?? 0
        newRouteHeight = Int32(routeHeight.text ?? "0") ?? 0
        
        if routeRating.text != nil{
            newRouteRating = (routeRating.text! as NSString).doubleValue
        } else {
            newRouteRating = 0.0
        }
        
        newRouteDescription = routeDescription.text
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        routeGrade.resignFirstResponder()
        routeType.resignFirstResponder()
        routePitches.resignFirstResponder()
        routeRating.resignFirstResponder()
        routeDescription.resignFirstResponder()
        return true
    }
    
    //MARK: - Second Page
    @IBOutlet weak var routeLocationMap: MKMapView!
    
    var locationCheck: LocationChecker
    var locationGetterForAltitude: CLLocation
    let regionInMeters: Double = 50
    
    var routeLatitude: Double = 0.0
    var routeLongitude: Double = 0.0
    var routeAltitude: Double = 0.0
    
    var routeLatitudeString: String? = nil
    var routeLongitudeString: String? = nil
    
    init(locationCheck: LocationChecker, locationGetterForAltitude: CLLocation) {
        self.locationCheck = locationCheck
        self.locationGetterForAltitude = locationGetterForAltitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.locationGetterForAltitude = CLLocation()
        super.init(coder: aDecoder)
    }
    
    func centerViewOnUserLocation() {
        if let location = locationCheck.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            if routeLocationMap != nil {
                routeLocationMap.setRegion(region, animated: true)
            }
        }
    }
    
    //second page "Confirm Location" button
    @IBAction func confirmLocation(_ sender: Any) {
        routeLatitude = routeLocationMap.centerCoordinate.latitude
        routeLongitude = routeLocationMap.centerCoordinate.longitude
        routeAltitude = locationGetterForAltitude.altitude
        
        routeLatitudeString = routeLatitude.description
        routeLongitudeString = routeLongitude.description
        
        newRouteLatitude = routeLatitudeString
        newRouteLongitude = routeLongitudeString
        newRouteAltitude = Int16(routeAltitude)
        
    }
    
    //MARK: - Third Page
    
    var crags: [Crag] = []
    
    @IBOutlet weak var nearbyAreasTable: UITableView!
        //show all crags in X (small) radius, allow user to tap to select
    
    @IBAction func confirmButton(_ sender: Any) {
        storeNewRouteInfo()
        //TODO: also record selected area
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newAreaButton(_ sender: Any) {
        //To LogAreaVC
        storeNewRouteInfo()
        //confirming a new area should add it to the list of areas
    }
    
    @IBAction func notSureButton(_ sender: Any) {
        storeNewRouteInfo()
        dismiss(animated: true, completion: nil)
    }
    
    //Stores the route in the data base. Takes an optional crag so that it can be used in any of the three above buttons.
    func storeNewRouteInfo(crag: Crag? = nil){
        
        let newRoute = NSEntityDescription.insertNewObject(forEntityName: "Route", into: delegate.dataController!.persistentContainer.viewContext) as! Route
        
        newRoute.setInitialValues(name: newRouteName, grade: newRouteGrade, rating: newRouteRating, height: newRouteHeight, type: newRouteType, pitches: newRoutePitches, crag: crag, latitude: newRouteLatitude, longitude: newRouteLongitude, altitude: newRouteAltitude, description: newRouteDescription)
        
        delegate.dataController!.saveContext()
    }
    
    // TODO finish this method once board in created
    func storeNewCragInfo(route: Route){
        let newCrag = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: delegate.dataController!.persistentContainer.viewContext) as! Crag
    
        newCrag.setInitialValues()
        //change this to the method with parameters so that it saves the data
        
        delegate.dataController!.saveContext()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedAreaCell", for: indexPath) as! SuggestedAreaCell
        cell.crag = crags[indexPath.row]
        cell.areaName.text = crags[indexPath.row].getName()
        cell.proximityToUser.text = cell.getProximity()
        
        return cell
    }
    
    func fetchNearbyCrags(){
        let moc = delegate.dataController?.persistentContainer.viewContext
           if moc == nil{
               print("Failed to fetch crags.")
               return
           }
           let requestCrags = NSFetchRequest<Crag>(entityName: "Crag")
           var fetched: [Crag]?
           do {
               fetched = try moc?.fetch(requestCrags)
           } catch {
               print("Could not fetch. \(error)")
           }
           
           if fetched != nil {
               crags = fetched!
           }
       }
    
    
}

