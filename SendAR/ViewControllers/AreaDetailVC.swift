//
//  AreaDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class AreaNavC: UINavigationController{
    var area: Area? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class AreaDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var subAreaView: UIView!
    @IBOutlet weak var subAreaViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subAreaTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var areaName: UINavigationItem!
    @IBOutlet weak var areaDescription: UILabel!
    @IBOutlet weak var subAreaTableView: UITableView!
    @IBOutlet weak var areaMap: MKMapView!
    @IBOutlet weak var noLocationLabel: UILabel!
    @IBAction func dismissVCButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var subAreas: [Area] = []
    var crags: [Crag] = []
    var area: Area? = nil
    var subIndex: Int = 0
    var subAreasAndCrags = [AnyObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        centerViewOnAreaLocation()
    }
    
    //Check if the area has a location; centers map on area
    func centerViewOnAreaLocation() {
        if area?.getFenceCoordinates() != nil {
            let areaLocation    = CLLocationCoordinate2D(latitude: (area?.getFenceLatitudeDouble())!, longitude: (area?.getFenceLongitudeDouble())!)
            let areaRegion      = MKCoordinateRegion.init(center: areaLocation, latitudinalMeters: 7500, longitudinalMeters: 7500)
            areaMap.setRegion(areaRegion, animated: true)
            noLocationLabel.text = ""
        } else {
            noLocationLabel.text = "Location Unavailable"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if area != nil {
            areaName.title              = area!.getName()
            self.subAreas               = area!.getSubAreasAsArray()
            self.areaDescription.text   = area!.getDescription()
        }
           // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "AreaCell", bundle: nil)
        subAreaTableView.register(nib, forCellReuseIdentifier: "AreaCell")
        let cragNib = UINib(nibName: "CragCell", bundle: nil)
        subAreaTableView.register(cragNib, forCellReuseIdentifier: "CragCell")
        subAreaTableView.delegate = self
        subAreaTableView.dataSource = self
        
        for each in subAreas {
            subAreasAndCrags.append(each)
        }
        for each in crags {
            subAreasAndCrags.append(each)
        }
        
        formatViews()
        
    }
    
    func formatViews() {
        areaMap.clipsToBounds = true
        areaMap.layer.cornerRadius = 10.0
        
        descriptionView.clipsToBounds = true
        descriptionView.layer.cornerRadius = 10.0
        
        let areaDescriptionLength = area?.getDescription().height(withConstrainedWidth: 354, font: UIFont.systemFont(ofSize: 17.0))
        
        if area != nil {
            descriptionViewHeight.constant = 71 + areaDescriptionLength!
        } else {
            descriptionViewHeight.constant = 88
        }
        
        subAreaView.clipsToBounds = true
        subAreaView.layer.cornerRadius = 10.0
        subAreaTableViewHeightConstraint.constant = CGFloat(subAreasAndCrags.count * 63)
        subAreaViewHeightConstraint.constant = subAreaTableViewHeightConstraint.constant + 41
        
        contentViewHeightConstraint.constant = 270 + descriptionViewHeight.constant + subAreaViewHeightConstraint.constant
    }
    
    //MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subAreasAndCrags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.subAreasAndCrags[indexPath.row] is Area  {
            let areaCell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! AreaCell
            
            areaCell.areaName.text = (subAreasAndCrags[indexPath.row] as! Area).getName()
            areaCell.areaProximity.text = areaCell.getProximity()
            if (subAreasAndCrags[indexPath.row] as! Area).subAreaCount() > 0 {
                areaCell.subAreasLabel.text = String((subAreasAndCrags[indexPath.row] as! Area).subAreaCount()) + " sub-areas"
            } else {
                areaCell.subAreasLabel.text = "No sub-areas"
            }
            
            return areaCell
            
        } else if self.subAreasAndCrags[indexPath.row] is Crag {
            let cragCell = tableView.dequeueReusableCell(withIdentifier: "CragCell", for: indexPath) as! CragCell
            
            cragCell.cragName.text = (subAreasAndCrags[indexPath.row] as! Crag).getName()
            cragCell.cragProximity.text = cragCell.getProximity()
            cragCell.numberOfRoutes.text = String((subAreasAndCrags[indexPath.row] as! Crag).routeCount())
            
            return cragCell
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreaToCrag"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! CragDetailVC
            vc.crag = subAreas[subIndex] as? Crag
        } else if segue.identifier == "AreaToArea"{
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! AreaDetailVC
            vc.area = subAreas[subIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        subIndex = indexPath.row

        performSegue(withIdentifier: "AreaToCrag", sender: cell)
        
        if type(of: subAreas[subIndex]) == Crag.self{
            performSegue(withIdentifier: "AreaToCrag", sender: cell)
        } else {
            performSegue(withIdentifier: "AreaToArea", sender: cell)
        }
    }
}

//MARK: - Extensions
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

