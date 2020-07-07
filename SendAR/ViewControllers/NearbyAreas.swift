//
//  NearbyAreas.swift
//  SendAR
//
//  Created by Bennett Baker on 7/2/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class NearbyAreasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nearbyAreasTableView: UITableView!
    
    //simple placeholder because I'm confused on accessing objects in arrays
    let routes = ["Snake Dike", "Royal Arches", "The Nose", "The Dawn Wall", "Freerider", "Cannibal Gulley", "Jellyroll Arch", "One Hand Clapping"]
    let ratings = ["5.6R", "5.7", "5.9", "5.Hard", "5.Alex", "5.Easy", "5.7", "5.9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RouteCell", bundle: nil)
        nearbyAreasTableView.register(nib, forCellReuseIdentifier: "RouteCell")
        nearbyAreasTableView.delegate = self
        nearbyAreasTableView.dataSource = self
    
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        cell.routeName.text = routes[indexPath.row]
        cell.routeGrade.text = ratings[indexPath.row]
        
        return cell
    }
    
}
