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

    var imageSize: CGSize = CGSizeMake(768, 462)
    var image: UIImage
    
    init() {
        self.image = UIImage.imageWithColor(UIColor.clearColor(), size: self.imageSize)
    }
    
    func texture() -> SKTexture {
        return SKTexture(image: self.image)
    }
    
    func paintCircle(point: CGPoint, color: UIColor, width: CGFloat) {
        UIGraphicsBeginImageContext(self.image.size) // , false, 0.0

        var context: CGContextRef = UIGraphicsGetCurrentContext();
        
        let scale: CGFloat = UIScreen.mainScreen().scale;
        
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -image.size.height);
        
        //CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
        
        CGContextDrawImage(context, CGRectMake(0, 0, self.image.size.width, self.image.size.height), self.image.CGImage);
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillEllipseInRect(context, CGRectMake(point.x - width/2, point.y - width/2, width, width))
        
        var newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image = newImage
    }
    
    func paintLineDirect(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat) {
        UIGraphicsBeginImageContext(self.image.size) // , false, 0.0
        
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        CGContextSetAllowsAntialiasing(context, false)
        
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -image.size.height);
        
        //CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
        
        CGContextDrawImage(context, CGRectMake(0, 0, self.image.size.width, self.image.size.height), self.image.CGImage);
        
        CGContextSetLineWidth(context, width);
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
        CGContextStrokePath(context);
        
        var newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image = newImage
    }
    
    func paintLine(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat) {
        paintLineDirect(fromPoint, toPoint: toPoint, color: color, width: width)
        paintCircle(toPoint, color: color, width: width)
    }
    
    func countWinner() -> (Float, Float) {
        var pixelCount = [0, 0]
        
        var red: Float
        var green: Float
        var blue: Float
        var alpha: Float
        
        for x in 0..(self.imageSize.width) {
            for y in 0..(self.imageSize.height) {
                (red, green, blue, alpha) = self.image.getPixelColorAtLocation(CGPointMake(x, y))
                if !(alpha > 0) {
                    continue;
                }
                
                if green > 0 {
                    pixelCount[0]++
                }
                else if blue > 0 {
                    pixelCount[1]++
                }
            }
        }
        
        var allPixelsCount: Float = Float(self.imageSize.width)*Float(self.imageSize.height);
        
        return (Float(pixelCount[0])/allPixelsCount, Float(pixelCount[1])/allPixelsCount)
    }
}