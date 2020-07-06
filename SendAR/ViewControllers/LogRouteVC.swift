//
//  LogRouteVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class LogRouteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var routeName: UITextField!
    @IBOutlet weak var routeGrade: UITextField!
    @IBOutlet weak var routeType: UITextField!
    @IBOutlet weak var routePitches: UITextField!
    @IBOutlet weak var routeRating: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeName.delegate = self
        routeGrade.delegate = self
        routeType.delegate = self
        routePitches.delegate = self
        routeRating.delegate = self
    }
    
    @IBAction func markLocationButton(_ sender: Any) {
        //records location as CSV when pressed
    }

    /*
     commented out because XCode keeps getting mad at me for the Area parameter and idk how to fix it
     
    func collectRouteData() {
        var newRoute = Route(name: "", grade: "", type: "", rating: 0.0, area: Area)
        newRoute.name = routeName.text
        newRoute.grade = routeGrade.text
        newRoute.type = routeType.text
        newRoute.rating = routeRating.text
        //dont know how to handle area
        
    }
 
 */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        routeName.resignFirstResponder()
        routeGrade.resignFirstResponder()
        routeType.resignFirstResponder()
        routePitches.resignFirstResponder()
        routeRating.resignFirstResponder()
        return true
    }
    
}
