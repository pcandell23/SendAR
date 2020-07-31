//
//  NearbyAreas.swift
//  SendAR
//
//  Created by Bennett Baker on 7/2/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class NearbyAreasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nearbyAreasTableView: UITableView!
    
    let delegate = AppDelegate.shared()
    
    var areas: [Area] = []
    var crags: [Crag] = []
    var nearbyAreasAndCrags = [AnyObject]()
    var filteredList: [AnyObject]!
    
    var areaIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        nearbyAreasTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        let cragNib = UINib(nibName: "CragCell", bundle: nil)
        nearbyAreasTableView.register(cragNib, forCellReuseIdentifier: "CragCell")
        nearbyAreasTableView.delegate = self
        nearbyAreasTableView.dataSource = self
        fetchAreas()
        
        for each in areas {
            nearbyAreasAndCrags.append(each)
        }
        for each in crags {
            nearbyAreasAndCrags.append(each)
        }
        
        filteredList = nearbyAreasAndCrags
    
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = []
        
        
        if searchText == "" {
            filteredList = nearbyAreasAndCrags
        } else {
            for areaOrCrag in nearbyAreasAndCrags {
                //this part doesnt yet work
                if let indexIsCrag = areaOrCrag as? Crag {
                    if indexIsCrag.getName().lowercased().contains(searchText.lowercased()) {
                        filteredList.append(areaOrCrag)
                    }
                } else if let indexIsArea = areaOrCrag as? Area {
                    if indexIsArea.getName().lowercased().contains(searchText.lowercased()) {
                        filteredList.append(areaOrCrag)
                    }
                }
            }
        }
        
        self.nearbyAreasTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.filteredList[indexPath.row] is Area  {
            let areaCell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
            
            areaCell.areaName.text = (filteredList[indexPath.row] as! Area).getName()
            areaCell.areaProximity.text = areaCell.getProximity()
            if (filteredList[indexPath.row] as! Area).subAreaCount() > 0 {
                areaCell.subAreasLabel.text = String((filteredList[indexPath.row] as! Area).subAreaCount()) + " sub-areas"
            } else {
                areaCell.subAreasLabel.text = "No sub-areas"
            }
            
            return areaCell
            
        } else if self.filteredList[indexPath.row] is Crag {
            let cragCell = tableView.dequeueReusableCell(withIdentifier: "CragCell", for: indexPath) as! CragCell
            
            cragCell.cragName.text = (filteredList[indexPath.row] as! Crag).getName()
            cragCell.cragProximity.text = cragCell.getProximity()
            cragCell.numberOfRoutes.text = String((filteredList[indexPath.row] as! Crag).routeCount())
            
            return cragCell
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO
        if segue.identifier == "NearbyAreasToArea"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! AreaDetailVC
            vc.area = areas[areaIndex]
        } else if segue.identifier == "NearbyAreasToCrag"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! CragDetailVC
            vc.crag = areas[areaIndex] as? Crag
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        areaIndex = indexPath.row
        
        if type(of: areas[areaIndex]) == Crag.self{
            performSegue(withIdentifier: "NearbyAreasToCrag", sender: cell)
        } else {
            performSegue(withIdentifier: "NearbyAreasToArea", sender: cell)
        }

        performSegue(withIdentifier: "NearbyAreasToArea", sender: cell)
    }
    
    func fetchAreas() {
        let moc = delegate.dataController?.persistentContainer.viewContext
        if moc == nil{
            print("Failed to fetch routes.")
            return
        }
        let requestAreas = NSFetchRequest<Area>(entityName: "Area")
        var fetched: [Area]?
        do {
            fetched = try moc?.fetch(requestAreas)
        } catch {
            print("Could not fetch. \(error)")
        }
        
        if fetched != nil {
            areas = fetched!
        }
    }
    
    func fetchCrags() {
        //TODO
    }
    
}
