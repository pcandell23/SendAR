//
//  TrackButton.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class TrackButton: UIButton {
    
    var buttonState = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor     = UIColor.systemIndigo
        layer.cornerRadius  = 5
        
        addTarget(self, action: #selector(TrackButton.buttonPressed), for: .touchUpInside)
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !buttonState)
    }
    
    func activateButton(bool: Bool) {
        
        buttonState = bool
        
        let title = bool ? "Stop Tracking" : "Start Tracking"
        
        setTitle(title, for: .normal)
    }
    
    
}
