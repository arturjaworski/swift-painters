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
    var velocity:Double = 150.0
    var angularVelocity:Double = M_PI*2
    var angle:Double = 0.0
    var paintColor = UIColor.blackColor()
    var user: Int?
    
    func move(dt: Double, touchPoint:CGPoint?) {
        var a = -0.001982
        var b = -2.077895
        var oldPos = position
        var oldAngle = angle
        if let point = touchPoint {
            var ad:Double = angularVelocity*dt
            var desiredAngle = position.countArcToObject(point)
            var rotateRight:Bool = shouldRotateRight(angle, desiredAngle: desiredAngle)
            
            var newAngle = angle + (rotateRight ? ad : -ad)
            if newAngle < -M_PI {
                newAngle = M_PI - (newAngle + M_PI)
            } else if newAngle > M_PI {
                newAngle = -M_PI + (newAngle - M_PI)
            }
            changeAngle(newAngle)
            if shouldRotateRight(angle, desiredAngle: desiredAngle) != rotateRight {
                changeAngle(desiredAngle)
            }
        }
        let len = velocity*dt
        var dx:Double = len*Double(sin(angle))
        var dy:Double = len*Double(cos(angle))
        position.x += CGFloat(dx)
        position.y += CGFloat(dy)
        
        if (!checkBounds()) {
            position = oldPos
        }
    }
    
    func shouldRotateRight(angle:Double, desiredAngle:Double) -> Bool {
        var rotateRight:Bool
        if (angle < 0 && desiredAngle < 0) || (angle > 0 && desiredAngle > 0) {
            rotateRight = desiredAngle > angle
        } else {
            var absAngle = abs(angle)
            var absDesiredAngle = abs(desiredAngle)
            if (angle > 0) {
                rotateRight = absDesiredAngle + absAngle > M_PI
            } else {
                rotateRight = absDesiredAngle + absAngle < M_PI
            }
        }
        return rotateRight
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
