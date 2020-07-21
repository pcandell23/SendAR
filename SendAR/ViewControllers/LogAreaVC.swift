//
//  LogAreaVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/10/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class LogAreaVC: UIViewController, MKMapViewDelegate, UITextFieldDelegate {

    let delegate = AppDelegate.shared()

    var locationCheck: LocationChecker
    let regionInMeters: Double = 500
    
    var newRoute: Route?
    
    var newAreaName: String? = nil
    
    var defaultFenceRadius = 100
    
    var latitude: Double
    var longitude: Double
    
    var latitudeString: String? = nil
    var longitudeString: String? = nil
    
    @IBOutlet weak var areaName: UITextField!
    @IBOutlet weak var areaMap: MKMapView!
    
    @IBAction func confirmNewArea(_ sender: Any) {
        //save area region and dismiss
        newAreaName = areaName.text
        getCenterLocation(for: areaMap)
        storeNewAreaInfo()
        print("Saved new area!")
        //unwinds to home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewOnUserLocation()
        
        // Do any additional setup after loading the view.
    }
    
    init(locationCheck: LocationChecker, latitude: Double, longitude: Double) {
        self.locationCheck = locationCheck
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.latitude = 0.0
        self.longitude = 0.0
        super.init(coder: aDecoder)
    }
    
    func centerViewOnUserLocation() {
        if let location = locationCheck.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            areaMap.setRegion(region, animated: true)
        }
    }
    
    func getCenterLocation(for areaMap: MKMapView) {
        latitude = areaMap.centerCoordinate.latitude
        longitude = areaMap.centerCoordinate.longitude
        
        latitudeString = latitude.description
        longitudeString = longitude.description
    }
    
    func storeNewAreaInfo(){
        let newArea = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: delegate.dataController!.persistentContainer.viewContext) as! Crag
        
        newArea.setInitialValues(name: newAreaName, fenceLatitude: latitudeString, fenceLongitude: longitudeString, fenceRadius: Int64(defaultFenceRadius), subAreas: nil, superArea: nil)
        
        if newRoute != nil {
            newArea.addToRoutes(newRoute!)
        }
        
        delegate.dataController!.saveContext()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        areaName.resignFirstResponder()
        return true
    }
}
