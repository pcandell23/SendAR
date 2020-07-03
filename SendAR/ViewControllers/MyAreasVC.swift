//
//  MyAreasVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class MyAreasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myAreasTableView: UITableView!
    
    //simple placeholder because I'm confused on accessing objects in arrays
    let routes = ["Snake Dike", "Royal Arches", "The Nose", "The Dawn Wall", "Freerider", "Cannibal Gulley", "Jellyroll Arch", "One Hand Clapping"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RouteCell", bundle: nil)
        myAreasTableView.register(nib, forCellReuseIdentifier: "RouteCell")
        myAreasTableView.delegate = self
        myAreasTableView.dataSource = self
    
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        cell.routeName.text = routes[indexPath.row]
        
        return cell
    }
    
}
