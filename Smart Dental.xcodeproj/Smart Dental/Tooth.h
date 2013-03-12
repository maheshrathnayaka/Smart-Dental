//
//  Tooth.h
//  Dental
//
//  Created by emmafromsc@gmail.com on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


#define kThumbCrownRect          @"thumbCrownRect"
#define kThumbFacialRect         @"thumbFacialRect"
#define kCrownImageName          @"crownImageName"          
#define kFacialImageName         @"facialImageName"
#define kCrownRootLayerRect      @"crownRootLayerRect"  
#define kFacialRootLayerRect     @"facialRootLayerRect"


#define kSelectedColor    [UIColor yellowColor].CGColor;
#define kNormalColor      [UIColor whiteColor].CGColor;
#define kChartedColor     [UIColor redColor].CGColor;
#define kPlanedColor      [UIColor greenColor].CGColor;


@interface Tooth : NSObject  

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *crownImageName;
@property (nonatomic, strong) NSString *facialImageName;

@property (nonatomic, strong) CALayer *chartCrownLayer;
@property (nonatomic, strong) CALayer *chartFacialLayer;
@property (nonatomic, strong) CALayer *chartThumbCrownLayer;
@property (nonatomic, strong) CALayer *chartThumbFacialLayer;
@property (nonatomic, strong) CATextLayer *chartNumberLayer;

@property (nonatomic, strong) CALayer *planCrownLayer;
@property (nonatomic, strong) CALayer *planFacialLayer;
@property (nonatomic, strong) CALayer *planThumbCrownLayer;
@property (nonatomic, strong) CALayer *planThumbFacialLayer;
@property (nonatomic, strong) CATextLayer *planNumberLayer;

@property (nonatomic) CGColorRef  statusColor;

@property (nonatomic, strong) NSMutableArray *chartArray;
@property (nonatomic, strong) NSMutableArray *planArray;
@property (nonatomic, strong) NSMutableArray *pChartArray;

@property (nonatomic) BOOL needFlipImage;

- (id)initToothWithDictionary:(NSDictionary *)toothDict Number:(NSString *)num;

- (void)updateThumbLayer;

- (void)addDefaultToothImageLayer;

@end
