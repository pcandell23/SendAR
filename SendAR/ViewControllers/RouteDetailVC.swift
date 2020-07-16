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
            self.routeRating.text = String(route!.getRating())
            // TODO bennett idk how you want this to look
            self.routeDimensions.text = route!.getType()
            
            self.routeDescription.text = route!.getDescription()
        }
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
