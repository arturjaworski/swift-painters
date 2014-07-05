//
//  Paintbrush.swift
//  Swift Crunch
//
//  Created by Maciej Mucha on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import UIKit
import SpriteKit

class Paintbrush: SKSpriteNode {
    var velocity:Double = 30.0
    var angularVelocity:Double = M_PI*5
    var angle:Double = 0.0
    
    func move(dt: Double, touchPoint:CGPoint?) {
        if (!checkBounds()) {
            return
        }
        if let point = touchPoint {
            var ad = angularVelocity*dt
            changeAngle(position.countArcToObject(point))
        }
        let len = velocity*dt
        var dx:Double = len*Double(sin(angle))
        var dy:Double = len*Double(cos(angle))
        position.x += CGFloat(dx)
        position.y += CGFloat(dy)
    }
    
    func checkBounds() -> Bool {
        let bottomLeft = CGPointZero;
        let topRight = CGPointMake(self.scene.size.width, self.scene.size.height);
        return (position.x > bottomLeft.x && position.y > bottomLeft.y && position.x < topRight.x && position.y < topRight.y)
    }
    
    func changeAngle(angle: Double) {
        var da = self.angle - angle
        var action = SKAction.rotateByAngle(CGFloat(da), duration: 0)
        runAction(action)
        self.angle = angle
    }
}
