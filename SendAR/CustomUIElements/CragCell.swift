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

class CragCell: UITableViewCell {
    
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
        if crag != nil {
            cragName.text = crag!.getName()
            cragProximity.text = getProximity()
            numberOfRoutes.text = String(crag!.getRoutes()!.count)
        
            if crag!.getSuperArea() != nil {
                cragLocation.text = crag!.getSuperArea()!.getName()
            } else {
                cragLocation.text = ""
            }
        }else {
            cragName.text = ""
            cragProximity.text = ""
            numberOfRoutes.text = ""
            cragLocation.text = ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getProximity() -> String {
        var proximityString: String = ""
        var proximityDouble: Double
        
        if crag!.getFenceLatitude() != "" && crag!.getFenceLongitude() != "" {
            let cragLatitude = Double(crag!.getFenceLatitude())!
            let cragLongitude = Double(crag!.getFenceLongitude())!
            let cragLocation = CLLocationCoordinate2DMake(cragLatitude, cragLongitude)
            
            let mapPoint1 = MKMapPoint.init(cragLocation)
            let mapPoint2 = MKMapPoint.init(userLocation.coordinate)
            
            proximityDouble = mapPoint1.distance(to: mapPoint2)
            proximityString = "\(String(proximityDouble)) m"
        }
        
        return proximityString
    }
    
}
