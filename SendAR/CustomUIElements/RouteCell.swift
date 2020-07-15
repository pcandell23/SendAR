//
//  RouteCell.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell {
    
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeGrade: UILabel!
    @IBOutlet weak var routeType: UILabel!
    @IBOutlet weak var routeRating: UILabel!
    @IBOutlet weak var routeArea: UILabel!
    
    var route: Route?
    
    required init?(coder aDecoder: NSCoder) {
        self.route = nil
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if route != nil {
            routeName.text = route!.getName()
            routeGrade.text = route!.getGrade()
            routeType.text = route!.getType()
            routeRating.text = String(route!.getRating())
            if route!.getCrag() != nil {
                routeArea.text = String(route!.getCrag()!.getName())
            } else {
                routeArea.text = "This route does not belong to a crag."
            }
        } else {
            routeName.text = "Name"
            routeGrade.text = "Grade"
            routeType.text = "Type"
            routeRating.text = "Rating"
            routeArea.text = "This route does not belong to a crag."
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
