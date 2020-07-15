//
//  MyAreasVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class MyAreasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myAreasTableView: UITableView!
    
    let delegate = AppDelegate.shared()
    
    var areas: [Area] = []
    
    var areaIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        myAreasTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        myAreasTableView.delegate = self
        myAreasTableView.dataSource = self
        fetchAreas()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.areaName.text = areas[indexPath.row].getName()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO
        if segue.identifier == "MyAreasToArea"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! AreaDetailVC
            vc.area = areas[areaIndex]
        } else if segue.identifier == "MyAreasToCrag"{
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
            performSegue(withIdentifier: "MyAreasToCrag", sender: cell)
        } else {
            performSegue(withIdentifier: "MyAreasToArea", sender: cell)
        }

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
            areas = fetched!
        }
    }
    
}
