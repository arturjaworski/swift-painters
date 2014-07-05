//
//  GameScene.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var desiredPoint: CGPoint = CGPoint(x: 320, y: 0)
    var currentPoint: CGPoint = CGPoint(x: 160, y: 160)
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = Paintbrush(imageNamed:"Spaceship")
            
            sprite.xScale = 0.2
            sprite.yScale = 0.2
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
        var asd: Double = desiredPoint.countArcToObject(currentPoint)
        
        if desiredPoint.isEqualToObject(currentPoint) {
            // we need to set new desiredPoint?
        }
        else {
            // going to desiredPoint
        }
    }
}
