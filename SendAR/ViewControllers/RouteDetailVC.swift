//
//  RouteDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class RouteDetailVC: UIViewController {

    @IBOutlet weak var routeName: UINavigationItem!
    @IBOutlet weak var routeGrade: UILabel!
    @IBOutlet weak var routeRating: UILabel!
    @IBOutlet weak var routeDimensions: UILabel!
    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var routeShape: UIImageView!
    @IBOutlet weak var routeDescription: UILabel!
    @IBOutlet weak var routeLocation: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
