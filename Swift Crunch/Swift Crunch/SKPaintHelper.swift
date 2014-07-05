//
//  SKTextureHelper.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import Foundation
import SpriteKit

class SKPaintHelper {
    class var sharedInstance : SKPaintHelper {
        struct Static {
            static let instance : SKPaintHelper = SKPaintHelper()
        }
        return Static.instance
    }

    var imageSize: CGSize = CGSizeMake(320, 320)
    var image: UIImage
    
    init() {
        self.image = UIImage.imageWithColor(UIColor.clearColor(), size: self.imageSize)
    }
    
    func texture() -> SKTexture {
        return SKTexture(image: self.image)
    }
    
    func paintCircle(point: CGPoint, color: UIColor, width: CGFloat) {
        UIGraphicsBeginImageContext(self.image.size);
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -image.size.height);
        
        CGContextDrawImage(context, CGRectMake(0, 0, self.image.size.width, self.image.size.height), self.image.CGImage);
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillEllipseInRect(context, CGRectMake(point.x - width/2, point.y - width/2, width, width))
        
        var newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image = newImage
    }
    
    func paintLine(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat) {
        var xdiff:Double = Double(toPoint.x - fromPoint.x)
        var ydiff:Double = Double(toPoint.y - fromPoint.y)
        var diff = max(abs(xdiff), abs(ydiff))
        var point:CGPoint = fromPoint
        paintCircle(point, color: color, width: width)
        for(var i:Double = 0.0; i < diff; i += 1.0) {
            point.x = CGFloat(Double(fromPoint.x) + xdiff/i)
            point.y = CGFloat(Double(fromPoint.y) + ydiff/i)
            paintCircle(point, color: color, width: width)
        }
    }
}