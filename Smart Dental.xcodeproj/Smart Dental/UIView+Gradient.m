//
//  UIView+Gradient.m
//  
//
//  Created by xingzw@gmail.com on 2012-01-5.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Gradient.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView(Gradient)

// Chart蓝色渐变
- (void)setChartBackgroundColorGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)RGBCOLOR(184, 204, 212).CGColor, (id)RGBCOLOR(77, 95, 104).CGColor, nil];
    gradient.shouldRasterize = YES;
    gradient.rasterizationScale = [UIScreen mainScreen].scale;
    gradient.contentsGravity = kCAGravityResize;
    [self.layer insertSublayer:gradient atIndex:0];    
}

// Plan蓝色渐变
- (void)setPlanBackgroundColorGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)RGBCOLOR(38, 187, 217).CGColor, (id)RGBCOLOR(0, 79, 124).CGColor, nil];
    gradient.shouldRasterize = YES;
    gradient.rasterizationScale = [UIScreen mainScreen].scale;
    gradient.contentsGravity = kCAGravityResize;
    [self.layer insertSublayer:gradient atIndex:0];  
}


// 灰色渐变
- (void)setGrayGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)RGBCOLOR(228, 228, 228).CGColor, (id)RGBCOLOR(210, 210, 210).CGColor, nil];
    gradient.shouldRasterize = YES;
    gradient.rasterizationScale = [UIScreen mainScreen].scale;
    gradient.contentsGravity = kCAGravityResize;
    [self.layer insertSublayer:gradient atIndex:0];
}


@end
