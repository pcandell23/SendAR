//
//  Route.swift
//  SendAR
//
//  Created by Peter Candell on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
//
 
import Foundation
import CoreData
 
@objc(Route)
public class Route: NSManagedObject {
    let delegate = AppDelegate.shared()
}
 
extension Route {
 
    //Attributes
    @NSManaged public var grade: String?
    @NSManaged public var height: Int32
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var type: String?
    @NSManaged public var pitches: Int16
    
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var altitude: Int16
    
    @NSManaged public var uuid: UUID?
    
    
    //Relationships
    @NSManaged public var crag: Crag?
    
    // MARK: - Getters
           
    func getName() -> String {
        return name ?? ""
    }
       
    // These next functions do optional checking as I think it'll be easier to do it here so that we don't have any accidental errors in other places. May change.
    func getType() -> String {
        return type ?? ""
    }
       
    func getRating() -> Double{
            return rating
    }
       
    func getGrade() -> String{
        if grade != nil{
            return grade!
        } else {
            return ""
        }
    }
    
    func getPitches() -> Int16{
        return pitches
    }
       
    func getCrag() -> Area?{
        if crag != nil{
            return crag!
        } else {
            return nil
        }
    }
    
    func getLatitude() -> String{
        return latitude ?? ""
    }
    
    func getLongitude() -> String{
        return longitude ?? ""
    }
    
    func getAltitude() -> Int16 {
        return altitude
    }
    
    func getUuid() -> UUID?{
        return uuid
    }
    
    // MARK: - Setters

       // TODO: Add error handling and showing to these. As well as check to make sure the name (not racist, idk how we could do that but we can try), grade, and type are actual grades and types and that they match(this will also apply to the init function)
    func setName(_ newName: String){
        self.name = newName
    }
    
    func setRating(_ newRating: Double){
        self.rating = newRating
    }
       
    func setGrade(_ newGrade: String){
        self.grade = newGrade
    }
    
    func setPitches(_ newPitches: Int16){
        self.pitches = newPitches
    }
    
    func setHeight(_ newHeight: Int32){
        self.height = newHeight
    }
       
    func setCrag(_ newCrag: Crag){
        self.crag = newCrag
    }
    
    func setLatitude(_ newLatitude: String){
        self.latitude = newLatitude
    }
    
    func setLongitude(_ newLongitude: String){
        self.longitude = newLongitude
    }
    
    func setAltitude(_ newAltitude: Int16){
        self.altitude = newAltitude
    }
    
    func setInitialValues(name: String? = nil, grade: String? = nil, rating: Double = 0.0, height: Int32 = 0, type: String? = nil, pitches: Int16 = 0, crag: Crag? = nil, latitude: String? = nil, longitude: String? = nil, altitude: Int16 = 0){
        self.name = name
        self.grade = grade
        self.rating = rating
        self.height = height
        self.pitches = pitches
        self.type = type
        
        self.crag = crag
        
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        
        self.uuid = UUID()
    }
    
    
    // MARK: Save and fetch functions
    func save(){
        if delegate.dataController != nil{
            delegate.dataController!.saveContext()
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }
}
