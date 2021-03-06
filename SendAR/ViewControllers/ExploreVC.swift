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

        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            exploreList.isHidden = false
            exploreMap.isHidden = true
        } else {
            exploreList.isHidden = true
            exploreMap.isHidden = false
        }
    }
    
    func setupNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
