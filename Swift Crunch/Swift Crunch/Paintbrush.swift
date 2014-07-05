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
    var angularVelocity:Double = M_PI/4
    var angle:Double = 0.0
    
    func move(dt: Double, touchPoint:CGPoint?) {
        var oldPos = position
        var oldAngle = angle
        if let point = touchPoint {
            var ad:Double = angularVelocity*dt
            var rotateRight:Bool = Double(position.countArcToObject(point) - angle) > 0
            changeAngle(angle + (rotateRight ? dt : -dt))
        }
        let len = velocity*dt
        var dx:Double = len*Double(sin(angle))
        var dy:Double = len*Double(cos(angle))
        position.x += Float(dx)
        position.y += Float(dy)
        
        if (!checkBounds()) {
            position = oldPos
        }
    }
    
    func checkBounds() -> Bool {
        let bottomLeft = CGPointZero;
        let topRight = CGPointMake(self.scene.size.width, self.scene.size.height);
        return (position.x > bottomLeft.x && position.y > bottomLeft.y && position.x < topRight.x && position.y < topRight.y)
    }
    
    func changeAngle(angle: Double) {
        var da = self.angle - angle
        var action = SKAction.rotateByAngle(Float(da), duration: 0)
        runAction(action)
        self.angle = angle
    }
}
