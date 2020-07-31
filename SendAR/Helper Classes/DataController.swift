//
//  DataController.swift
//  SendAR
//
//  Created by Peter Candell on 7/8/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataController: NSObject{
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        
        let container = NSPersistentContainer(name: "AreaAndRouteData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Failed to create persistant store \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: EXAMPLE ROUTE ADDED SHOULD BE DELETED ON PRODUCTION
    
    var areas: [Area] = []
    var routes: [Route] = []
    
    func addInExampleRoutes(){
        fetchAreas()
        let moc = persistentContainer.viewContext
        if(areas.count != 0){
            print("got to here?")
            return
            
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
//
//            // Create Batch Delete Request
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//            do {
//                try moc.execute(batchDeleteRequest)
//
//            } catch {
//                // Error Handling
//            }
//            let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Crag")
//
//                       // Create Batch Delete Request
//                       let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
//
//                       do {
//                           try moc.execute(batchDeleteRequest2)
//
//                       } catch {
//                           // Error Handling
//                       }
//            let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Route")
//
//            // Create Batch Delete Request
//            let batchDeleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
//
//            do {
//                try moc.execute(batchDeleteRequest3)
//
//            } catch {
//                // Error Handling
//            }
        } else {
            print("were here")
            areas = []
        }
        
        
        routes.append(storeNewRouteInfo(moc: moc, newRouteName: "Snake Dike EX", grade: "5.7 R", rating: 4, height: 400, type: "Trad", pitches: 8, crag: nil, latitude:  "37.7395582", longitude: "-119.5404614", altitude: 2000, description: "Follows a beatiful dike up the right side of Half Dome, A must do adventure"))
        
        routes.append(storeNewRouteInfo(moc: moc, newRouteName: "RNWF EX", grade: "5.12c A0", rating: 5, height: 700, type: "Trad, Aid", pitches: 23, crag: nil, latitude: "37.7471595", longitude: "-119.5340351", altitude: 1900, description: "The original line up the face of half dome"))
        
        areas.append(storeNewCragInfo(moc: moc, newCragName: "Half Dome EX", latitude: "37.7443619", longitude: "-119.5348686", radius: 200, routes: nil, superArea: nil, description: "The first true Big Wall and probably the most recognizable rock in the world."))
        
        let c = areas[0] as! Crag
        c.addRoute(newRoute: routes[0])
        c.addRoute(newRoute: routes[1])

        
        areas.append(storeNewAreaInfo(moc: moc, newAreaName: "Yosemite Valley EX", latitude: "37.7272727", longitude: "-119.6251977", radius: 3000, subAreas: [areas[0]], superArea: nil, description: "The mecca of rock climbing, the birthplace of big wall, and the home of El Capitan"))
        
        areas[0].setSuperArea(newSuperArea: areas[1])
        
        areas.append(storeNewAreaInfo(moc: moc, newAreaName: "Sub Area with no subAreas EX", latitude: "37.7282727", longitude: "-119.6261977", radius: 100, subAreas: nil, superArea: areas[1], description: "This sub area has no areas under it to make sure that it works this way"))
        
        areas[1].addSubArea(newSubArea: areas[2])
        
        saveContext()
    }
    
    
    func fetchAreas(){
        let moc = persistentContainer.viewContext
        let requestAreas = NSFetchRequest<Area>(entityName: "Area")
        var fetched: [Area]?
        do {
            fetched = try moc.fetch(requestAreas)
        } catch {
            print("Could not fetch. \(error)")
        }
        
        if fetched != nil {
            areas = fetched!
        }
    }
    
    func storeNewAreaInfo(moc: NSManagedObjectContext, newAreaName: String, latitude: String, longitude: String, radius: Int64, subAreas: NSSet?, superArea: Area?, description: String) -> Area{
        let newArea = NSEntityDescription.insertNewObject(forEntityName: "Area", into: moc) as! Area
        
        newArea.setInitialValues(name: newAreaName, description: description, fenceLatitude: latitude, fenceLongitude: longitude, fenceRadius: radius, subAreas: subAreas, superArea: superArea)
        
        return newArea
    }
    
    func storeNewCragInfo(moc: NSManagedObjectContext, newCragName: String, latitude: String, longitude: String, radius: Int64, routes: [Route]?, superArea: Area?, description: String) -> Crag{
        let newCrag = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: moc) as! Crag
        
        newCrag.setInitialValues(name: newCragName, description: description, fenceLatitude: latitude, fenceLongitude: longitude, fenceRadius: radius, subAreas: nil, superArea: superArea)
        
        if(routes != nil){
            print(routes!)
            newCrag.addRoutes(newRoutes: NSSet(object: routes!))
        }
        
        return newCrag
    }
    
    func storeNewRouteInfo(moc: NSManagedObjectContext, newRouteName: String, grade: String?, rating: Double, height: Int32, type: String?, pitches: Int16, crag: Crag?, latitude: String?, longitude: String?, altitude: Int16, description: String?) -> Route{
        
        let newRoute = NSEntityDescription.insertNewObject(forEntityName: "Route", into: moc) as! Route
        
        newRoute.setInitialValues(name: newRouteName, grade: grade, rating: rating, height: height, type: type, pitches: pitches, crag: crag, latitude: latitude, longitude: longitude, altitude: altitude, description: description)
        
        return newRoute
    }
}
