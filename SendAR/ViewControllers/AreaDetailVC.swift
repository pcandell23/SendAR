//
//  AreaDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class AreaDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var areaDescription: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    
    var area: Area?
    //var areaName: String = "Area Name"
    var myIndex = 0
    var subAreas: [Area]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if area != nil {
            //self.areaName = area!.getName()
            self.title = area!.getName()
            if area?.getSubAreas() != nil{
                subAreas = Array(_immutableCocoaArray: area!.getSubAreas()!)
            }
        }
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subAreas != nil {
            return subAreas!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
        if subAreas != nil{
            cell.areaName.text = subAreas![indexPath.row].getName()
        } else {
            cell.areaName.text = "Sub Area Name"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        //self.performSegue(withIdentifier: "AreaToCrag", sender: self)
    }
    
    
}
