//
//  CragDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import MapKit

class CragDetailVC: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    var cragName: String = "Crag Name"
    var crag: Crag
    var routesSet: NSSet
    var routes: [Route]
    
    @IBOutlet weak var cragDescription: UILabel!
    @IBOutlet weak var cragMap: MKMapView!
    @IBOutlet weak var routeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cragName
        
        let nib = UINib(nibName: "RouteCell", bundle: nil)
        routeTable.register(nib, forCellReuseIdentifier: "Route Cell")
        routeTable.delegate = self
        routeTable.dataSource = self
        
    }
    
    init(crag: Crag, routesSet: NSSet) {
        self.crag = crag
        self.routesSet = crag.getRoutes()!
        self.routes = Array(_immutableCocoaArray: routesSet)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.crag = Crag()
        self.routesSet = crag.getRoutes()!
        self.routes = Array(_immutableCocoaArray: routesSet)
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        cell.routeName.text = routes[indexPath.row].getName()
        cell.routeGrade.text = routes[indexPath.row].getGrade()
        cell.routeType.text = routes[indexPath.row].getType() + " - " + String(routes[indexPath.row].getPitches()) + " Pitches"
        let rating = routes[indexPath.row].getRating()
        if rating > 4 && rating <= 5 {
            cell.routeRating.text = "⭐️⭐️⭐️⭐️⭐️"
        } else if rating > 3 {
            cell.routeRating.text = "⭐️⭐️⭐️⭐️"
        } else if rating > 2 {
            cell.routeRating.text = "⭐️⭐️⭐️"
        } else if rating > 1 {
            cell.routeRating.text = "⭐️⭐️"
        } else if rating > 0 {
            cell.routeRating.text = "⭐️"
        }
        
        if routes[indexPath.row].getCrag() != nil {
            cell.routeArea.text = routes[indexPath.row].getCrag()!.getName()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "CragToRoute", sender: cell)
    }
    
}
