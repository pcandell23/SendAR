//
//  AreaDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class AreaNavC: UINavigationController{
    var area: Area? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class AreaDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var areaName: UINavigationItem!
    @IBOutlet weak var areaDescription: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    
    var subAreas: [Area] = []
    var crags: [Crag] = []
    var area: Area? = nil
    var subIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if area != nil {
            areaName.title = area!.getName()
            if area!.getSubAreasAsArray() != nil {
                self.subAreas = area!.getSubAreasAsArray()!
            }
        }
           // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        subAreaTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        let cragNib = UINib(nibName: "CragCell", bundle: nil)
        subAreaTableView.register(cragNib, forCellReuseIdentifier: "CragCell")
        subAreaTableView.delegate = self
        subAreaTableView.dataSource = self
       }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subAreas.count + crags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.areaName.text = subAreas[indexPath.row].getName()
        
        //add CragCell
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO
        if segue.destination is AreaDetailVC
        {
            let vc = segue.destination as? AreaDetailVC
            vc?.area = subAreas[subIndex]
        }
        if segue.identifier == "AreaToCrag"{
            let b = segue.destination as! CragDetailVC
            //b.element = self.randomElement
        }
        
        //add CragCell preparation
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        subIndex = indexPath.row

        performSegue(withIdentifier: "AreaToCrag", sender: cell)
        
        //add CragCell
    }
    
    func fetchAreas() {
        //TODO
    }
    
    func fetchRoutes() {
        //TODO
    }
}
 
