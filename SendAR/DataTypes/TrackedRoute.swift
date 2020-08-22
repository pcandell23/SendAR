//
//  TrackedRoute.swift
//  SendAR
//
//  Created by Bennett Baker on 7/27/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import CoreData

@objc(TrackedRoute)
public class TrackedRoute: NSManagedObject {
    let delegate = AppDelegate.shared()
}

extension TrackedRoute {
    //MARK: - Attributes
    @NSManaged public var name: String?
    
    @NSManaged public var startTime: Date?
    @NSManaged public var stopTime: Date?
    
    @NSManaged public var startAltitude: Double
    @NSManaged public var stopAltitude: Double
    
    @NSManaged public var data: String?
    @NSManaged public var uuid: UUID?

    @NSManaged public var route: Route?
    
    

    //MARK: - Getters
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getStartTime() -> Date? {
        return startTime
    }
    
    func getStopTime() -> Date? {
        return stopTime
    }
    
    func getStartAltitude() -> Double {
        return startAltitude
    }
    
    func getStopAltitude() -> Double {
        return stopAltitude
    }
    
    func getData() -> String {
        return data ?? ""
    }
    
    func getElapsedTime() -> Double {
        if stopTime != nil && startTime != nil{
            return stopTime!.timeIntervalSince(startTime! as Date)
        }else{
          return 0.0
        }
    }
    
    func getElapsedAltitude() -> Double {
        return stopAltitude - startAltitude
    }
    
    func getRoute() -> Route?{
        return route
    }
    
    func getParsedData() -> [[String]]{
        if data != nil {
            let parsedData = parseCSVString(csvStr: data!)
            return parsedData
        } else {
            return [["","","",""]]
        }
    }
    
    //MARK: - Setters
    
    func setName(_ newName: String) {
        self.name = newName
    }
    
    func setStartTime(_ newStartTime: Date) {
        self.startTime = newStartTime
    }
    
    func setStopTime(_ newStopTime: Date) {
        self.stopTime = newStopTime
    }
    
    func setStartAltitude(_ newStartAltitude: Double) {
        self.startAltitude = newStartAltitude
    }
    
    func setStopAltitude(_ newStopAltitude: Double) {
        self.stopAltitude = newStopAltitude
    }
    
    func setData(_ newData: String) {
        self.data = newData
    }
    
    func setRoute(_ newRoute: Route){
        self.route = newRoute
    }
    
    func setInitialValues(name: String? = nil, startTime: Date? = nil, stopTime: Date? = nil, startAltitude: Double, stopAltitude: Double, data: String? = nil, route: Route? = nil) {
        self.name = name
        self.startTime = startTime
        self.stopTime = stopTime
        self.startAltitude = startAltitude
        self.stopAltitude = stopAltitude
        self.data = data
        self.route = route
        
        self.uuid = UUID()
    }
    
    func parseCSVString(csvStr: String) -> [[String]]{
        let subs = csvStr.components(separatedBy: "\n")
        var parsed = [[String]]()
        for s in subs{
            parsed.append(s.components(separatedBy: ", "))
        }
        if parsed[parsed.count-1] == [""]{
            parsed.removeLast()
        }
        return parsed
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
    
    static func storeNewTrackedRoute(name: String? = nil, startTime: Date? = nil, stopTime: Date? = nil, startAltitude: Double, stopAltitude: Double, data: String? = nil, route: Route? = nil) -> TrackedRoute{
        
        let newTrackedRoute = NSEntityDescription.insertNewObject(forEntityName: "TrackedRoute", into: AppDelegate.shared().dataController!.persistentContainer.viewContext) as! TrackedRoute
        
        newTrackedRoute.setInitialValues(name: name, startTime: startTime, stopTime: stopTime, startAltitude: startAltitude, stopAltitude: stopAltitude, data: data, route: route)
        
        AppDelegate.shared().dataController!.saveContext()
        
        return newTrackedRoute
    }
    
    public static func fetchTrackedRoutes(/* TODO: Add in options */) -> [TrackedRoute]?{
        let moc = AppDelegate.shared().dataController?.persistentContainer.viewContext
        if moc == nil{
            print("Failed to fetch tracked routes.")
            return nil
        }
        let request = NSFetchRequest<TrackedRoute>(entityName: "TrackedRoute")
        var fetched: [TrackedRoute]?
        do {
            fetched = try moc?.fetch(request)
        } catch {
            print("Could not fetch. \(error)")
        }
        return fetched
    }
    
}

 

