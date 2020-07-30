//
//  LogbookCell.swift
//  SendAR
//
//  Created by Bennett Baker on 7/27/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class LogbookCell: UITableViewCell {

    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeTime: UILabel!
    @IBOutlet weak var routeHeight: UILabel!
    @IBOutlet weak var routeDate: UILabel!
    
    var trackedRoute: TrackedRoute?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.trackedRoute = nil
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
