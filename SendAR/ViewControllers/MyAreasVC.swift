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
    var myIndex = 0
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        self.performSegue(withIdentifier: "MyAreasToArea", sender: self)
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
