//
//  IndigoButton.swift
//  SendAR
//
//  Created by Bennett Baker on 7/3/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

class IndigoButton: UIButton {

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
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
}
