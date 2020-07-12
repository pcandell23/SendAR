//
//  AreaView.swift
//  SendAR
//
//  Created by Peter Candell on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class AreaDetail: UIViewController{
    
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    
    
    var subAreas: [Area] = [Area]()
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
       }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subAreas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.areaName.text = subAreas[indexPath.row].getName()
        
        return cell
    }
    
    
}

