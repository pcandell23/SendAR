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
    
    @NSManaged public var routes: NSSet?
    
    // MARK: - Getters
    
    func getRoutes() -> NSSet?{
        return routes
    }
    
    func getRoutesAsArray() -> [Route]{
        if routes != nil {
            return routes!.allObjects as? [Route] ?? []
        } else {
            return []
        }
    }
    
    func routeCount() -> Int {
        var numRoutes = 0
        if routes != nil {
            numRoutes = getRoutesAsArray().count
        }
        return numRoutes
    }
    
    func addRoute(newRoute: Route){
        addToRoutes(newRoute)
    }
    
    func addRoutes(newRoutes: NSSet){
        addToRoutes(newRoutes) 
    }
}
 
    // MARK: Generated accessors for routes
extension Crag {
 
    @objc(addRoutesObject:)
    @NSManaged public func addToRoutes(_ value: NSManagedObject)
 
    @objc(removeRoutesObject:)
    @NSManaged public func removeFromRoutes(_ value: NSManagedObject)
 
    @objc(addRoutes:)
    @NSManaged public func addToRoutes(_ values: NSSet)
 
    @objc(removeRoutes:)
    @NSManaged public func removeFromRoutes(_ values: NSSet)
    
    // MARK: Fetch function
    // Save function is in parent Area
 
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crag> {
        return NSFetchRequest<Crag>(entityName: "Crag")
    }
    
    static public func storeNewCrag(name: String? = nil, description: String? = nil, fenceLatitude: String? = nil, fenceLongitude: String? = nil, fenceRadius: Int64 = 0, subAreas: NSSet? = nil, superArea: Area? = nil) -> Crag{
        
        let newCrag = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: AppDelegate.shared().dataController!.persistentContainer.viewContext) as! Crag
        
        newCrag.setInitialValues(name: name, description: description, fenceLatitude: fenceLatitude, fenceLongitude: fenceLongitude, fenceRadius: fenceRadius, subAreas: subAreas, superArea: superArea)
        
        AppDelegate.shared().dataController!.saveContext()
        
        return newCrag
    }
}
