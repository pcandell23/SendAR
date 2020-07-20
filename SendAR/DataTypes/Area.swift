
//
//  Area.swift
//  SendAR
//
//  Created by Peter Candell on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
//
 
import Foundation
import CoreData
 
@objc(Area)
public class Area: NSManagedObject {
    let delegate = AppDelegate.shared()
    
}
 
extension Area {
    
    //Attributes
    @NSManaged public var name: String?
    @NSManaged public var fenceLatitude: String?
    @NSManaged public var fenceLongitude: String?
    @NSManaged public var fenceRadius: Int64
    @NSManaged public var uuid: UUID?
    @NSManaged public var areaDescription: String?
    
    //Relationships
    @NSManaged public var subAreas: NSSet?
    @NSManaged public var superArea: Area?
    
    // MARK: - Getter Functions
    func getName() -> String{
        return name ?? ""
    }
    
    func getUuid() -> UUID?{
        return uuid
    }
    
    func getDescription() -> String{
        return areaDescription ?? ""
    }
    
    func getSuperArea() -> Area? {
        return superArea
    }
    
    func getSubAreas() -> NSSet? {
        return subAreas
    }
    
    func getSubAreasAsArray() -> [Area]{
        if subAreas != nil {
            return subAreas!.allObjects as? [Area] ?? []
        } else {
            return []
        }
    } 
    
    func getFenceLatitude() -> String {
        return fenceLatitude ?? ""
    }
    
    func getFenceLongitude() -> String {
        return fenceLongitude ?? ""
    }
    
    func getFenceLatitudeDouble() -> Double {
        return Double(getFenceLatitude()) ?? 0
    }
    
    func getFenceLongitudeDouble() -> Double {
        return Double(getFenceLongitude()) ?? 0
    }
    
    func getFenceRadius() -> Int64 {
        return fenceRadius
    }
    
    // TODO: Fix this to return the correct format for needs.
    func getFenceCoordinates() -> String {
        return ""
    }
    
    func subAreaCount() -> Int {
        if subAreas != nil {
            return subAreas!.count
        } else {
            return 0
        }
    }
    
    // MARK: - Setter Functions
    
    // TODO: Will probably make these all return Bools that return if it succedded or not but for now not gonna worry about it. Might be do catch loops idk the right way in swift that will show the user it failed. Probs both tbh
    
    func setName(newName: String){
        self.name = newName
    }
    
    func setDescription(newDescription: String){
        self.areaDescription = newDescription
    }
    
    func setSuperArea(newSuperArea: Area){
        self.superArea = newSuperArea
    }
    
    func setFenceLatitude(newFenceLatitude: String){
        self.fenceLatitude = newFenceLatitude
    }
    
    func setFenceLongitude(newFenceLongitude: String){
        self.fenceLongitude = newFenceLongitude
    }
    
    func setFenceRadius(newFenceRadius: Int64){
        self.fenceRadius = newFenceRadius 
    }
    
//    func setUUID(){
//        if uuid == nil{
//            uuid = UUID()
//        }
//    }
    
    public func setInitialValues(name: String? = nil, description: String? = nil, fenceLatitude: String? = nil, fenceLongitude: String? = nil, fenceRadius: Int64 = 0, subAreas: NSSet? = nil, superArea: Area? = nil){
//        if uuid != nil {
//            return
//        }
        self.name = name
        self.areaDescription = description
        self.fenceLatitude = fenceLatitude
        self.fenceLongitude = fenceLongitude
        self.fenceRadius = fenceRadius
        self.subAreas = subAreas
        self.superArea = superArea
        
        self.uuid = UUID()
    }
 
    func addSubArea(newSubArea: Area){
        addToSubAreas(newSubArea)
    }
    
    func addSubAreas(newSubAreas: NSSet){
        addToSubAreas(newSubAreas)
    }
 
    // MARK: Generated accessors for subAreas
    @objc(addSubAreasObject:)
    @NSManaged public func addToSubAreas(_ value: Area)
 
    @objc(removeSubAreasObject:)
    @NSManaged public func removeFromSubAreas(_ value: Area)
 
    @objc(addSubAreas:)
    @NSManaged public func addToSubAreas(_ values: NSSet)
 
    @objc(removeSubAreas:)
    @NSManaged public func removeFromSubAreas(_ values: NSSet)
    
    
    
    // MARK: Saving and fetching functions
    
    func save(){
        if delegate.dataController != nil{
            delegate.dataController!.saveContext()
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }
}

