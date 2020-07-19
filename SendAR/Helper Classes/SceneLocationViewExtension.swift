//
//  SceneLocationViewExtension.swift
//  SendAR
//
//  Created by Peter Candell on 7/19/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import ARKit
import CoreLocation
import MapKit

extension SceneLocationView{
    
    func drawLineBetweenNodes(startNode: LocationAnnotationNode, endNode: LocationAnnotationNode){
        let line = SCNGeometry.line(from: startNode.position, to: endNode.position)
        let lineNode = SCNNode(geometry: line)
        startNode.addChildNode(lineNode)
    }
    
    func addRoute(locationCSVstring: String, name: String){
        addRoute(locations: parseCSVString(csvStr: locationCSVstring), name: name)
    }
    
    func addRoute(locations: [[String]], name: String){
        var route = [LocationAnnotationNode]()
        for i in locations{
            route.append(createLocNode(lat: Double(i[0])!, long: Double(i[1])!, alt: Double(i[2])!))
        }
        routes[name] = route
    }
    
    func drawRoute(name: String){
        let route = routes[name]
        if (route != nil){
            for i in 0...(route!.count-2){
                drawLineBetweenNodes(startNode: route![i], endNode: route![i+1])
            }
        }
    }
    
    func drawAllRoutes(){
        for (name, _) in routes{
            drawRoute(name: name)
        }
    }
    
    func createLocNode(lat: Double, long: Double, alt: Double, _ image: UIImage = UIImage(named: "AppIcon")!) -> LocationAnnotationNode{
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let timeStamp = Date.init()
        let location = CLLocation(coordinate: coordinate, altitude: alt, horizontalAccuracy: 10, verticalAccuracy: 10, timestamp: timeStamp)

        let annotationNode = LocationAnnotationNode(location: location, image: image)
        
        addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        return annotationNode
    }
    
    func parseCSVString(csvStr: String) -> [[String]]{
           let subs = csvStr.components(separatedBy: "\n")
           var parsed = [[String]]()
           for s in subs{
               parsed.append(s.components(separatedBy: ", "))
           }
           return parsed
       }
    
    
}

extension SCNGeometry {
    class func line(from vector1: SCNVector3, to vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}
