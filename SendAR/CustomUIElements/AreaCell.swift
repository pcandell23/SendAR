//
//  AreaCell.swift
//  SendAR
//
//  Created by Peter Candell on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class AreaCell: UITableViewCell {
    
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var areaProximity: UILabel!
    @IBOutlet weak var subAreasLabel: UILabel!
    
    var area: Area?
    var userLocation: CLLocation
    var locationCheck: LocationChecker
    
    required init?(coder aDecoder: NSCoder) {
        self.area = nil
        self.userLocation = CLLocation()
        self.locationCheck = LocationChecker()
        super.init(coder: aDecoder)
    }
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationCheck.checkLocationServices()
        areaProximity.text = getProximity()
        
        // Values must be set in the VC that contains the TableView to which this cell belongs.
        /*
        if area != nil {
            areaName.text = area!.getName()
            areaProximity.text = getProximity()
            
            var numRoutes = 0
            let subAreasArray = area!.getSubAreasAsArray()
            for subArea in subAreasArray {
                numRoutes += (subArea as AnyObject).count
            }
            
            cragsAndRoutes.text = "\(area!.subAreaCount()) Crags, \(numRoutes) Routes"
        
        }else {
            areaName.text = ""
            areaProximity.text = ""
            cragsAndRoutes.text = ""
        }
 */
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getProximity() -> String {
        var proximityString: String = ""
        var proximityDouble: Double
        
        if area == nil {
            return "N/A"
        }
        
        if area!.getFenceLatitude() != "" && area!.getFenceLongitude() != "" {
            let areaLatitude    = Double(area!.getFenceLatitude())!
            let areaLongitude   = Double(area!.getFenceLongitude())!
            let areaLocation    = CLLocationCoordinate2DMake(areaLatitude, areaLongitude)
            
            let mapPoint1       = MKMapPoint.init(areaLocation)
            let mapPoint2       = MKMapPoint.init(userLocation.coordinate)
            
            proximityDouble     = mapPoint1.distance(to: mapPoint2)
            proximityString     = "\(String(proximityDouble)) m"
        }
        
        return proximityString
    }
    
}
