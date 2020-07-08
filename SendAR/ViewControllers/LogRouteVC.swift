//
//  LogRouteVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit

class LogRouteViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - First Page
    @IBOutlet weak var routeName: UITextField!
    @IBOutlet weak var routeGrade: UITextField!
    @IBOutlet weak var routeType: UITextField!
    @IBOutlet weak var routePitches: UITextField!
    @IBOutlet weak var routeRating: UITextField!
    
    var newRouteName: String = ""
    var newRouteGrade: String = ""
    var newRouteType: String = ""
    var newRoutePitches: String = ""
    var newRouteRating: String = ""
    
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
        newRouteName = routeName.text ?? ""
        newRouteGrade = routeGrade.text ?? ""
        newRouteType = routeType.text ?? ""
        newRoutePitches = routePitches.text ?? ""
        newRouteRating = routeRating.text ?? ""
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

