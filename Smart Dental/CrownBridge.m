//
//  CrownBridge.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CrownBridge.h"

@implementation CrownBridge


- (BOOL)performAction {
    if ([super performAction]) {
        UIImage *img = [self getActionImageOnPart:kCrownPart Sequence:nil];
        UIImage *colorImg = [self colorizeImage:img color:[UIColor darkGrayColor]];
        [self initActionLayer];
        CALayer *subLayer = [CALayer layer];    
        subLayer.frame = self.tooth.chartCrownLayer.bounds;
        subLayer.name = [NSString stringWithFormat:@"%@_%@",nil,kCrownPart];
        subLayer.contentsGravity = kCAGravityCenter;
        subLayer.contents = (id)colorImg.CGImage;
        subLayer.opacity = 0.65f;
        [self.actionCrownLayer addSublayer:subLayer];
        [self applyActionLayer];
        [self.tooth updateThumbLayer];
        
    }
    return YES;
}



- (BOOL)performUndoAction {
    if ([super performUndoAction]) {
        [self applySimpleCrownImageUndoAction];
    }
    return YES;
}


@end
