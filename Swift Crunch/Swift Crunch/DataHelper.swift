//
//  DataHelper.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import Foundation
import SpriteKit

class DataHelper {
    var touchPoints: CGPoint?[] = [CGPointMake(0, 0), CGPointMake(0, 0)]
    var angles: Double?[] = [0.0, 0.0]
    
    class var sharedInstance : DataHelper {
        struct Static {
            static let instance : DataHelper = DataHelper()
        }
        return Static.instance
    }
    
    init() {
        
    }
}