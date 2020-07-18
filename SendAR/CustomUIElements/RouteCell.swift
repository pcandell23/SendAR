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
    
    var route: Route?
    
    required init?(coder aDecoder: NSCoder) {
        self.route = nil
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Values must be set in the VC that contains the TableView to which this cell belongs.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
