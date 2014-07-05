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
    var velocity = 30.0
    func move(dt: Double) {
        if (!checkBounds()) {
            return
        }
        var len = Float(velocity)*Float(dt)
        position.x += len
    }
    
    func checkBounds() -> Bool {
        let bottomLeft = CGPointZero;
        let topRight = CGPointMake(self.scene.size.width, self.scene.size.height);
        return (position.x > bottomLeft.x && position.y > bottomLeft.y
            && position.x < topRight.x && position.y < topRight.y);
    }
}
