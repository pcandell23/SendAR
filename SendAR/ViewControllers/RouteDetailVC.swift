//
//  RouteDetailVC.swift
//  SendAR
//
//  Created by Bennett Baker on 7/7/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class RouteDetailVC: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var locationViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var routeGrade: UILabel!
    @IBOutlet weak var routeRating: UILabel!
    @IBOutlet weak var routeDimensions: UILabel! //interpolated string of type, pitches and height
    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var routeShape: UIImageView!
    @IBOutlet weak var routeDescription: UILabel!
    @IBOutlet weak var routeLocation: UILabel!
    
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var noARLabel: UILabel!
    
    var route: Route? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatViews()
        
        if route != nil {
            self.title = route!.getName()
            self.routeGrade.text = route!.getGrade()
            
            let rating = route!.getRating()
            if rating > 4 && rating <= 5 {
                self.routeRating.text = "⭐️⭐️⭐️⭐️⭐️"
            } else if rating > 3 {
                self.routeRating.text = "⭐️⭐️⭐️⭐️"
            } else if rating > 2 {
                self.routeRating.text = "⭐️⭐️⭐️"
            } else if rating > 1 {
                self.routeRating.text = "⭐️⭐️"
            } else if rating > 0 {
                self.routeRating.text = "⭐️"
            }
            
            self.routeDimensions.text = "\(route!.getType()), \(route!.getPitches()) pitches, \(route!.getAltitude()) feet"
            
            //Temporary
            self.routeImage = nil
            self.routeShape = nil
            
            self.routeDescription.text = route!.getDescription()
            
            
            if self.routeImage != nil {
                noImageLabel.text = ""
            } else {
                noImageLabel.text = "Image Unavailable"
            }
            
            if self.routeShape != nil {
                noARLabel.text = ""
            } else {
                noARLabel.text = "AR Unavailable"
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        routeDescription.sizeToFit()
        routeLocation.sizeToFit()
    }
    
    func formatViews() {
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 10.0
        
        descriptionView.clipsToBounds = true
        descriptionView.layer.cornerRadius = 10.0
        
        locationView.clipsToBounds = true
        locationView.layer.cornerRadius = 10.0
        
        let font = UIFont.systemFont(ofSize: 17.0)
        var routeDescriptionLength: CGFloat = 17.0
        var routeLocationLength: CGFloat = 17.0
        if route != nil {
            if route!.getDescription() != "" {
                routeDescriptionLength = heightForView(text: route!.getDescription(), font: font, width: 364)
                descriptionViewHeight.constant = routeDescriptionLength + 51
            } else {
                descriptionViewHeight.constant = 72
                routeDescription.text = "No Description"
            }
            
            if route!.getLocation() != "" {
                routeLocationLength = heightForView(text: route!.getLocation(), font: font, width: 364)
                locationViewHeight.constant = routeLocationLength + 51
            } else {
                locationViewHeight.constant = 72
                routeLocation.text = "No Location"
            }
        }
        
        routeImage.clipsToBounds = true
        routeImage.layer.cornerRadius = 10.0
        
        routeShape.clipsToBounds = true
        routeShape.layer.cornerRadius = 10.0
        
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
