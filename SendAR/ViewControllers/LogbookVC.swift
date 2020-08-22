//
//  LogbookVC.swift
//  SendAR
//
//  Created by Bennett Baker on 8/4/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData

class LogbookVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let delegate = AppDelegate.shared()
    
    var trackedRoutes: [TrackedRoute] = []
    var routeIndex: Int = 0
    
    @IBOutlet weak var logbookTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        logbookTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLoggedRoutes()
        
        let nib = UINib(nibName: "LogbookCell", bundle: nil)
        logbookTable.register(nib, forCellReuseIdentifier: "LogbookCell")
        logbookTable.delegate = self
        logbookTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Logbook Table
    
    func fetchLoggedRoutes(){
        let moc = AppDelegate.shared().dataController?.persistentContainer.viewContext
           if moc == nil{
               print("Failed to fetch Logged routes.")
               return
           }
           let requestRoutes = NSFetchRequest<TrackedRoute>(entityName: "TrackedRoute")
           var fetched: [TrackedRoute]?
           do {
               fetched = try moc?.fetch(requestRoutes)
           } catch {
               print("Could not fetch. \(error)")
           }
           
           if fetched != nil {
               trackedRoutes = fetched!
           }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackedRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogbookCell", for: indexPath) as! LogbookCell
        //initialize cell data fields here
        cell.routeName.text     = trackedRoutes[indexPath.row].getName()
        let timeInMinutes       = (trackedRoutes[indexPath.row].getElapsedTime() / 60.0)
        cell.routeTime.text     = String(format: "%.2f minutes", timeInMinutes)
        let heightInMeters      = trackedRoutes[indexPath.row].getElapsedAltitude()
        cell.routeHeight.text   = String(format: "%.1f m", heightInMeters)
        if let routeStartTime   = trackedRoutes[indexPath.row].getStartTime() {
            cell.routeDate.text = "\(routeStartTime)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        routeIndex = indexPath.row
        
        performSegue(withIdentifier: "LogbookToTrackedRoute", sender: cell)
    }
    
    //Make Editable
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete {
                let moc = delegate.dataController?.persistentContainer.viewContext
                if moc == nil {
                    return
                }
                let commit = trackedRoutes[indexPath.row]
                moc!.delete(commit)
                trackedRoutes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                delegate.dataController?.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogbookToTrackedRoute" {
            let vc = segue.destination as! TrackedRouteVC
            vc.trackedRoute = trackedRoutes[routeIndex]
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
