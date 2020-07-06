//
//  MapButton.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class MapButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        layer.cornerRadius  = 5
    }
    
}
