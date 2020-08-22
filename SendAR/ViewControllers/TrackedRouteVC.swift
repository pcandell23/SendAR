//
//  TrackedRouteVC.swift
//  SendAR
//
//  Created by Bennett Baker on 8/2/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class TrackedRouteVC: UIViewController {

    @IBOutlet weak var routeHeight: UILabel!
    @IBOutlet weak var routeTime: UILabel!
    
    var trackedRoute: TrackedRoute? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if trackedRoute != nil {
            self.title = trackedRoute!.getName()
        }
        if let heightInMeters = trackedRoute?.getElapsedAltitude() {
            routeHeight.text = String(format: "%.1f m", heightInMeters)
        }
        if let timeInSeconds = trackedRoute?.getElapsedTime() {
            routeTime.text = String(format: "%.2f minutes", (timeInSeconds / 60.0))
        }
        // Do any additional setup after loading the view.
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
