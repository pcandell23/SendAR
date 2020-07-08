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
    //wont work until area gets location variable
    //var area: Area
    let regionInMeters: Double = 100
    
    @IBOutlet var areaName: UILabel!
    @IBOutlet var proximityToUser: UILabel!
    @IBOutlet var areaMap: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationCheck.checkLocationServices()
       
        /*
         Wont work until area gets location variable
        centerViewOnArea()
 */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        super.init(coder: aDecoder)
    }
    
    /*
     Wont work until area gets location variable
     
    func centerViewOnArea() {
           if let areaLocation = area.location {
            let region = MKCoordinateRegion.init(center: areaLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
               areaMap.setRegion(region, animated: true)
           }
       }
 */
    
}
