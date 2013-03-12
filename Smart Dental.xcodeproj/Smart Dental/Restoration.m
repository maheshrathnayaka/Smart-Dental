//
//  Restoration.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Restoration.h"
#import "Patient.h"
#import "ImageUtility.h"

@interface Restoration()
@property (nonatomic) CGRect touchFrame;
@property (nonatomic,strong) NSString *sequence;
@property (nonatomic,assign) NSArray *subRestorationLayers;
@end

@implementation Restoration
@synthesize touchFrame = _touchFrame;
@synthesize sequence = _sequence;
@synthesize subRestorationLayers = _subRestorationLayers;


// 角度
- (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint {
    // get origin point to origin by subtracting end from start
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); 
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

// 标靶
- (NSUInteger)dartboardRect:(CGRect)frame BullEyeRadius:(float)bullEyeRadius  DartPoint:(CGPoint)point {
    CGPoint centerPoint = self.tooth.chartCrownLayer.position;
    float dartRadius = hypotf(point.x-centerPoint.x, point.y-centerPoint.y);
    NSLog(@"DartRadius:%d BullEyeRadius:%3.f",abs(dartRadius),bullEyeRadius);
    if (abs(dartRadius) <  bullEyeRadius)  return 8;       
    float degree = [self pointPairToBearingDegrees:centerPoint secondPoint:point];
    float quadrant = floorf(degree/45);
    NSLog(@"Degree:%3.f  Quadrant:%3.f",degree,quadrant);
    return quadrant;
}



- (NSString *)getRestorationSequence:(NSUInteger)quadrant {
    // 360÷45 ＝ 8  必须有九个配置项
    NSArray *lv = [@"A,A,B,B,B,B,A,A,A" componentsSeparatedByString:@","]; //左侧:左右两分
    NSArray *lh = [@"A,A,A,A,B,B,B,B,A" componentsSeparatedByString:@","]; //左侧:上下两分
    NSArray *l4 = [@"A,B,B,C,C,D,D,A,A" componentsSeparatedByString:@","]; //左侧:交叉四分
    NSArray *l5 = [@"A,B,B,C,C,D,D,A,E" componentsSeparatedByString:@","]; //左侧:交叉并有中心，共五分 ,中心为E
    
    NSArray *rv = [@"B,B,A,A,A,A,B,B,B" componentsSeparatedByString:@","]; //右侧:左右两分
    NSArray *rh = [@"A,A,A,A,B,B,B,B,A" componentsSeparatedByString:@","]; //右侧:上下两分
    NSArray *r4 = [@"C,B,B,A,A,D,D,C,C" componentsSeparatedByString:@","]; //右侧:交叉四分
    NSArray *r5 = [@"C,B,B,A,A,D,D,C,E" componentsSeparatedByString:@","]; //右侧:交叉并有中心，共五分 ,中心为E
     
    NSString *str =                          @"11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48";
    NSArray *types = [NSArray arrayWithObjects:lv,lv,lh,l4,l4,l5,l5,l4,rv,rv,rh,r4,r4,r5,r5,r4,rv,rv,rh,r4,r4,r5,r5,r4,lv,lv,lh,l4,l4,l5,l5,l4,nil];
    NSArray *allToothNumbers = [str componentsSeparatedByString:@","];
    
    NSArray *type = [types objectAtIndex:[allToothNumbers indexOfObject:self.tooth.number]];
    
    NSString *sequence = [type objectAtIndex:quadrant];
    return sequence;
}


#define  kEyeRadius  40.0f    // 中心圆半径，如须更精确要每颗牙单独设置。
- (float)getRestorationEyeRadius:(Tooth *)tooth{
    NSArray *array = [@"16,17,26,27,36,37,46,47" componentsSeparatedByString:@","];
    float eyeRadius = 0.0f;
    if ([array containsObject:tooth.number]) eyeRadius = kEyeRadius; 
    return eyeRadius;
}



- (CALayer *)createRestorationSubActionLayerWithTooth:(Tooth *)tooth Sequence:(NSString *)sequence {
    UIImage *img = [ImageUtility actionImageOfTooth:self.tooth CrownOrFacial:kCrownPart ActionName:self.actionName SequenceNumber:sequence];
    if (img) {
        UIImage *colorImage = [self colorizeImage:img color:[UIColor lightGrayColor]];
        CALayer *subLayer = [CALayer layer];   
        subLayer.opacity = .75f;
        subLayer.frame = tooth.chartCrownLayer.bounds ;
        subLayer.name = sequence;
        subLayer.contentsGravity = kCAGravityCenter;
        subLayer.contents = (id)colorImage.CGImage;
        return subLayer;
    } else {
        return nil;
    }
}


#define kPlusSize  6 //增大尺寸便于点击
- (void)initActiveView {
    [super initActiveView];
    self.viewType = kActiveView;
    [[NSBundle mainBundle] loadNibNamed:@"Restoration" owner:self options:nil] ;
    [self initActionLayer];
    

    _touchFrame = self.tooth.chartCrownLayer.frame;
    _touchFrame.origin.x -=kPlusSize;
    _touchFrame.size.width +=kPlusSize*2;
    
    self.view.backgroundColor = [UIColor clearColor];  
    [self.view.layer addSublayer:self.tooth.chartCrownLayer];
    [self.view.layer addSublayer:self.tooth.chartFacialLayer];

}




- (BOOL)performAction {
    CALayer *layer = [self createRestorationSubActionLayerWithTooth:self.tooth Sequence:_sequence];
    
    NSArray *subLayers = self.tooth.chartCrownLayer.sublayers;
    CALayer *actionLayer;
    for (CALayer *restorationActionlayer in subLayers) {
        if ([restorationActionlayer.name isEqualToString:self.actionCrownLayerName]) {
            actionLayer = restorationActionlayer;
        }
    }
    
    BOOL exist = NO;
    CALayer *subActionLayer;
    for (CALayer *subLayer in actionLayer.sublayers) {
        if ([subLayer.name isEqualToString:layer.name]) {
            subActionLayer = subLayer;
            exist = YES;
        }
    }
    
    if (exist) {
        [subActionLayer removeFromSuperlayer];
        int subRestorationLayerCount = actionLayer.sublayers.count;
        if (subRestorationLayerCount==0 && [self.tooth.chartArray containsObject:self.actionTitle]) {
            [self.tooth.chartArray removeObject:self.actionTitle];
            self.tooth.statusColor = kNormalColor;
        }
    } else {
        [self.actionCrownLayer addSublayer:layer];
        int subRestorationLayerCount = actionLayer.sublayers.count;
        if (subRestorationLayerCount>=0 && ![self.tooth.chartArray containsObject:self.actionTitle]) {
            [self.tooth.chartArray addObject:self.actionTitle];
            self.tooth.statusColor = kChartedColor;
        }
        [self applyActionLayer];
    }
    
    [self.tooth updateThumbLayer];
    [self.chartDelegate updateTableView];
    return YES;
}

-(BOOL)performUndoAction {
    NSArray *subLayers = self.tooth.chartCrownLayer.sublayers;
    CALayer *actionLayer;
    for (CALayer *restorationActionlayer in subLayers) {
        if ([restorationActionlayer.name isEqualToString:self.actionCrownLayerName]) {
            actionLayer = restorationActionlayer;
        }
    }
    if (actionLayer) [actionLayer removeFromSuperlayer];
    
    [self.tooth updateThumbLayer];
    [super performUndoAction];
    return YES;
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        for (UITouch *touch in touches) {
            CGPoint point = [touch locationInView:[touch view]];
            point = [[touch view] convertPoint:point toView:self.view];
            if (CGRectContainsPoint(_touchFrame, point)) {
                float eyeRadius = [self getRestorationEyeRadius:self.tooth];
                int quadrant = [self dartboardRect:_touchFrame BullEyeRadius:eyeRadius DartPoint:point];
                _sequence = [self getRestorationSequence:quadrant];
                [self performAction];
            }
        }
    }
 
}




//// 重写初始化
//- (id)initWithDelegate:(id<ChartDelegateProtocol>)delegate {
//    if (self = [super initWithDelegate:delegate]) {
//        
//    }
//    return self;
//}


//#pragma mark - View lifecycle

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        NSLog(@"Restoration.m initWithNibName");
//    }
//    return self;
//}
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    NSLog(@"Restoration.m awakeFromNib");
//}
//
//- (void)loadView {
//    [super loadView];
//    NSLog(@"Restoration.m loadView");
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"Restoration.m viewWillAppear");
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSLog(@"Restoration.m viewdidload");
//}
//
//
//- (void)viewDidUnload {
//    NSLog(@"Restoration.m viewdidUnload");
//    [super viewDidUnload];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	return YES;
//}
//

@end
