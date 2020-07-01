//
//  Route.swift
//  SendAR
//
//  Created by Peter Candell on 6/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation


class Route{
    
    private var name: String
    private var type: String?
    private var grade: String?
    private var rating: Double?
    private var area: Area
    

    init(name: String, type:String, grade:String?, rating: Double?, area: Area){
        self.name = name
        self.type = type
        self.grade = grade
        self.rating = rating
        self.area = area
    }
    
    // MARK: - Getters
        
    func getName() -> String {
        return name
    }
    
    // These next functions do optional checking as I think it'll be easier to do it here so that we don't have any accidental errors in other places. May change.
    func getType() -> String {
        if type != nil{
            return type!
        } else {
            return ""
        }
    }
    
    func getGrade() -> String{
        if grade != nil{
            return grade!
        } else {
            return ""
        }
    }
    
    func getRating() -> Double{
        if rating != nil{
            return rating!
        } else {
            return 0.0
        }
    }
    
    func getArea() -> Area{
        return area
    }
    
    // MARK: - Setters
    // TODO: Add error handling and showing to these. As well as check to make sure the name (not racist, idk how we could do that but we can try), grade, and type are actual grades and types and that they match(this will also apply to the init function)
    func changeName(newName: String){
        self.name = newName
    }
    
    func changeGrade(newGrade: String){
        self.grade = newGrade
    }
    
    func changeRating(newRating: Double){
        self.rating = newRating
    }
    
    func changeArea(newArea: Area){
        self.area = newArea
    }
}
