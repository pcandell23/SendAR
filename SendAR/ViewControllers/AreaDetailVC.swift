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
    var subAreasAndCrags = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if area != nil {
            areaName.title = area!.getName()
            self.subAreas = area!.getSubAreasAsArray()
            self.areaDescription.text = area!.getDescription()
        }
           // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        subAreaTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        let cragNib = UINib(nibName: "CragCell", bundle: nil)
        subAreaTableView.register(cragNib, forCellReuseIdentifier: "CragCell")
        subAreaTableView.delegate = self
        subAreaTableView.dataSource = self
        
        for each in subAreas {
            subAreasAndCrags.append(each)
        }
        for each in crags {
            subAreasAndCrags.append(each)
        }
       }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subAreasAndCrags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.subAreasAndCrags[indexPath.row] is Area  {
            let areaCell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
            
            areaCell.areaName.text = (subAreasAndCrags[indexPath.row] as! Area).getName()
            areaCell.areaProximity.text = "TODO"
            if (subAreasAndCrags[indexPath.row] as! Area).subAreaCount() > 0 {
                areaCell.subAreasLabel.text = String((subAreasAndCrags[indexPath.row] as! Area).subAreaCount()) + " sub-areas"
            } else {
                areaCell.subAreasLabel.text = "No sub-areas"
            }
            
            return areaCell
            
        } else if self.subAreasAndCrags[indexPath.row] is Crag {
            let cragCell = tableView.dequeueReusableCell(withIdentifier: "CragCell", for: indexPath) as! CragCell
            
            cragCell.cragName.text = (subAreasAndCrags[indexPath.row] as! Crag).getName()
            cragCell.cragProximity.text = "TODO"
            cragCell.numberOfRoutes.text = String((subAreasAndCrags[indexPath.row] as! Crag).routeCount())
            
            return cragCell
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreaToCrag"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! CragDetailVC
            vc.crag = subAreas[subIndex] as? Crag
        } else if segue.identifier == "AreaToArea"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! AreaDetailVC
            vc.area = subAreas[subIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        subIndex = indexPath.row

        performSegue(withIdentifier: "AreaToCrag", sender: cell)
        
        if type(of: subAreas[subIndex]) == Crag.self{
            performSegue(withIdentifier: "AreaToCrag", sender: cell)
        } else {
            performSegue(withIdentifier: "AreaToArea", sender: cell)
        }
    }
}
 
