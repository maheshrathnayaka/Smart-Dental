//
//  Tooth.m
//  Dental
//
//  Created by emmafromsc@gmail.com on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Tooth.h"

#import "ImageUtility.h"


@interface Tooth()

@end



@implementation Tooth

@synthesize number;
@synthesize needFlipImage;
@synthesize crownImageName;
@synthesize facialImageName;

@synthesize chartCrownLayer;
@synthesize chartFacialLayer;
@synthesize chartThumbCrownLayer;
@synthesize chartThumbFacialLayer;
@synthesize chartNumberLayer;

@synthesize planCrownLayer;
@synthesize planFacialLayer;
@synthesize planThumbCrownLayer;
@synthesize planThumbFacialLayer;
@synthesize planNumberLayer;

@synthesize statusColor;

@synthesize chartArray;
@synthesize planArray;
@synthesize pChartArray;

// 根据dict里的rect创建layer
- (CALayer *)createLayerFromDictionary:(NSDictionary *)dict Key:(NSString *)key LayerName:(NSString *)name{
    CALayer *layer = [CALayer layer];
    CGRect layerRect;
    CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)[dict objectForKey:key], &layerRect);
    layer.frame = layerRect;
    layer.name = name;
//    NSLog(@"Rect %@",NSStringFromCGRect(layerRect));
    return layer;

}


- (BOOL)isUpTooth:(NSString *)num {
    return [[@"11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28" componentsSeparatedByString:@","] containsObject:num];
}

// 创建牙编号的CATextLayer
#define kUpToothNumberY 244         // 上牙编号的Y值
#define kBottomToothNumberY 276     // 下牙编号的Y值
#define kNumberFontSize 11.0f       // 编号字体大小，如果更改大小，后面需要调整位置。字体最好等宽字体
                                    // CATextLayer中的文字无法居中对齐，所以要手工细微调整
- (CATextLayer *)createToothNumberLayer:(NSString *)num {
    CATextLayer *layer = [CATextLayer layer];
    layer.string = num;
    layer.foregroundColor = [UIColor whiteColor].CGColor;
    layer.fontSize = kNumberFontSize;
    float x = CGRectGetMidX(chartThumbCrownLayer.frame) - 6 ;    // 大约减去1个字符的距离
    float y = [self isUpTooth:self.number] ? kUpToothNumberY : kBottomToothNumberY ; 
    
    layer.frame = CGRectMake(x, y, 12, 10);   // 此rect的大小要细微手工调整
    layer.name = [NSString stringWithFormat:@"%@_number",num];
   // layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    return layer;
}



// 加入默认的牙齿图片
- (void)addDefaultToothImageLayer {
    NSString *path1 = [[NSBundle mainBundle] pathForResource:crownImageName ofType:@"png"];
    UIImage *crownImg = [UIImage imageWithContentsOfFile:path1];
    if (self.needFlipImage) {
        crownImg = [ImageUtility flipImageFromLeftToRight:crownImg];
    }
    CALayer *crownLayer = [CALayer layer];
    crownLayer.frame = self.chartCrownLayer.bounds; 
    crownLayer.contents = (id)crownImg.CGImage;
    crownLayer.contentsGravity = kCAGravityCenter;
    [self.chartCrownLayer addSublayer:crownLayer];
    crownLayer.name = @"DefaultCrown";
    
    //=------------------------------------
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:facialImageName ofType:@"png"];
    UIImage *facialImg = [UIImage imageWithContentsOfFile:path2];
    if (self.needFlipImage) {
        facialImg = [ImageUtility flipImageFromLeftToRight:facialImg];
    } 
    CALayer *facialLayer = [CALayer layer];
    facialLayer.frame = self.chartFacialLayer.bounds;
    facialLayer.contents = (id)facialImg.CGImage;
    facialLayer.contentsGravity = kCAGravityCenter;
    [self.chartFacialLayer addSublayer:facialLayer];
    facialLayer.name = @"DefaultFacial";
    
}

// thumbLayer
- (void)updateThumbLayer {
    // 截大图生成缩略图
    UIImage *captureCrownImg = [ImageUtility captureImageFromLayer:self.chartCrownLayer];
    UIImage *thumbCrownImg = [ImageUtility scaleImage:captureCrownImg scaleRatio:2.5f];
    self.chartThumbCrownLayer.contents = (id)thumbCrownImg.CGImage;
    
    UIImage *captureFacialImg = [ImageUtility captureImageFromLayer:self.chartFacialLayer];
    UIImage *thumbFacialImg = [ImageUtility scaleImage:captureFacialImg scaleRatio:2.5f];
    self.chartThumbFacialLayer.contents = (id)thumbFacialImg.CGImage;
}


// 初始化方法
- (id)initToothWithDictionary:(NSDictionary *)toothDict Number:(NSString *)num{
    if (self = [super init]) {
        self.number = num;
        self.crownImageName  = [toothDict objectForKey:kCrownImageName];
        self.facialImageName = [toothDict objectForKey:kFacialImageName];
        NSString *chartCrownLayerName  = [NSString stringWithFormat:@"%@_crown", self.number];
        NSString *chartFacialLayerName = [NSString stringWithFormat:@"%@_facial",self.number];
        NSString *planCrownLayerName   = [NSString stringWithFormat:@"%@_crown", self.number];
        NSString *planFacialLayerName  = [NSString stringWithFormat:@"%@_facial",self.number];
        NSString *thumbCrownLayerName  = [NSString stringWithFormat:@"%@_crown", self.number];
        NSString *thumbFacialLayerName = [NSString stringWithFormat:@"%@_facial",self.number];
        self.chartCrownLayer  = [self createLayerFromDictionary:toothDict Key:kCrownRootLayerRect LayerName:chartCrownLayerName];
        self.chartFacialLayer = [self createLayerFromDictionary:toothDict Key:kFacialRootLayerRect LayerName:chartFacialLayerName];
        self.planCrownLayer   = [self createLayerFromDictionary:toothDict Key:kCrownRootLayerRect LayerName:planCrownLayerName];
        self.planFacialLayer  = [self createLayerFromDictionary:toothDict Key:kFacialRootLayerRect LayerName:planFacialLayerName];
        self.chartThumbCrownLayer  = [self createLayerFromDictionary:toothDict Key:kThumbCrownRect LayerName:thumbCrownLayerName];
        self.chartThumbFacialLayer = [self createLayerFromDictionary:toothDict Key:kThumbFacialRect LayerName:thumbFacialLayerName];
        
        self.chartCrownLayer.masksToBounds = YES;
        self.chartFacialLayer.masksToBounds = YES;

        self.needFlipImage = [[@"21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38" componentsSeparatedByString:@","] containsObject:num];
        
        self.chartNumberLayer = [self createToothNumberLayer:self.number];
        
        self.statusColor = kNormalColor;
        
        self.chartArray = [[NSMutableArray alloc] init];
        self.planArray  = [[NSMutableArray alloc] init];
        
        [self addDefaultToothImageLayer];
        [self updateThumbLayer];
    }
    return self;
}



@end


