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
    
    let areas: [Area] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        nearbyAreasTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        nearbyAreasTableView.delegate = self
        nearbyAreasTableView.dataSource = self
    
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
    
}
