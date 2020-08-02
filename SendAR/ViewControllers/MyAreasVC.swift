//
//  MyAreasVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class MyAreasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var myAreasTableView: UITableView!
    @IBOutlet weak var editButtonTitle: UIBarButtonItem!
    
    
    let delegate = AppDelegate.shared()
    
    var areas: [Area] = []
    var crags: [Crag] = []
    var areasAndCrags = [Area]()
    var filteredAreasAndCrags: [Area]!
    
    var areaIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let areaNib = UINib(nibName: "AreaCell", bundle: nil)
        myAreasTableView.register(areaNib, forCellReuseIdentifier: "AreaCell")
        let cragNib = UINib(nibName: "CragCell", bundle: nil)
        myAreasTableView.register(cragNib, forCellReuseIdentifier: "CragCell")
        myAreasTableView.delegate = self
        myAreasTableView.dataSource = self
        fetchAreas()
        filteredAreasAndCrags = areasAndCrags
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredAreasAndCrags = []
        
        if searchText == "" {
            filteredAreasAndCrags = areasAndCrags
        } else {
            for areaOrCrag in areasAndCrags {
                if areaOrCrag.getName().lowercased().contains(searchText.lowercased()) {
                    filteredAreasAndCrags.append(areaOrCrag)
                }
            }
        }
        
        self.myAreasTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAreasAndCrags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.filteredAreasAndCrags[indexPath.row] is Crag {
            let cragCell = tableView.dequeueReusableCell(withIdentifier: "CragCell", for: indexPath) as! CragCell
            
            cragCell.cragName.text          = (filteredAreasAndCrags[indexPath.row] as! Crag).getName()
            cragCell.cragProximity.text     = cragCell.getProximity()
            cragCell.numberOfRoutes.text    = String((filteredAreasAndCrags[indexPath.row] as! Crag).routeCount()) + " routes"
            
            return cragCell
        } else {
            let areaCell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
            
            areaCell.areaName.text          = (filteredAreasAndCrags[indexPath.row] ).getName()
            areaCell.areaProximity.text     = areaCell.getProximity()
            if (filteredAreasAndCrags[indexPath.row] ).subAreaCount() > 0 {
                areaCell.subAreasLabel.text = String((filteredAreasAndCrags[indexPath.row] ).subAreaCount()) + " sub-areas"
            } else {
                areaCell.subAreasLabel.text = "No sub-areas"
            }
            
            return areaCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete {
                let moc = delegate.dataController?.persistentContainer.viewContext
                if moc == nil {
                    return
                }
                let commit = filteredAreasAndCrags[indexPath.row]
                moc!.delete(commit)
                filteredAreasAndCrags.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                delegate.dataController?.saveContext()
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        if(self.myAreasTableView.isEditing == true) {
            self.myAreasTableView.isEditing = false
            editButtonTitle.title = "Edit"
        } else {
            self.myAreasTableView.isEditing = true
            editButtonTitle.title = "Done"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyAreasToArea"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! AreaDetailVC
            vc.area = filteredAreasAndCrags[areaIndex]
        } else if segue.identifier == "MyAreasToCrag"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! CragDetailVC
            vc.crag = filteredAreasAndCrags[areaIndex] as? Crag
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        areaIndex = indexPath.row
        
        if type(of: filteredAreasAndCrags[areaIndex]) == Crag.self{
            performSegue(withIdentifier: "MyAreasToCrag", sender: cell)
        } else {
            performSegue(withIdentifier: "MyAreasToArea", sender: cell)
        }

        performSegue(withIdentifier: "MyAreasToArea", sender: cell)
    }

    func fetchAreas(){
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
            areasAndCrags = fetched!
        }
    }
    
}
