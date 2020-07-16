//
//  ARviewVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import CoreLocation
import MapKit

class ARViewController: UIViewController {
    
    var locationCheck: LocationChecker
    var sceneLocationView = SceneLocationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCheck.checkLocationServices()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        createLocNode()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      sceneLocationView.frame = view.bounds
    }
    
    init(locationCheck: LocationChecker) {
        self.locationCheck = locationCheck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        super.init(coder: aDecoder)
    }
    
    func createLocNode(){
        let coordinate = CLLocationCoordinate2D(latitude: 37.9081200, longitude: -122.1126300)
        let timeStamp = Date.init()
        let location = CLLocation(coordinate: coordinate, altitude: 295, horizontalAccuracy: 10, verticalAccuracy: 10, timestamp: timeStamp)
        let image = UIImage(named: "AppIcon")!

        let annotationNode = LocationAnnotationNode(location: location, image: image)
        
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)

    }
}
