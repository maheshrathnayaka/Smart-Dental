//
//  ImageUtility.m
//  ToolKit
//
//  Created by emmafromsc@gmail.com on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageUtility.h"


@implementation ImageUtility

//创建图片
+ (UIImage *)createImageWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    
    return img;
}

//镜像图片
+ (UIImage *)flipImageFromLeftToRight:(UIImage *)originalImage {
    UIGraphicsBeginImageContext(originalImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, originalImage.size.width, originalImage.size.height);
    CGContextScaleCTM(context, -1, -1);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    UIImage *flippedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return flippedImage;
}

//截取图片
+ (UIImage *)captureImageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContext(layer.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return capturedImage;
}

//缩放图片
+ (UIImage *)scaleImage:(UIImage *)originalImage scaleRatio:(CGFloat)scaleRatio {
    CGRect scaleRect = CGRectMake(0, 0, originalImage.size.width / scaleRatio, originalImage.size.height / scaleRatio);
    UIGraphicsBeginImageContext(scaleRect.size);
    [originalImage drawInRect:scaleRect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//创建图层
+ (CALayer *)createLayerWithRect:(CGRect)rect Image:(UIImage *)img LayerName:(NSString *)name {
    CALayer *layer = [CALayer layer];
    layer.frame = rect;
    layer.contents = (id)img.CGImage;
    layer.contentsGravity = kCAGravityCenter;
    layer.name = name;
    
    return layer;
}


+ (UIImage *)actionImageOfTooth:(Tooth *)tooth CrownOrFacial:(NSString *)part ActionName:(NSString *)actionName SequenceNumber:(NSString *)sequence {
    NSArray *rightTeethNumbers = [@"21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38" componentsSeparatedByString:@","];
    NSArray *leftTeethNumbers  = [@"11,12,13,14,15,16,17,18,41,42,43,44,45,46,47,48" componentsSeparatedByString:@","];

    NSString *numberOfImage = (tooth.needFlipImage) ? [leftTeethNumbers objectAtIndex:[rightTeethNumbers indexOfObject:tooth.number]] : tooth.number ;
    
    NSString *imageName;
    
    if (sequence) {
       imageName = [NSString stringWithFormat:@"%@_%@_%@_%@.png",numberOfImage,actionName,part,sequence ];
    } else {
       imageName = [NSString stringWithFormat:@"%@_%@_%@.png",numberOfImage,actionName,part ];
    }
    NSLog(@"ImageName:%@",imageName);
    
    UIImage *leftImage = [UIImage imageNamed:imageName];
    UIImage *actionImage ;
    if (leftImage) {
         actionImage = (tooth.needFlipImage) ? [self flipImageFromLeftToRight:leftImage]: leftImage;
    } else {
        actionImage = nil; // 图片不存在UIImage *actionImage
    }
    
    return actionImage;
}


+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
	CGImageRef maskRef = maskImage.CGImage; 
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	return [UIImage imageWithCGImage:masked];
    
}


@end
