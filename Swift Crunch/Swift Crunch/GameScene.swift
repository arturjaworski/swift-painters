//
//  GameScene.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let timeBase = 100
    var desiredPoint: CGPoint = CGPoint(x: 320, y: 0)
    var currentPoint: CGPoint = CGPoint(x: 160, y: 160)
    var lastUpdated : CFTimeInterval = 0
    var paintbrushes : Paintbrush[] = [];
    var touchPoint: CGPoint?;
    
    func addPaintbrush(at: CGPoint) {
        let sprite = Paintbrush(imageNamed:"Spaceship")
        
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.position = at
        sprite.changeAngle(M_PI/3)
        
        self.addChild(sprite)
        paintbrushes.insert(sprite, atIndex: 0)
    }
    
    override func didMoveToView(view: SKView) {
        addPaintbrush(CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touchPoint = touches.anyObject().locationInNode(self)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        let dt = lastUpdated == 0 ? 0 : currentTime - lastUpdated
        for paintbrush in paintbrushes {
            paintbrush.move(Double(dt), touchPoint : self.touchPoint);
        }
        lastUpdated = currentTime
    }
}
