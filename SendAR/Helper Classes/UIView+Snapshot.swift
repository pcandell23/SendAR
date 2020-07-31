//
//  UIView+Snapshot.swift
//  SendAR
//
//  Created by Bennett Baker on 7/30/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import UIKit

extension UIView {
    //render the view within the view's bounds, then capture it as an image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in layer.render(in: rendererContext.cgContext)
            
        })
    }
}
