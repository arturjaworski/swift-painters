//
//  CGPointExtension.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint: ComparableProtocol {
    func isEqualToObject(anotherObject: CGPoint) -> (Bool) {
        if self.x == anotherObject.x && self.y == anotherObject.y {
            return true
        }
        
        return false
    }
    
    func countArcToObject(anotherObject: CGPoint) -> (Double) {
        return Double(atan2f(CFloat(anotherObject.x) - CFloat(self.x), CFloat(anotherObject.y) - CFloat(self.y)))
    }
    
    func distanceTo(anotherPoint: CGPoint) -> Double {
        var x2:Double = Double(self.x) - Double(anotherPoint.x)
        var y2:Double = Double(self.y) - Double(anotherPoint.y)
        x2 *= x2
        y2 *= y2
        return sqrt(x2 + y2)
    }
}