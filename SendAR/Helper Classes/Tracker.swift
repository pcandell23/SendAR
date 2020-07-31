//
//  Tracker.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import CoreLocation

class Tracker {
    
    var routeName: String
    var data: String
    var startTime: Date
    var stopTime: Date?
    var locationAccess: CLLocationManager
    var timer: Timer
    var currentLocation: CLLocation!
    var timeCount: Int = 0
    
    init(routeName: String, data: String, startTime: Date, timer: Timer, currentLocation: CLLocation, locationAccess: CLLocationManager) {
        self.routeName          = routeName
        self.data               = data
        self.startTime          = startTime
        self.timer              = timer
        self.currentLocation    = currentLocation
        self.locationAccess     = locationAccess
    }
    
    func startTracking() {
        data    = ""
        timer   = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.recordPosition), userInfo: nil, repeats: true)
        
    }
    
    func stopTracking(stopTime: Date) {
        recordPosition()
        self.stopTime = stopTime
        timer.invalidate()
    }
    
    func saveTrackedRoute() -> TrackedRoute{
        let csvData = parseCSVString(csvStr: data)
        let trackedRoute = TrackedRoute.storeNewTrackedRoute(name: routeName, startTime: startTime, stopTime: stopTime, startAltitude: Double(csvData[0][2])!, stopAltitude: Double(csvData[csvData.count-1][2])! , data: data, route: nil)
        return trackedRoute
    } 
    
    func parseCSVString(csvStr: String) -> [[String]]{
        let subs = csvStr.components(separatedBy: "\n")
        var parsed = [[String]]()
        for s in subs{
            parsed.append(s.components(separatedBy: ", "))
        }
        if parsed[parsed.count-1] == [""]{
            parsed.remove(at: parsed.count-1)
        }
        return parsed
    }
    
    func makeCSV() -> String{
        var csv = ""
        csv += "\(routeName)\nlat, long, alt, time, \(startTime)\n"
        csv += data
        if stopTime != nil {
            csv += " , , , , \(stopTime!)"
        }
        return csv
    }
    
    @objc func recordPosition() {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLocation = locationAccess.location
            
            data += "\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude), \(currentLocation.altitude), \(timeCount)\n"
        }
        
        timeCount += 1
    }
    
    
}
