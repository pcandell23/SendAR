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
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)

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
            areas = fetched!
        }
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
