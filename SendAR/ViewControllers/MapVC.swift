//
//  MapVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var locationCheck: LocationChecker
    let regionInMeters: Double = 5000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCheck.checkLocationServices()
        centerViewOnUserLocation()
        
        //Alerts for location services issues
        if CLLocationManager.authorizationStatus() == .denied {
            Alert.showLocationServicesDeniedAlert(on: self)
        } else if CLLocationManager.authorizationStatus() == .restricted {
            Alert.showLocationServicesRestrictedAlert(on: self)
        }
    }
    
    init(locationCheck: LocationChecker) {
        self.locationCheck = locationCheck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //shows nav bar on next page
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func centerViewOnUserLocation() {
        if let location = locationCheck.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func recenterLocation(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationCheck.checkLocationAuthorization()
            centerViewOnUserLocation()
            print("Refreshing Location")
        } else {
            print("Unable to refresh")
        }
    }
}
