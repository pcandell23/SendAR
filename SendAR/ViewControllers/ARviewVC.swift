//
//  ARviewVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class ARViewController: UIViewController {
    
    var locationCheck: LocationChecker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCheck.checkLocationServices()
    }
    
    init(locationCheck: LocationChecker) {
        self.locationCheck = locationCheck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationCheck = LocationChecker()
        super.init(coder: aDecoder)
    }
}
