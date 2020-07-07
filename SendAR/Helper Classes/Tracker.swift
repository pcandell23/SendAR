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
    var startTime: String
    var stopTime: String
    var locationAccess: CLLocationManager
    var timer: Timer
    var currentLocation: CLLocation!
    var timeCount: Int = 0
    
    init(routeName: String, data: String, startTime: String, stopTime: String, timer: Timer, currentLocation: CLLocation, locationAccess: CLLocationManager) {
        self.routeName = routeName
        self.data = data
        self.startTime = startTime
        self.stopTime = stopTime
        self.timer = timer
        self.currentLocation = currentLocation
        self.locationAccess = locationAccess
    }
    
    func startTracking() {
        data = "\(routeName)\nlat, long, alt, time, \(startTime)\n"
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.recordPosition), userInfo: nil, repeats: true)
        
    }
    
    func stopTracking(stopTime: String) {
        recordPosition()
        self.stopTime = stopTime
        timer.invalidate()
        data += " , , , , \(stopTime)"
    }
    
    @objc func recordPosition() {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLocation = locationAccess.location
            
            data += "\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude), \(currentLocation.altitude), \(timeCount)\n"
        }
        
        timeCount += 5
    }
    
    
}
