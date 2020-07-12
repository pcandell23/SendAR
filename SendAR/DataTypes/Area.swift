
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
    
    //Relationships
    @NSManaged public var subAreas: [Area]?
    @NSManaged public var superArea: Area?
    
    //Area needs a location variable or a lat/long variable
    
    // MARK: - Getter Functions
    func getName() -> String{
        return name ?? ""
    }
    
    func getUuid() -> UUID?{
        return uuid
    }
    
    func getSuperArea() -> Area? {
        return superArea
    }
    
    func getSubAreas() -> [Area] {
        return subAreas ?? [Area]()
    }
    
    func getFenceLatitude() -> String {
        return fenceLatitude ?? ""
    }
    
    func getFenceLongitude() -> String {
        return fenceLongitude ?? ""
    }
    
    func getFenceRadius() -> Int64 {
        return fenceRadius
    }
    
    // TODO: Fix this to return the correct format for needs.
    func getFenceCoordinates() -> String {
        return ""
    }
    
    func subAreaIsEmpty() -> Bool {
        if subAreas != nil {
            return subAreas!.isEmpty
        } else {
            return true
        }
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
    
    func setSuperArea(newSuperArea: Area){
        if(!newSuperArea.getSubAreas().contains(self)){
            addToSubAreas(self)
        }
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
    
    func setInitialValues(name: String? = nil, fenceLatitude: String? = nil, fenceLongitude: String? = nil, fenceRadius: Int64 = 0, subAreas: [Area]? = nil, superArea: Area? = nil){
        self.name = name
        self.fenceLatitude = fenceLatitude
        self.fenceLongitude = fenceLongitude
        self.fenceRadius = fenceRadius
        self.subAreas = subAreas
        self.superArea = superArea
        
        self.uuid = UUID()
    }
 
    func addSubArea(newSubArea: Area){
        if(newSubArea.getSuperArea() != self){
            newSubArea.setSuperArea(newSuperArea: self)
        }
        addToSubAreas(newSubArea)
    }
    
    func addSubAreas(newSubAreas: [Area]){
        for a in newSubAreas{
            if(a.getSuperArea() != self){
                a.setSuperArea(newSuperArea: self)
            }
        }
        addToSubAreas(newSubAreas)
    }
 
    // MARK: Generated accessors for subAreas
    @objc(addSubAreasObject:)
    @NSManaged public func addToSubAreas(_ value: Area)
 
    @objc(removeSubAreasObject:)
    @NSManaged public func removeFromSubAreas(_ value: Area)
 
    @objc(addSubAreas:)
    @NSManaged public func addToSubAreas(_ values: [Area])
 
    @objc(removeSubAreas:)
    @NSManaged public func removeFromSubAreas(_ values: [Area])
    
    
    
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

