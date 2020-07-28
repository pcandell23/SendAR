//
//  TrackedRoute.swift
//  SendAR
//
//  Created by Bennett Baker on 7/27/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import CoreData

/*
@objc(TrackedRoute)
public class TrackedRoute: NSManagedObject {
    let delegate = AppDelegate.shared()
}

extension TrackedRoute {
    //MARK: - Attributes
    @NSManaged public var name: String?
    @NSManaged public var startTime: String?
    @NSManaged public var stopTime: String?
    @NSManaged public var startAltitude: String?
    @NSManaged public var stopAltitude: String?
    @NSManaged public var dataCSV: String?
    
    @NSManaged public var uuid: UUID?
    
    //MARK: - Getters
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getStartTime() -> String {
        return startTime ?? ""
    }
    
    func getStopTime() -> String {
        return stopTime ?? ""
    }
    
    func getStartAltitude() -> String {
        return startAltitude ?? ""
    }
    
    func getStopAltitude() -> String {
        return stopAltitude ?? ""
    }
    
    func getDataCSV() -> String {
        return dataCSV ?? ""
    }
    
    //MARK: - Setters
    
    func setName(_ newName: String) {
        self.name = newName
    }
    
    func setStartTime(_ newStartTime: String) {
        self.startTime = newStartTime
    }
    
    func setStopTime(_ newStopTime: String) {
        self.stopTime = newStopTime
    }
    
    func setStartAltitude(_ newStartAltitude: String) {
        self.startAltitude = newStartAltitude
    }
    
    func setStopAltitude(_ newStopAltitude: String) {
        self.stopAltitude = newStopAltitude
    }
    
    func setDataCSV(_ newDataCSV: String) {
        self.dataCSV = newDataCSV
    }
    
    func setInitialValues(name: String? = nil, startTime: String? = nil, stopTime: String? = nil, startAltitude: String? = nil, stopAltitude: String? = nil, dataCSV: String? = nil) {
        self.name = name
        self.startTime = startTime
        self.stopTime = stopTime
        self.startAltitude = startAltitude
        self.stopAltitude = stopAltitude
        self.dataCSV = dataCSV
        
        self.uuid = UUID()
    }
    
    
    //MARK: - Save and Fetch Functions
    func save() {
        if delegate.dataController != nil {
            delegate.dataController!.saveContext()
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackedRoute> {
        return NSFetchRequest<TrackedRoute>(entityName: "TrackedRoute")
    }
    
}
*/
