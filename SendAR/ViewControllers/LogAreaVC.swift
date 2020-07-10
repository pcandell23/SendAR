//
//  LogAreaVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/10/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit

class LogAreaVC: UIViewController, MKMapViewDelegate {

    @IBAction func cancelButton(_ sender: Any) {
        //dismiss page
    }
    
    @IBOutlet weak var areaName: UITextField!
    
    @IBOutlet weak var areaMap: MKMapView!
    
    @IBAction func confirmNewArea(_ sender: Any) {
        //save area region and dismiss
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        areaName.resignFirstResponder()
        return true
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
