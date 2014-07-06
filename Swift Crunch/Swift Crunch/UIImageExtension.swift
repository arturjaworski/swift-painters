//
//  UIImageExtension.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import Foundation
import SpriteKit

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        var rect: CGRect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    func createARGBBitmapContext(inImage: CGImageRef) -> CGContext {
        var bitmapByteCount = 0
        var bitmapBytesPerRow = 0
        
        //Get image width, height
        let pixelsWide = CGImageGetWidth(inImage)
        let pixelsHigh = CGImageGetHeight(inImage)
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        bitmapBytesPerRow = Int(pixelsWide) * 4
        bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(CUnsignedLong(bitmapByteCount))
        let bitmapInfo = CGBitmapInfo.fromRaw(CGImageAlphaInfo.PremultipliedFirst.toRaw())!
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, CUnsignedLong(8), CUnsignedLong(bitmapBytesPerRow), colorSpace, bitmapInfo)
        
        // Make sure and release colorspace before returning
        CGColorSpaceRelease(colorSpace)
        
        return context
    }
    
    func getPixelColorAtLocation(point:CGPoint) -> (Float, Float, Float, Float) {
        let pixelData: CFDataRef = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
        let data = CFDataGetBytePtr(pixelData)
        
        let pixelInfo = ((self.size.width * point.y) + point.x) * 4;
        let red: UInt8 = data[Int(pixelInfo)];
        let green: UInt8 = data[Int(pixelInfo) + 1];
        let blue: UInt8 = data[Int(pixelInfo) + 2];
        let alpha: UInt8 = data[Int(pixelInfo) + 3];
        
        CFRelease(pixelData);
        
        let response = ( Float(red), Float(green), Float(blue), Float(alpha) );
        return response;
        
        /*
        CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
        const UInt8* data = CFDataGetBytePtr(pixelData);
        
        int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
        
        //UInt8 red = data[pixelInfo];         // If you need this info, enable it
        //UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
        //UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
        UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
        CFRelease(pixelData);
        
        //UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
        
        if (alpha) return YES;
        else return NO;*/
    }
    
    func getPixelColorAtLocation2(point:CGPoint) -> (Float, Float, Float, Float) {
        let inImage: CGImageRef = self.CGImage
        
        let pointY = point.y
        let pointX = point.x
        
        // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
        let context = self.createARGBBitmapContext(inImage)
        
        let pixelsWide = CGImageGetWidth(inImage)
        let pixelsHigh = CGImageGetHeight(inImage)
        let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
        
        //Clear the context
        CGContextClearRect(context, rect)
        
        // Draw the image to the bitmap context. Once we draw, the memory
        // allocated for the context for rendering will then contain the
        // raw image data in the specified color space.
        CGContextDrawImage(context, rect, inImage)
        
        // Now we can get a pointer to the image data associated with the bitmap
        // context.
        let data:COpaquePointer = CGBitmapContextGetData(context)
        let dataType = UnsafePointer<UInt8>(data)
        
        let offset = 4*((Int(pixelsWide) * Int(point.y)) + Int(point.x))
        let alpha = dataType[offset]
        let red = dataType[offset+1]
        let green = dataType[offset+2]
        let blue = dataType[offset+3]
        
        let response = ( Float(red), Float(green), Float(blue), Float(alpha) );
        
        //let color = UIColor(red: Float(red)/255.0, green: Float(green)/255.0, blue: Float(blue)/255.0, alpha: Float(alpha)/255.0)
        
        // When finished, release the context
        CGContextRelease(context);
        // Free image data memory for the context
        free(data)
        
        return response;
    }
}