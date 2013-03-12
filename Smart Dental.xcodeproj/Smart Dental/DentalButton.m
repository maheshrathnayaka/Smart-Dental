//
//  DentalButton.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-2.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DentalButton.h"
#import <QuartzCore/QuartzCore.h>


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@implementation DentalButton

-(void)setupView{
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:RGBCOLOR(158, 178, 186).CGColor];
    [self setTitleColor:RGBCOLOR(15, 89, 127) forState:UIControlStateHighlighted];
    [self setTitleColor:RGBCOLOR(197, 211, 215) forState:UIControlStateDisabled];
}

-(id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        [self setupView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super initWithCoder:aDecoder])){
        [self setupView];
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.layer.backgroundColor = RGBCOLOR(255, 238, 134).CGColor;
    [super touchesBegan:touches withEvent:event];
    
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self setTitleColor:RGBCOLOR(15, 89, 127) forState:UIControlStateHighlighted];
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent: event ];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    [super touchesEnded:touches withEvent:event];
    
}

// TODO: 要设置button enable ＝ NO/YES情况下按钮显示何种图片。或许要重写setEnable方法

@end
