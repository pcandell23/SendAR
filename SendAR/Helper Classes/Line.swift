//
//  line.swift
//  SendAR
//
//  Created by Peter Candell on 8/4/20.
//  Copyright © 2020 Bennett Baker. All rights reserved.
//

import Foundation
import ARKit


extension SCNGeometry {
    class func line(from vector1: SCNVector3, to vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}
