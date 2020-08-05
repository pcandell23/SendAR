//
//  HomeVC.swift
//  SendAR
//
//  Created by Peter Candell on 6/29/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var logbookView: UIView!
    @IBOutlet weak var trackButtonText: UIButton!
    @IBOutlet weak var logbookButtonText: UIButton!
    
    var onTrackPage: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        trackView.isHidden = false
        logbookView.isHidden = true
        
        trackButtonText.setTitleColor(UIColor.label, for: .normal)
        logbookButtonText.setTitleColor(UIColor.darkGray, for: .normal)
        
    }

    @IBAction func trackPageButton(_ sender: Any) {
        if !onTrackPage {
            trackView.isHidden = false
            logbookView.isHidden = true
            
            trackButtonText.setTitleColor(UIColor.label, for: .normal)
            logbookButtonText.setTitleColor(UIColor.lightGray, for: .normal)
            
            onTrackPage = true
        }
    }
    
    @IBAction func logbookPageButton(_ sender: Any) {
        if onTrackPage {
            trackView.isHidden = true
            logbookView.isHidden = false
            
            trackButtonText.setTitleColor(UIColor.lightGray, for: .normal)
            logbookButtonText.setTitleColor(UIColor.label, for: .normal)
            
            onTrackPage = false
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
    
}
