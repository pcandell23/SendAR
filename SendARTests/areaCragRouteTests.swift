//
//  areaCragRouteTests.swift
//  SendARTests
//
//  Created by Peter Candell on 7/20/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import XCTest
@testable
import SendAR
import CoreData

class areaCragRouteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAreaCreation() throws {
        let dataController: DataController = DataController()
        let moc = dataController.persistentContainer.viewContext
        let a = NSEntityDescription.insertNewObject(forEntityName: "Area", into: moc) as! Area
        let sub = NSEntityDescription.insertNewObject(forEntityName: "Crag", into: moc) as! Crag
        let superA = NSEntityDescription.insertNewObject(forEntityName: "Area", into: moc) as! Area
        
        a.setInitialValues(name: "test Area654321", description: "test test", fenceLatitude: "0.0", fenceLongitude: "0.0", fenceRadius: Int64(100), subAreas: nil, superArea: nil)
        
        a.addSubArea(newSubArea: sub)
        a.setSuperArea(newSuperArea: superA)
        
        sub.setUUID()
        superA.setUUID()
        
        dataController.saveContext()
        
        let requestAreas = NSFetchRequest<Area>(entityName: "Area")
        requestAreas.predicate = NSPredicate(format: "uuid == %@", a.uuid! as CVarArg)
        var fetched: [Area]?
        fetched = try moc.fetch(requestAreas)
        let aTest = fetched![0]
        
        XCTAssert(aTest.getName() == "test Area654321", "failed to create area")
        XCTAssert(aTest.getSubAreas() == NSSet(object: sub), "Failed to set sub area")
        XCTAssert(aTest.getSuperArea() == superA, "Failed to set super area")
        
        let moc2 = dataController.persistentContainer.viewContext
        
        moc2.delete(aTest)
        
        let requestArea4 = NSFetchRequest<Area>(entityName: "Area")
        requestArea4.predicate = NSPredicate(format: "uuid == %@", a.uuid! as CVarArg)
        var fetched4: [Area]?
        fetched4 = try moc.fetch(requestAreas)
        
        XCTAssert(fetched4!.count == 0, "Failed to delete Area")
        
        let requestArea2 = NSFetchRequest<Crag>(entityName: "Crag")
        requestArea2.predicate = NSPredicate(format: "uuid == %@", sub.uuid! as CVarArg)
        var fetched2: [Area]?
        fetched2 = try moc.fetch(requestArea2)
        let subTest = fetched2![0]
        
        let requestArea3 = NSFetchRequest<Area>(entityName: "Area")
        requestArea2.predicate = NSPredicate(format: "uuid == %@", superA.uuid! as CVarArg)
        var fetched3: [Area]?
        fetched3 = try moc.fetch(requestArea3)
        let superTest = fetched3![0]
        
        moc2.delete(subTest)
        moc2.delete(superTest)
        
        dataController.saveContext()
        
        print("Tested create areas")
    }

}
