//
//  Crag.swift
//  SendAR
//
//  Created by Peter Candell on 6/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
 
import Foundation
import CoreData
 
class Crag: Area {
    
    @NSManaged public var routes: [Route]?
    
    // MARK: - Getters
    
    func getRoutes() -> [Route]{
        return routes ?? [Route]()
    }
 
}
 
    // MARK: Generated accessors for routes
extension Crag {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }
 
    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: NSManagedObject)
 
    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: NSManagedObject)
 
    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: [Route]) 
 
    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: [Route])
 
}
