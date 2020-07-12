//
//  AreaCell.swift
//  SendAR
//
//  Created by Peter Candell on 7/11/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//
import UIKit

class AreaCell: UITableViewCell {
    
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var areaProximity: UILabel!
    @IBOutlet weak var cragsAndRoutes: UILabel!
    @IBOutlet weak var areaLocation: UILabel!
    
    var area: Area
    
    required init?(coder aDecoder: NSCoder) {
        self.area = Area()
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        areaName.text = area.getName()
        //TODO: areaProximity.text
        cragsAndRoutes.text = "\(area.getSubAreas().count) Crags, TODO Routes"
        //TODO: areaLocation.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
