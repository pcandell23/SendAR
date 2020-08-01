//
//  CragCell.swift
//  SendAR
//
//  Created by Bennett Baker on 7/14/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CragCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var cragName: UILabel!
    @IBOutlet weak var cragProximity: UILabel!
    @IBOutlet weak var numberOfRoutes: UILabel!
    @IBOutlet weak var cragLocation: UILabel!
    
    var crag: Crag?
    var userLocation: CLLocation
    
    required init?(coder aDecoder: NSCoder) {
        self.crag = nil
        self.userLocation = CLLocation()
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getProximity() -> String {
        var proximityString: String = ""
        var proximityDouble: Double
        
        if crag == nil {
            return "N/A"
        }
        
        if crag!.getFenceLatitude() != "" && crag!.getFenceLongitude() != "" {
            let cragLatitude    = Double(crag!.getFenceLatitude())!
            let cragLongitude   = Double(crag!.getFenceLongitude())!
            let cragLocation    = CLLocationCoordinate2DMake(cragLatitude, cragLongitude)
            
            let mapPoint1       = MKMapPoint.init(cragLocation)
            let mapPoint2       = MKMapPoint.init(userLocation.coordinate)
            
            proximityDouble     = mapPoint1.distance(to: mapPoint2)
            proximityString     = "\(String(proximityDouble)) m"
        }
        
        return proximityString
    }
    
}
