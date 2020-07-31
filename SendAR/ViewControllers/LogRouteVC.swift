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

class LogRouteViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
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
    
    var loggedRoute: Route?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //First Page Setup
        
        //Second Page Setup
        
        //Third Page Setup
        if searchBar != nil {
            searchBar.delegate = self
        }
        
        if nearbyAreasTable != nil {
            fetchNearbyCrags()
            filteredCrags = crags
            let nib = UINib(nibName: "SuggestedAreaCell", bundle: nil)
            nearbyAreasTable.register(nib, forCellReuseIdentifier: "SuggestedAreaCell")
            nearbyAreasTable.delegate = self
            nearbyAreasTable.dataSource = self
        }
        
        centerViewOnUserLocation()
        
    }

    //first page "Continue" button
    @IBAction func saveRouteDetails(_ sender: Any) {
        
        if routeName.text!.isEmpty || routeGrade.text!.isEmpty || routeType.text!.isEmpty || routePitches.text!.isEmpty || routeHeight.text!.isEmpty || routeRating.text!.isEmpty || routeDescription.text!.isEmpty {
            Alert.showIncompleteRouteDataAlert(on: self)
            print("Alert: Incomplete Route Data")
        } else {
            newRouteName = routeName.text
            newRouteGrade = routeGrade.text
            newRouteType = routeType.text
            newRoutePitches = Int16(routePitches.text ?? "0") ?? 0
            newRouteHeight = Int32(routeHeight.text ?? "0") ?? 0
            newRouteRating = (routeRating.text! as NSString).doubleValue
            newRouteDescription = routeDescription.text
            
            performSegue(withIdentifier: "RouteDetailsToRouteLocation", sender: self)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        routeGrade.resignFirstResponder()
        routeType.resignFirstResponder()
        routePitches.resignFirstResponder()
        routeRating.resignFirstResponder()
        routeDescription.resignFirstResponder()
        if searchBar != nil {
            searchBar.resignFirstResponder()
        }
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
    
    init(locationCheck: LocationChecker, locationGetterForAltitude: CLLocation, routeCrag: Crag) {
        self.locationCheck = locationCheck
        self.locationGetterForAltitude = locationGetterForAltitude
        self.routeCrag = routeCrag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.locationGetterForAltitude = CLLocation()
        self.routeCrag = Crag()
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
    var filteredCrags: [Crag]!
    var routeCrag: Crag
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nearbyAreasTable: UITableView!
        //sort crags by proximity or alphabetically, add search bar
    
    @IBAction func confirmButton(_ sender: Any) {
        storeNewRouteInfo()
        if routeCrag.getName() != "" {
            routeCrag.addRoute(newRoute: loggedRoute!)
            performSegue(withIdentifier: "ConfirmToSuccess", sender: self)
        } else {
            Alert.showNoAreaSelectedAlert(on: self)
        }
    }
    
    @IBAction func newAreaButton(_ sender: Any) {
        //To LogAreaVC
        storeNewRouteInfo()
        performSegue(withIdentifier: "LogNewRouteToLogNewArea", sender: self)
    }
    
    @IBAction func notSureButton(_ sender: Any) {
        storeNewRouteInfo()
        performSegue(withIdentifier: "ConfirmToSuccess", sender: self)
    }
    
    //Stores the route in the data base. Takes an optional crag so that it can be used in any of the three above buttons.
    func storeNewRouteInfo(crag: Crag? = nil){
        let newRoute = NSEntityDescription.insertNewObject(forEntityName: "Route", into: delegate.dataController!.persistentContainer.viewContext) as! Route
        
        newRoute.setInitialValues(name: newRouteName, grade: newRouteGrade, rating: newRouteRating, height: newRouteHeight, type: newRouteType, pitches: newRoutePitches, crag: crag, latitude: newRouteLatitude, longitude: newRouteLongitude, altitude: newRouteAltitude, description: newRouteDescription)
        
        loggedRoute = newRoute
        
        delegate.dataController!.saveContext()
    }
    
    // TODO finish this method once board in created
    func storeNewCragInfo(route: Route){
        let newCrag = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: delegate.dataController!.persistentContainer.viewContext) as! Crag
    
        newCrag.setInitialValues()
        //change this to the method with parameters so that it saves the data
        
        delegate.dataController!.saveContext()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCrags = []
        
        if searchText == "" {
            filteredCrags = crags
        } else {
            for crag in crags {
                if crag.getName().lowercased().contains(searchText.lowercased()) {
                    filteredCrags.append(crag)
                }
            }
        }
        
        self.nearbyAreasTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCrags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedAreaCell", for: indexPath) as! SuggestedAreaCell
        cell.crag = filteredCrags[indexPath.row]
        cell.areaName.text = filteredCrags[indexPath.row].getName()
        cell.proximityToUser.text = cell.getProximity()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routeCrag = filteredCrags[indexPath.row]
        print("\(crags[indexPath.row].getName()) selected as the crag.")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogNewRouteToLogNewArea"{
            let destVC = segue.destination as! UINavigationController
            let vc = destVC.viewControllers.first as! LogAreaVC
            vc.newRoute = loggedRoute
        }
    }
    
    
}

