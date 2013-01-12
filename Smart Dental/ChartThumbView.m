//
//  ChartThumbView.m
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChartThumbView.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageUtility.h"

@interface ChartThumbView()
@property (nonatomic, assign) Tooth *currentTooth;
- (void)addThumbLayers;
@end


@implementation ChartThumbView

@synthesize currentTooth = _currentTooth;



#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        // 加载thumb
        [self addThumbLayers];
        _currentTooth = nil;
    }
    return self;
}


- (void)addThumbLayers {
    NSEnumerator *enumerator = [[Patient sharedPatient].teeth keyEnumerator];

    for (NSString *num in enumerator) {
        Tooth *tooth = [[Patient sharedPatient].teeth objectForKey:num];
        
        [self.layer addSublayer:tooth.chartThumbCrownLayer];
        [self.layer addSublayer:tooth.chartThumbFacialLayer]; 

        [tooth.chartNumberLayer setForegroundColor:tooth.statusColor];
        [self.layer addSublayer:tooth.chartNumberLayer];

//
//        // 截大图生成缩略图
//        UIImage *captureCrownImg = [ImageUtility captureImageFromLayer:tooth.chartCrownLayer];
//        UIImage *thumbCrownImg = [ImageUtility scaleImage:captureCrownImg scaleRatio:2.5f];
//        tooth.chartThumbCrownLayer.contents = (id)thumbCrownImg.CGImage;
//        
//        UIImage *captureFacialImg = [ImageUtility captureImageFromLayer:tooth.chartFacialLayer];
//        UIImage *thumbFacialImg = [ImageUtility scaleImage:captureFacialImg scaleRatio:2.5f];
//        tooth.chartThumbFacialLayer.contents = (id)thumbFacialImg.CGImage;
    }
}



- (Tooth *)getCurrentSelectTooth {
    return _currentTooth;
}


- (void)updateCurrentSelectTooth:(Tooth *)tooth {
    _currentTooth.chartNumberLayer.foregroundColor = _currentTooth.statusColor;
    _currentTooth = tooth;
    _currentTooth.chartNumberLayer.foregroundColor = kSelectedColor;
}

#define kPrefixToothNumber 2    // layer名称前2位是牙编号
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([touches count] == 1) {
        for (UITouch *touch in touches) {
            CGPoint point = [touch locationInView:[touch view]];
            point = [[touch view] convertPoint:point toView:self.superview];
            CALayer *touchedLayer= [(CALayer *)self.layer.presentationLayer hitTest:point];
            
            NSString *number = [touchedLayer.name substringToIndex:kPrefixToothNumber];
            
            if (!number && !_currentTooth) return;   // 编号和牙都是nil
            
            if (number) {  // 编号有效
                Tooth *newSelectedTooth = [[Patient sharedPatient].teeth objectForKey:number];
                
                if ([newSelectedTooth isEqual:_currentTooth]) {  // 同一颗牙 (暂时不处理)
//                    newSelectedTooth.chartNumberLayer.foregroundColor = newSelectedTooth.statusColor;
//                    _currentTooth = nil;
                } else {   // 另一颗牙
                    _currentTooth.chartNumberLayer.foregroundColor = _currentTooth.statusColor;
                    _currentTooth = newSelectedTooth;
                    _currentTooth.chartNumberLayer.foregroundColor = kSelectedColor;
                }
            } else { // 编号无效，更新当前牙为nil
                _currentTooth.chartNumberLayer.foregroundColor = _currentTooth.statusColor;
                _currentTooth = nil;
            }
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
        }
    }
}





@end
