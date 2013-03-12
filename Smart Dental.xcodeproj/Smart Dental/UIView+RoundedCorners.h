//
//  UIView+RoundedCorners.h
//  DrawLine
//
//  Created by emmafromsc@gmail.com on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

enum {
    UIViewRoundedCornerNone = 0,
    UIViewRoundedCornerUpperLeft = 1 << 0,
    UIViewRoundedCornerUpperRight = 1 << 1,
    UIViewRoundedCornerLowerLeft = 1 << 2,
    UIViewRoundedCornerLowerRight = 1 << 3,
    UIViewRoundedCornerAll = (1 << 4) - 1,
};

typedef NSInteger UIViewRoundedCornerMask;

@interface UIView (RoundedCorners)

//设置视图任意角为圆角
- (void)setRoundedCorners:(UIViewRoundedCornerMask)corners radius:(CGFloat)radius;

//设置标题类反向圆角视图
- (void)setTitleReverseRoundedCorners:(CGFloat)radius;

@end