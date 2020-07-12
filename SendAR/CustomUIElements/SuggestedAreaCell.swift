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
    var area: Area
    let regionInMeters: Double = 100
    
    @IBOutlet var areaName: UILabel!
    @IBOutlet var proximityToUser: UILabel!
    @IBOutlet var areaMap: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationCheck.checkLocationServices()
        proximityToUser.text = getProximity()
        centerViewOnArea()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        self.area = Area()
        super.init(coder: aDecoder)
    }
    
    func getProximity() -> String {
        var proximityString: String = ""
        var proximityDouble: Double
        
        if area.getFenceLatitude() != "" && area.getFenceLongitude() != "" {
            let areaLatitude = Double(area.getFenceLatitude())!
            let areaLongitude = Double(area.getFenceLongitude())!
            let areaLocation = CLLocationCoordinate2DMake(areaLatitude, areaLongitude)
            
            let mapPoint1 = MKMapPoint.init(areaLocation)
            let mapPoint2 = MKMapPoint.init()//make CLLocationCoordinate2D
            
            proximityDouble = mapPoint1.distance(to: mapPoint2)
            proximityString = "\(String(proximityDouble)) m"
        }
        
        return proximityString
    }
    
    func centerViewOnArea() {
        if area.getFenceLatitude() != "" && area.getFenceLongitude() != "" {
            let areaLatitude = Double(area.getFenceLatitude())!
            let areaLongitude = Double(area.getFenceLongitude())!
            let areaLocation = CLLocationCoordinate2DMake(areaLatitude, areaLongitude)
            let region = MKCoordinateRegion.init(center: areaLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            areaMap.setRegion(region, animated: true)
        }
    }
    
}
