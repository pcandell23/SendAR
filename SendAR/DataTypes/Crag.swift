//
//  Crag.swift
//  SendAR
//
//  Created by Peter Candell on 6/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation

class Crag: Area {
    
    private var routes: [Route] = [Route]()
    
    init(name: String, superArea: Area, routes: [Route]){
        super.init(name: name, superArea: superArea)
        self.routes = routes
    }
    
    // MARK: - Getters
    
    func getRoutes() -> [Route]{
        return routes
    }
    
    override func getSubArea() -> [Area] {
        //There are no sub areas in a crag so this returns an empty array
        return []
    }
    
    // MARK: - Setters
    
    //TODO: Make these show an error to the user if failed.
    
    func addRoutes(newRoutesArray: [Route]){
        routes += newRoutesArray
    }
    
    func removeRoute(index: Int) -> Route{
        return routes.remove(at: index)
    }
    
    override func addSubAreas(newSubAreasArray: [Area]) {
        // Does nothing.
        // TODO: Will probs log an error once we have that set up
    }
    
    override func removeSubArea(index: Int) -> Area? {
        // Does nothing.
        // TODO: Again will log an error and let the user know they cant do this with some helpful message
        return nil
    }
}
