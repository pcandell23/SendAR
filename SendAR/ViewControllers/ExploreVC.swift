//
//  ExploreVC.swift
//  SendAR
//
//  Created by Bennett Baker on 8/4/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class ExploreVC: UIViewController {
    
    @IBOutlet weak var exploreList: UIView!
    @IBOutlet weak var exploreMap: UIView!
    
    @IBAction func unwindToExplore(_ sender: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            exploreList.alpha = 1
            exploreMap.alpha = 0
        } else {
            exploreList.alpha = 0
            exploreMap.alpha = 1
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
