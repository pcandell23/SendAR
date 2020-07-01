//
//  Area.swift
//  SendAR
//
//  Created by Peter Candell on 6/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation

class Area {
    
    private var name: String
    private var superArea: Area? = nil
    private var subAreas: [Area] = [Area]()
    
    // MARK: - Initializers
    init(name: String){
        self.name = name
    }
    
    init(name: String, superArea: Area){
        self.name = name
        self.superArea = superArea
    }
    
    init(name: String, superArea: Area?, subAreas: [Area]){
        self.name = name
        self.superArea = superArea
        self.subAreas = subAreas
    }
    
    // MARK: - Getter Functions
    func getName() -> String{
        return name
    }
    
    func getSuperArea() -> Area?{
        return superArea
    }
    
    func getSubArea() -> [Area] {
        return subAreas
    }
    
    func subAreaIsEmpty() -> Bool {
        return subAreas.isEmpty
    }
    
    func subAreaCount() -> Int {
        return subAreas.count
    }
    
    // MARK: - Setter Functions
    
    
    // TODO: Will probably make these all return Bools that return if it succedded or not but for now not gonna worry about it. Might be try catch loops idk the right way in swift that will show the user it failed. Probs both tbh
    
    func changeName(newName: String){
        self.name = newName
    }
    
    func changeSuperArea(newSuperArea: Area){
        self.superArea = newSuperArea
    }
    
    // Adds new sub Areas to the subArea array, parameter must be an array.
    func addSubAreas(newSubAreasArray: [Area]){
        subAreas += newSubAreasArray
    }
    
    func removeSubArea(index: Int) -> Area{
        return subAreas.remove(at: index)
    }
    
}
