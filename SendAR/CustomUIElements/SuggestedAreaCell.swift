//
//  suggestedAreaCell.swift
//  SendAR
//
//  Created by Bennett Baker on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SuggestedAreaCell: UITableViewCell, MKMapViewDelegate {
    
    var locationCheck: LocationChecker
    var userLocation: CLLocation
    var crag: Crag? = nil
    let regionInMeters: Double = 100
    
    @IBOutlet var areaName: UILabel!
    @IBOutlet var proximityToUser: UILabel!
    //@IBOutlet var areaMap: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationCheck.checkLocationServices()
        proximityToUser.text = getProximity()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.userLocation = CLLocation()
        super.init(coder: aDecoder)
    }
    
    func getProximity() -> String {
        var proximityString: String = ""
        var proximityDouble: Double
        
        if crag == nil {
            return "N/A"
        }
        
        if crag!.getFenceLatitude() != "" && crag!.getFenceLongitude() != "" {
            let areaLatitude = Double(crag!.getFenceLatitude())!
            let areaLongitude = Double(crag!.getFenceLongitude())!
            let areaLocation = CLLocationCoordinate2DMake(areaLatitude, areaLongitude)
            
            let mapPoint1 = MKMapPoint.init(areaLocation)
            let mapPoint2 = MKMapPoint.init(userLocation.coordinate)
            
            proximityDouble = mapPoint1.distance(to: mapPoint2)
            round(proximityDouble)
            proximityString = "\(String(proximityDouble)) m"
        }
        
        return proximityString
    }
    
}
