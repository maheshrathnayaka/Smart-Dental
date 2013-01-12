//
//  ImageUtility.h
//  ToolKit
//
//  Created by emmafromsc@gmail.com on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Tooth.h"

#define kScaleRatio 2.5f

@interface ImageUtility : NSObject

//创建图片
+ (UIImage *)createImageWithName:(NSString *)name;

//镜像图片
+ (UIImage *)flipImageFromLeftToRight:(UIImage *)originalImage;

//截取图片
+ (UIImage *)captureImageFromLayer:(CALayer *)layer;

//缩放图片
+ (UIImage *)scaleImage:(UIImage *)originalImage scaleRatio:(CGFloat)scaleRatio;

//创建图层
+ (CALayer *)createLayerWithRect:(CGRect)rect Image:(UIImage *)img LayerName:(NSString *)name;

//返回已翻转的action图
+ (UIImage *)actionImageOfTooth:(Tooth *)tooth CrownOrFacial:(NSString *)part ActionName:(NSString *)actionName SequenceNumber:(NSString *)sequence ;


@end
