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
        return Double(atan2f(self.x - anotherObject.x, self.y - anotherObject.y))
    }
}