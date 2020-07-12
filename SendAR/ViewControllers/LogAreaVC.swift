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

class LogAreaVC: UIViewController, MKMapViewDelegate {

    let delegate = AppDelegate.shared()
    
    var defaultFenceRadius: Int64 = 100
    
    var locationCheck: LocationChecker
    let regionInMeters: Double = 500
    
    var newAreaName: String? = nil
    var newAreaCenter: CLLocation
    
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
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewOnUserLocation()
        
        // Do any additional setup after loading the view.
    }
    
    init(locationCheck: LocationChecker, newAreaCenter: CLLocation, latitude: Double, longitude: Double) {
        self.locationCheck = locationCheck
        self.newAreaCenter = newAreaCenter
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.newAreaCenter = CLLocation()
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
        let newArea = NSEntityDescription.insertNewObject(forEntityName: "Area", into: delegate.dataController!.persistentContainer.viewContext) as! Area
        
        newArea.setInitialValues(name: newAreaName, fenceLatitude: latitudeString, fenceLongitude: longitudeString, fenceRadius: defaultFenceRadius, subAreas: nil, superArea: nil)
        
        delegate.dataController!.saveContext()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        areaName.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
