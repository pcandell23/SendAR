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
        
        let casaFaceArray = parseCSVString(csvStr: casaFace)
        let drivewayTestArray = parseCSVString(csvStr: drivewayTest)
        
        sceneLocationView.arTrackingType = .worldTracking
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        for i in casaFaceArray{
            createLocNode(lat: Double(i[0])!, long: Double(i[1])!, alt: Double(i[2])!)
        }
        
        for i in drivewayTestArray {
            createLocNode(lat: Double(i[0])!, long: Double(i[1])!, alt: Double(i[2])!)
        }
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
    
    func createLocNode(lat: Double, long: Double, alt: Double){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let timeStamp = Date.init()
        let location = CLLocation(coordinate: coordinate, altitude: alt, horizontalAccuracy: 10, verticalAccuracy: 10, timestamp: timeStamp)
        let image = UIImage(named: "AppIcon")!

        let annotationNode = LocationAnnotationNode(location: location, image: image)
        
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)

    }
    
    func parseCSVString(csvStr: String) -> [[String]]{
        let subs = csvStr.components(separatedBy: "\n")
        var parsed = [[String]]()
        for s in subs{
            parsed.append(s.components(separatedBy: ", "))
        }
        return parsed
    }
    
    
    let casa = [[37.908011919689955, -122.11281131271917, 300.2597144478932], [37.908014792372754, -122.11281123654662, 300.30321965552866], [37.90804496009676, -122.11282269909327, 300.1347431233153], [37.90806193639919, -122.11282731287545, 300.26467171218246], [37.90805929624258, -122.11281883196004, 300.61930642835796], [37.90807033647613, -122.11284410991962, 299.6509304661304], [37.908075428224215, -122.11280619785661, 299.2595796091482], [37.908085190551176, -122.1127977836074, 299.66139339562505], [37.90810968456282, -122.11279781693835, 300.39335840567946], [37.90810883550379, -122.11276831986066, 299.787612458691], [37.90812972180187, -122.11277390608302, 300.0581551901996], [37.90813532215953, -122.11276031990539, 299.15786030702293], [37.90814908681135, -122.11276822426701, 298.8509417800233], [37.90815218852865, -122.11277488429508, 299.0814997870475], [37.90814177150059, -122.11277765255133, 298.93261280376464]]
    
    let casaFace = "37.90812141298334, -122.11273814368845, 295.0328527316451, 0\n37.90814889744113, -122.11271101956682, 295.0149109477177, 5\n37.908176654069976, -122.11266947607236, 295.77069351058453, 10\n37.90812238543949, -122.1127034726852, 296.22606231924146, 15\n37.90815278759087, -122.11268916146072, 296.8570330603048, 20\n37.90815304997312, -122.11268339002471, 297.6756593855098, 25\n37.908160253460714, -122.11268391699326, 297.7422277452424, 30\n37.908153088426204, -122.1126956234463, 298.2377291461453, 35\n37.90814470270635, -122.11268063125799, 298.8070834720507, 40\n37.90814337415483, -122.11267628994794, 299.20905527099967, 45\n37.90816824413463, -122.11267562778971, 299.77507848516107, 50\n37.90818768431165, -122.11267023357367, 300.29308478347957, 55\n37.90820218670829, -122.11266153924404, 301.621313967742, 60\n37.908211347400645, -122.1126527118125, 302.2130632996559, 65\n37.908206180215764, -122.11265315246561, 303.3639313383028, 70\n37.90819870326407, -122.112658087821, 304.6664536250755, 75\n37.90818950072417, -122.1126531657101, 305.2988667273894, 80"
    
    let drivewayTest = "37.90972411767341, -122.16047078558564, 236.10087754391134, 0\n37.90971650899731, -122.16048266412962, 236.39274073019624, 5\n37.909742208856755, -122.160454957121, 236.76583274174482, 10\n37.909764570092484, -122.16041983268086, 237.66388681624085, 15\n37.909783802131265, -122.16040911835874, 238.234579927288, 20\n37.9098180877148, -122.16039345119704, 240.14408022817224, 25\n37.909851533792406, -122.16037228672724, 240.11101959086955, 30\n37.909874390578295, -122.1603455887727, 240.38438497390598, 35\n37.90990740546963, -122.16032069264227, 241.00115711148828, 40\n37.90993325231694, -122.16030213080322, 243.58661986514926, 45\n37.90995098495471, -122.16030150871792, 242.76063189841807, 50"
}
