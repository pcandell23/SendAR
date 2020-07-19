//
//  RouteDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class RouteDetailVC: UIViewController {

    @IBOutlet weak var routeGrade: UILabel!
    @IBOutlet weak var routeRating: UILabel!
    @IBOutlet weak var routeDimensions: UILabel! //interpolated string of type, pitches and height
    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var routeShape: UIImageView!
    @IBOutlet weak var routeDescription: UILabel!
    @IBOutlet weak var routeLocation: UILabel!
    
    var route: Route? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if route != nil {
            self.title = route!.getName()
            self.routeGrade.text = route!.getGrade()
            
            let rating = route!.getRating()
            if rating > 4 && rating <= 5 {
                self.routeRating.text = "⭐️⭐️⭐️⭐️⭐️"
            } else if rating > 3 {
                self.routeRating.text = "⭐️⭐️⭐️⭐️"
            } else if rating > 2 {
                self.routeRating.text = "⭐️⭐️⭐️"
            } else if rating > 1 {
                self.routeRating.text = "⭐️⭐️"
            } else if rating > 0 {
                self.routeRating.text = "⭐️"
            }
            
            self.routeDimensions.text = "\(route!.getType()), \(route!.getPitches()) pitches, \(route!.getAltitude()) feet"
            self.routeDescription.text = route!.getDescription()
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        routeDescription.sizeToFit()
        routeLocation.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
