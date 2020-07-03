//
//  MyAreasVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class MyAreasViewController: UIViewController {
    
    @IBOutlet var myAreasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAreasTableView.delegate = self
        myAreasTableView.dataSource = self
    
    }
}

extension MyAreasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
    
}

extension MyAreasViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath)
        
        return cell
    }
    
}
