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
    var crag: Crag? = nil
    var routes: [Route] = []
    
    @IBOutlet weak var cragDescription: UILabel!
    @IBOutlet weak var cragMap: MKMapView!
    @IBOutlet weak var routeTable: UITableView!
    
    var routeIndex: Int  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if crag != nil{
            self.title = crag!.getName()
            self.routes = crag!.getRoutesAsArray()
            self.cragDescription.text = crag!.getDescription()
        }
        
        let nib = UINib(nibName: "RouteCell", bundle: nil)
        routeTable.register(nib, forCellReuseIdentifier: "RouteCell")
        routeTable.delegate = self
        routeTable.dataSource = self
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CragToRoute"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! RouteDetailVC
            vc.route = routes[routeIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        routeIndex = indexPath.row

        performSegue(withIdentifier: "CragToRoute", sender: cell)
    }
    
}
