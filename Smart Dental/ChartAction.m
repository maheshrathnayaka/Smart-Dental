//
//  ChartAction.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChartAction.h"

@interface ChartAction()

@end

@implementation ChartAction

@synthesize chartDelegate = _chartDelegate;
@synthesize tooth = _tooth;
@synthesize actionName = _actionName;
@synthesize actionTitle = _actionTitle;
@synthesize viewType = _viewType;
@synthesize actionCrownLayer = _actionCrownLayer;
@synthesize actionFacialLayer = _actionFacialLayer;
@synthesize actionCrownLayerName = _actionCrownLayerName;
@synthesize actionFacialLayerName = _actionFacialLayerName;


#define kTITLETOCLASS_PLIST_FILENAME @"TitleToClass"
+ (NSString *)titleToActionName:(NSString *)btTitle {
    NSString *path = [[NSBundle mainBundle] pathForResource:kTITLETOCLASS_PLIST_FILENAME ofType:@"plist"];
    NSDictionary *chartTitleToClass =[[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Chart"];
    return [chartTitleToClass objectForKey:btTitle];
}

+ (NSString *)actionNameToTitle:(NSString *)className {
    NSString *path = [[NSBundle mainBundle] pathForResource:kTITLETOCLASS_PLIST_FILENAME ofType:@"plist"];
    NSDictionary *chartTitleToClass =[[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Chart"];
    NSArray *keys = [chartTitleToClass allKeysForObject:className];
    return  [keys objectAtIndex:0];
    
}


////渲染png图片
-(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor  {
    UIGraphicsBeginImageContext(baseImage.size); 
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0.0, -baseImage.size.height);
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    CGContextSetBlendMode (context, kCGBlendModeMultiply); //
    CGContextDrawImage(context, area, baseImage.CGImage);  //
    CGContextClipToMask(context, area, baseImage.CGImage);
    CGContextSetFillColorWithColor(context, [theColor CGColor]);
    CGContextFillRect(context, area);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (id)initWithDelegate:(id<ChartDelegateProtocol>)delegate {
    if (self = [super init]) {
        _chartDelegate = delegate;
        _tooth = [_chartDelegate getCurrentTooth];
        _actionName = [self.class description];
        _actionTitle = [self.class actionNameToTitle:_actionName];
        _viewType = kAcion; // TODO: 各action自己定义
        
        _actionCrownLayerName =  [NSString stringWithFormat:@"%@_%@_%@",  _tooth.number, kCrownPart, _actionName];
        _actionFacialLayerName = [NSString stringWithFormat:@"%@_%@_%@", _tooth.number, kFacialPart ,_actionName];
//        NSLog(@"ChartAction.m initWithDelegate");
        [self initActiveView];
    }
    return self;
}

- (void)initActiveView {

}


- (BOOL)performAction{
    if ([_tooth.chartArray containsObject:_actionTitle]) {
        [self performUndoAction];
        return NO;
    } else {
        [_tooth.chartArray addObject:_actionTitle];
        _tooth.statusColor = kChartedColor;
        [_chartDelegate arrangeDetialViewButton];
        [_chartDelegate updateTableView];
        return YES;
    }
    
}

- (BOOL)performUndoAction {
    if ([_tooth.chartArray containsObject:_actionTitle]) {
        [_tooth.chartArray removeObject:_actionTitle];
        if (_tooth.chartArray.count == 0)  _tooth.statusColor = kNormalColor;    
        [_chartDelegate arrangeDetialViewButton];
        [_chartDelegate updateTableView];
        return YES;
    } else {
        return NO;
    }
}

- (void)hiddenDefaultCrownLayer:(BOOL)hidden {
    NSArray *crownSubLayers = self.tooth.chartCrownLayer.sublayers ;
    for (CALayer *layer in crownSubLayers) {
        if ([layer.name isEqualToString:@"DefaultCrown"]) layer.hidden = hidden;
    }
}

- (void)hiddenDefaultFacialLayer:(BOOL)hidden {
    NSArray *facialSubLayers = self.tooth.chartFacialLayer.sublayers ;
    for (CALayer *layer in facialSubLayers) {
        if ([layer.name isEqualToString:@"DefaultFacial"]) layer.hidden = hidden;
    }
}


- (void)applySimpleFacialImageAction {
    [self initActionLayer];
    CALayer *layer = [self getActionLayerOnPart:kFacialPart Sequence:nil];
    if (layer) {
        [self.actionFacialLayer addSublayer:layer];
        [self applyActionLayer];    
        [_tooth updateThumbLayer];
    }
}

- (void)applySimpleFacialImageUndoAction {
    NSArray *sublayers = self.tooth.chartFacialLayer.sublayers ;
    for (CALayer *layer in sublayers) {
        if ([layer.name isEqualToString:self.actionFacialLayerName]) {
            [layer removeFromSuperlayer];
        }
    }
    [_tooth updateThumbLayer];
}

- (void)applySimpleCrownImageUndoAction {
    NSArray *sublayers = self.tooth.chartCrownLayer.sublayers ;
    for (CALayer *layer in sublayers) {
        if ([layer.name isEqualToString:self.actionCrownLayerName]) {
            [layer removeFromSuperlayer];
        }
    }
    [_tooth updateThumbLayer];
}

- (void)initActionLayer {
    NSArray *subActionCrownlayers = self.tooth.chartCrownLayer.sublayers;
    for (CALayer *layer in subActionCrownlayers) {
        if ([layer.name isEqualToString:self.actionCrownLayerName]) {
            _actionCrownLayer = layer;
        }
    }
    
    NSArray *subActionFacialLayers = self.tooth.chartFacialLayer.sublayers;
    for (CALayer *layer in subActionFacialLayers) {
        if ([layer.name isEqualToString:self.actionFacialLayerName]) {
            _actionFacialLayer = layer;
        }
    }
    
    if (!_actionCrownLayer) {
        _actionCrownLayer = [CALayer layer];
        _actionCrownLayer.frame = _tooth.chartCrownLayer.bounds;
        _actionCrownLayer.name = _actionCrownLayerName;
    }
    
    if (!_actionFacialLayer) {
        _actionFacialLayer = [CALayer layer];
        _actionFacialLayer.frame = _tooth.chartFacialLayer.bounds;
        _actionFacialLayer.name = _actionFacialLayerName;
    }

}

- (void)applyActionLayer {
    [_tooth.chartCrownLayer addSublayer:_actionCrownLayer];
    [_tooth.chartFacialLayer addSublayer:_actionFacialLayer];
}

- (UIImage *)getActionImageOnPart:(NSString *)part Sequence:(NSString *)sequence {
    UIImage *img = [ImageUtility actionImageOfTooth:_tooth CrownOrFacial:part ActionName:_actionName SequenceNumber:sequence];
    return img;
}


- (CALayer *)getActionLayerOnPart:(NSString *)part Sequence:(NSString *)sequence {
    UIImage *img = [ImageUtility actionImageOfTooth:_tooth CrownOrFacial:part ActionName:_actionName SequenceNumber:sequence];
    if (img) {
        CALayer *subLayer = [CALayer layer];   
         
        subLayer.frame = [part isEqualToString:kCrownPart] ? _tooth.chartCrownLayer.bounds : _tooth.chartFacialLayer.bounds;
        subLayer.name = [NSString stringWithFormat:@"%@_%@",sequence,part];
        subLayer.contentsGravity = kCAGravityCenter;
        subLayer.contents = (id)img.CGImage;
        return subLayer;
    } else {
        return nil;
    }
}



@end
