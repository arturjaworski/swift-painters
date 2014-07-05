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
    
    //var paintArray: Array<Array<UIColor>>
    init() {
        self.image = UIImage.imageWithColor(UIColor.clearColor(), size: self.imageSize)
        
        /*self.paintArray = Array()
        for i in 0..(imageSize.width) {
            var iArray: Array<UIColor> = Array()
            for j in 0..(imageSize.height) {
                var color: UIColor = UIColor(white: 0.0, alpha: 0.0)
                iArray.insert(color, atIndex: Int(j))
            }
            self.paintArray.insert(iArray, atIndex: Int(i))
        }*/
    }
    
    func texture() -> SKTexture {
        return SKTexture(image: image)
    }
    
    func paintCircle(point: CGPoint, color: UIColor, width: CGFloat) {
        UIGraphicsBeginImageContext(self.image.size);
        self.image.drawAtPoint(point)
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillEllipseInRect(context, CGRectMake(point.x, point.y, width, width))
        
        var newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image = newImage
    }
    
    func paintLine(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat) {
        
    }
    
    /*func createImage() -> UIImage {
        
        
        var imageRect: CGRect = CGRectMake(0, 0, imageSize.width, imageSize.height)
        var sampleImage: UIImageView = UIImageView(frame: imageRect)
        
        UIGraphicsBeginImageContext(imageRect.size)
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        CGContextDrawImage(context, imageRect, sampleImage.image.CGImage);
        
        for i in 0..(imageRect.width) {
            for j in 0..(imageRect.height) {
                var color: UIColor = paintArray[Int(i)][Int(j)]
                var red: CGFloat = 0.0
                var green: CGFloat = 0.0
                var blue: CGFloat = 0.0
                var alpha: CGFloat = 0.0
                
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                CGContextSetRGBFillColor(context, red, green, blue, alpha)
                CGContextFillRect(context, CGRectMake(i, j, 1, 1))
            }
        }

        CGContextRestoreGState(context);
        var img: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        return img
    }*/
}