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
    var paintWidth = 20.0
    var desiredPoint: CGPoint = CGPoint(x: 320, y: 0)
    var currentPoint: CGPoint = CGPoint(x: 160, y: 160)
    var lastUpdated : CFTimeInterval = 0
    var paintbrushes : Paintbrush[] = []
    var touchPoint: CGPoint?
    var touchCount = 0
    var paintNode: SKSpriteNode?
    
    func refreshPaint() {
        let paint = SKPaintHelper.sharedInstance.texture()
        if self.paintNode == nil {
            self.paintNode = SKSpriteNode(texture: paint);
            self.paintNode!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            self.addChild(self.paintNode)
        }
        else {
            self.paintNode!.texture = paint
        }
    }
    
    func addPaintbrush(at: CGPoint) {
        let sprite = Paintbrush(imageNamed:"Spaceship")
        
        sprite.xScale = 0.1
        sprite.yScale = 0.1
        sprite.position = at
        sprite.changeAngle(M_PI/3)
        
        self.addChild(sprite)
        paintbrushes.insert(sprite, atIndex: 0)
    }
    
    override func didMoveToView(view: SKView) {
        refreshPaint()
        addPaintbrush(CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touchCount += touches.count
        if touchPoint == nil {
            touchPoint = touches.anyObject().locationInNode(self)
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        touchCount -= touches.count
        if (touchCount == 0) {
            touchPoint = nil
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        touchPoint = touches.anyObject().locationInNode(self)
    }
   
    override func update(currentTime: CFTimeInterval) {
        let dt = lastUpdated == 0 ? 0 : currentTime - lastUpdated
        for paintbrush in paintbrushes {
            paintbrush.move(Double(dt), touchPoint : self.touchPoint);
            SKPaintHelper.sharedInstance.paintCircle(paintbrush.position, color: UIColor.greenColor(), width: CGFloat(paintWidth))
        }
        lastUpdated = currentTime
        refreshPaint()
    }
}
