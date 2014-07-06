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
    let defaultVelocity = 150.0
    let collidedVelocity = 50.0
    let crashVelocity = 200.0
    var velocity:Double = 150.0
    var angularVelocity:Double = M_PI*2
    var angle:Double = 0.0
    var paintColor = UIColor.greenColor()
    var user: Int?
    let collisionDuration:Double = 5.0
    var collidedUntil:Double = 0.0
    
    func move(dt: Double, touchPoint:CGPoint?) {
        var oldPos = position
        var oldAngle = angle
        var lockControls = false
        if collidedUntil > 0 {
            if collidedUntil < 0.96 * collisionDuration {
                velocity = collidedVelocity
            } else {
                lockControls = true
                velocity = crashVelocity
            }
            collidedUntil -= dt
        } else {
            velocity = defaultVelocity
        }
        if let point = touchPoint {
            if (!lockControls) {
                var ad:Double = angularVelocity*dt
                var desiredAngle = position.countArcToObject(point)
                var rotateRight:Bool = shouldRotateRight(angle, desiredAngle: desiredAngle)
                
                var newAngle = angle + (rotateRight ? ad : -ad)
                changeAngle(newAngle)
                if shouldRotateRight(angle, desiredAngle: desiredAngle) != rotateRight {
                    changeAngle(desiredAngle)
                }
            }
        }
        let len = velocity*dt
        var dx:Double = len*Double(sin(angle))
        var dy:Double = len*Double(cos(angle))
        position.x += CGFloat(dx)
        position.y += CGFloat(dy)
        
        checkBounds()
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
    
    func collisionWithPaintbrush(paintbrush:Paintbrush) {
        collidedUntil = collisionDuration
        let randAngle = 2.0*M_PI*Double(rand())/Double(CInt.max)
        changeAngle(randAngle)
        move(0.1, touchPoint: nil)
    }
    
    func checkBounds(){
        let bottomLeft = CGPointZero;
        let topRight = CGPointMake(self.scene.size.width, self.scene.size.height);
        position.x = min(max(position.x, bottomLeft.x), topRight.x)
        position.y = min(max(position.y, bottomLeft.y), topRight.y)
    }
    
    func changeAngle(angle: Double) {
        var nangle:Double = angle
        if angle < -M_PI {
            nangle = M_PI - (angle + M_PI)
        } else if angle > M_PI {
            nangle = -M_PI + (angle - M_PI)
        }
        var da = self.angle - nangle
        var action = SKAction.rotateByAngle(CGFloat(da), duration: 0)
        runAction(action)
        self.angle = nangle
    }
}
