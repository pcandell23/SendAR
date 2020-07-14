//
//  AreaDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class AreaDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var areaDescription: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    
    var areaName: String = "Area Name"
    var subAreas: [Area] = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = areaName
           // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        subAreaTableView.register(nib, forCellReuseIdentifier: "Area Cell")
        subAreaTableView.delegate = self
        subAreaTableView.dataSource = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "AreaToCrag", sender: cell)
    }
    
    
}

