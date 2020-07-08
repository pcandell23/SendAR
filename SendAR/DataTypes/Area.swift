
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
 
}
 
extension Area {
 
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }
 
    @NSManaged public var name: String?
    @NSManaged public var subAreas: [Area]?
    @NSManaged public var superArea: Area?
    
    // MARK: - Getter Functions
    func getName() -> String{
        return name ?? ""
    }
    
    func getSuperArea() -> Area?{
        return superArea
    }
    
    func getSubArea() -> [Area] {
        return subAreas ?? [Area]()
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
    
    
    // TODO: Will probably make these all return Bools that return if it succedded or not but for now not gonna worry about it. Might be try catch loops idk the right way in swift that will show the user it failed. Probs both tbh
    
    func changeName(newName: String){
        self.name = newName
    }
    
    func changeSuperArea(newSuperArea: Area){
        self.superArea = newSuperArea
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
 
}

