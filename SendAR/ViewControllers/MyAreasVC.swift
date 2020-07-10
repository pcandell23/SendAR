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
    
    //simple placeholder because I'm confused on accessing objects in arrays
    var routes: [Route] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RouteCell", bundle: nil)
        myAreasTableView.register(nib, forCellReuseIdentifier: "RouteCell")
        myAreasTableView.delegate = self
        myAreasTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRoutes()
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        cell.routeName.text = routes[indexPath.row].getName()
        cell.routeGrade.text = String(routes[indexPath.row].getGrade())
        
        return cell
    }
    
    func fetchRoutes(){
        let moc = delegate.dataController?.persistentContainer.viewContext
        if moc == nil{
            print("Failed to fetch routes.")
            return
        }
        let requestRoutes = NSFetchRequest<Route>(entityName: "Route")
        var fetched: [Route]?
        do {
            fetched = try moc?.fetch(requestRoutes)
        } catch {
            print("Could not fetch. \(error)")
        }
        
        if fetched != nil {
            routes = fetched!
        }
    }
    
}
