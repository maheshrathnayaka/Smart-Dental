//
//  CrownRoot.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CrownRoot.h"

@implementation CrownRoot




- (BOOL)performAction {
    if ([super performAction]) {
        UIImage *img = [self getActionImageOnPart:kFacialPart Sequence:nil];
        UIImage *colorImg = [self colorizeImage:img color:[UIColor brownColor]];
        [self initActionLayer];
        CALayer *subLayer = [CALayer layer];    
        subLayer.frame = self.tooth.chartFacialLayer.bounds;
        subLayer.name = [NSString stringWithFormat:@"%@_%@",nil,kFacialPart];
        subLayer.contentsGravity = kCAGravityCenter;
        subLayer.contents = (id)colorImg.CGImage;
        subLayer.opacity = 0.65f;
        [self.actionFacialLayer addSublayer:subLayer];
        [self applyActionLayer];
        [self.tooth updateThumbLayer];

    }
    return YES;
}



- (BOOL)performUndoAction {
    if ([super performUndoAction]) {
        [self applySimpleFacialImageUndoAction];
    }
    return YES;
}



@end
