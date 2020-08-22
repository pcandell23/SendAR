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
//        let start = startNode.location
//        let end = endNode.location
//
//        if start != nil && end != nil{
//            let angles = getEulerAngles(start: start!, end: end!)
//            let line = buildLine(from: start!, to: end!, radius: 0.05, color: .cyan)
//            let lineNode = createLineNode(lat: startNode.location.coordinate.latitude,                              long: startNode.location.coordinate.longitude,
//                                          alt: startNode.location.altitude,
//                                          line: line,
//                                          angles: angles) }
        let from = SCNVector3(startNode.location.coordinate.latitude, startNode.location.coordinate.longitude, startNode.location.altitude)
        
        let to = SCNVector3(endNode.location.coordinate.latitude, endNode.location.coordinate.longitude, endNode.location.altitude)
        
        let line = SCNGeometry.cylinderLine(from: from, to: to, segments: 2)
        
        let lineNode = createLineNode(lat: Double(from.x), long: Double(from.y), alt: Double(from.z), line: line)
        
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
    
    func createLineNode(lat: Double, long: Double, alt: Double, line: SCNNode) -> LocationAnnotationNode{
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let timeStamp = Date.init()
        let location = CLLocation(coordinate: coordinate, altitude: alt, horizontalAccuracy: 10, verticalAccuracy: 10, timestamp: timeStamp)

        let annotationNode = LocationAnnotationNode(location: location, line: line)
        
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
    
    func distance(start: SCNVector3, end: SCNVector3) -> Float{
        let node1Pos = SCNVector3ToGLKVector3(start)
        let node2Pos = SCNVector3ToGLKVector3(end)

        return GLKVector3Distance(node1Pos, node2Pos)
    }
    
    func getEulerAngles(start: CLLocation, end: CLLocation) -> SCNVector3{
        let roll = Float.pi / 2 //Changes line segment to be horizontal
        
        let bearing = -start.bearing(between: end)
        
        let yaw = Float(bearing).degreesToRadians
        
        let distance = start.distance(from: end)
        let altChange = end.altitude - start.altitude
        
        let pitch = Float(atan2(altChange, distance))
        
        return SCNVector3(pitch, yaw, roll)
    }
    

    func buildLine(from startPoint: CLLocation,
                              to endPoint: CLLocation,
                              radius: CGFloat,
                              color: UIColor) -> SCNCylinder {
        let dist = startPoint.distance(from: endPoint)
        let altDiff = abs(endPoint.altitude - startPoint.altitude)
        
        let l = CGFloat(sqrt((dist * dist) + (altDiff * altDiff))) //pythagorean theorem

        let cyl = SCNCylinder(radius: radius, height: l)
        cyl.firstMaterial?.diffuse.contents = color
        
        return cyl
    }
    
}


extension SCNGeometry {

    class func cylinderLine(from: SCNVector3, to: SCNVector3, segments: Int) -> SCNNode {

        let x1 = from.x
        let x2 = to.x

        let y1 = from.y
        let y2 = to.y

        let z1 = from.z
        let z2 = to.z

        let distance = sqrtf((x2 - x1) * (x2 - x1) +
                             (y2 - y1) * (y2 - y1) +
                             (z2 - z1) * (z2 - z1))

        let cylinder = SCNCylinder(radius: 0.005,
                                   height: CGFloat(distance))

        cylinder.radialSegmentCount = segments
        cylinder.firstMaterial?.diffuse.contents = UIColor.cyan

        let lineNode = SCNNode(geometry: cylinder)

        //lineNode.position = SCNVector3(((from.x + to.x)/2),
                                      // ((from.y + to.y)/2),
                                       //((from.z + to.z)/2))

        lineNode.eulerAngles = SCNVector3(Float.pi/2,
                                          acos((to.z - from.z)/distance),
                                          atan2(to.y - from.y, to.x - from.x))

        return lineNode
    }
}


