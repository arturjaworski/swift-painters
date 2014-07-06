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
    var lastUpdated : CFTimeInterval = 0
    var paintbrushes : Paintbrush[] = []
    var touchPoints: CGPoint?[] = [nil, nil]
    var touchCount = 0
    var paintNode: SKSpriteNode?
    var user: Int?
    
    func setUserId(userId: Int) {
        self.user = userId
    }
    
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
    
    func addPaintbrush(paintColor:UIColor, user: Int) {
        let sprite = Paintbrush(imageNamed:"Spaceship")
        
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        sprite.xScale = 0.1
        sprite.yScale = 0.1
        sprite.changeAngle(M_PI*Double(user))
        sprite.position.x += CGFloat(sin(sprite.angle) * 20.0)
        sprite.position.y += CGFloat(cos(sprite.angle) * 20.0)
        sprite.paintColor = paintColor
        sprite.user = user;
        
        self.addChild(sprite)
        paintbrushes.insert(sprite, atIndex: 0)
    }
    
    override func didMoveToView(view: SKView) {
        refreshPaint()
        addPaintbrush(UIColor.greenColor(), user: 0)
        addPaintbrush(UIColor.redColor(), user: 1)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touchCount += touches.count
        if touchPoints[self.user!] == nil {
            touchPoints[self.user!] = touches.anyObject().locationInNode(self)
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        touchCount -= touches.count
        if (touchCount == 0) {
            touchPoints[self.user!] = nil
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        touchPoints[self.user!] = touches.anyObject().locationInNode(self)
    }
    
    func checkCollisions() {
        for paintbrush1 in paintbrushes {
            for paintbrush2 in paintbrushes {
                if (paintbrush1 == paintbrush2) {
                    continue
                }
                if (paintbrush1.position.distanceTo(paintbrush2.position) < Double(paintbrush1.size.height)) {
                    paintbrush1.collisionWithPaintbrush(paintbrush2)
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        checkCollisions()
        let dt = lastUpdated == 0 ? 0 : currentTime - lastUpdated
        for (idx, paintbrush) in enumerate(paintbrushes) {
            var oldPosition = paintbrush.position
            
            if self.user == paintbrush.user {
                paintbrush.move(Double(dt), touchPoint : self.touchPoints[self.user!]);
                DataHelper.sharedInstance.touchPoints[self.user!] = paintbrush.position
                DataHelper.sharedInstance.angles[self.user!] = paintbrush.angle

                SKPaintHelper.sharedInstance.paintLine(oldPosition, toPoint: paintbrush.position, color: paintbrush.paintColor, width: CGFloat(paintWidth))
            }
            else {
                paintbrush.position = DataHelper.sharedInstance.touchPoints[paintbrush.user!]!
                paintbrush.changeAngle(DataHelper.sharedInstance.angles[paintbrush.user!]!)
            }
        }
        lastUpdated = currentTime
        refreshPaint()
    }
}
