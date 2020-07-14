//
//  AreaDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class AreaDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var areaDescription: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    
<<<<<<< HEAD
    var area: Area?
    //var areaName: String = "Area Name"
    var myIndex = 0
    var subAreas: [Area]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if area != nil {
            //self.areaName = area!.getName()
            self.title = area!.getName()
            if area?.getSubAreas() != nil{
                subAreas = Array(_immutableCocoaArray: area!.getSubAreas()!)
            }
        }
=======
    var area: Area
    var subAreas: [Area] = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = area.getName()
           // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.area = Area()
        super.init(coder: aDecoder)
>>>>>>> 870ce27e1b66edd5f217dd45fa62d1fcbfbf8610
    }
    
    //TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subAreas != nil {
            return subAreas!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
        if subAreas != nil{
            cell.areaName.text = subAreas![indexPath.row].getName()
        } else {
            cell.areaName.text = "Sub Area Name"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
<<<<<<< HEAD
        myIndex = indexPath.row
        //self.performSegue(withIdentifier: "AreaToCrag", sender: self)
=======
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "AreaToCrag", sender: cell)
>>>>>>> 870ce27e1b66edd5f217dd45fa62d1fcbfbf8610
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
