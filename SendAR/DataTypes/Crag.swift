//
//  Crag.swift
//  SendAR
//
//  Created by Peter Candell on 6/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
 
import Foundation
import CoreData
 
@objc(Crag)
public class Crag: Area {
    
    @NSManaged public var routes: [Route]?
    
    // MARK: - Getters
    
    func getRoutes() -> [Route]{
        return routes ?? [Route]()
    }
}
 
    // MARK: Generated accessors for routes
extension Crag {
 
    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: NSManagedObject)
 
    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: NSManagedObject)
 
    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: [Route]) 
 
    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: [Route])
    
    // MARK: Fetch function
    // Save function is in parent Area
 
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crag> {
        return NSFetchRequest<Crag>(entityName: "Crag")
    }
}
