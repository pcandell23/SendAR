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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
