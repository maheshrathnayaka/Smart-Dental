//
//  UIView+RoundedCorners.m
//  DrawLine
//
//  Created by emmafromsc@gmail.com on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+RoundedCorners.h"

@implementation UIView (RoundedCorners)

//设置视图任意角为圆角
- (void)setRoundedCorners:(UIViewRoundedCornerMask)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, minx, midy);
    CGPathAddArcToPoint(path, nil, minx, miny, midx, miny, (corners & UIViewRoundedCornerUpperLeft) ? radius : 0);
    CGPathAddArcToPoint(path, nil, maxx, miny, maxx, midy, (corners & UIViewRoundedCornerUpperRight) ? radius : 0);
    CGPathAddArcToPoint(path, nil, maxx, maxy, midx, maxy, (corners & UIViewRoundedCornerLowerRight) ? radius : 0);
    CGPathAddArcToPoint(path, nil, minx, maxy, minx, midy, (corners & UIViewRoundedCornerLowerLeft) ? radius : 0);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    self.layer.mask = maskLayer;
    self.clipsToBounds = YES;
    
    CFRelease(path);
}

//设置标题类反向圆角视图
- (void)setTitleReverseRoundedCorners:(CGFloat)radius {
	CGRect rect = self.bounds;
	CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
    CGFloat leftx = radius;
    CGFloat rightx = maxx - leftx;
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
    
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, minx, miny);
	CGPathAddArcToPoint(path, nil, leftx, miny, leftx, midy, radius);
	CGPathAddArcToPoint(path, nil, leftx, maxy, midx, maxy, radius);
	CGPathAddArcToPoint(path, nil, rightx, maxy, rightx, midy, radius);
	CGPathAddArcToPoint(path, nil, rightx, miny, maxx, miny, radius);
    CGPathCloseSubpath(path);
    
	CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    self.layer.mask = maskLayer;
    self.clipsToBounds = YES;
    
    CFRelease(path);
}

@end
