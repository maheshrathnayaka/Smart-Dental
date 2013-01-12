//
//  UIView+BlueGradientLayer.h
//  TestCenter
//
//  Created by xingzw@gmail.com on 2012-01-5.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface UIView(BlueGradient)
- (void)setChartBackgroundColorGradient;
- (void)setPlanBackgroundColorGradient;
- (void)setGrayGradient;
@end
