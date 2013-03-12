//
//  ChartAction.h
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ChartDelegateProtocol.h"
#import "ImageUtility.h"
#import "Tooth.h"



typedef enum{
    kAcion,
    kActiveView,
    kPopMenu,
    kTableMenu
}ActionViewType;

#define kCrownPart @"Crown"
#define kFacialPart @"Facial"

@interface ChartAction : UIViewController 

@property (nonatomic,assign) id<ChartDelegateProtocol> chartDelegate;
@property (nonatomic,assign) Tooth *tooth;
@property (nonatomic,strong) NSString *actionName;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic) ActionViewType viewType;
@property (nonatomic,strong) CALayer *actionCrownLayer;
@property (nonatomic,strong) CALayer *actionFacialLayer;
@property (nonatomic,strong) NSString *actionCrownLayerName;
@property (nonatomic,strong) NSString *actionFacialLayerName;



+ (NSString *)titleToActionName:(NSString *)btTitle;
+ (NSString *)actionNameToTitle:(NSString *)className;

-(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;
- (id)initWithDelegate:(id<ChartDelegateProtocol>)delegate;
- (void)initActiveView;
- (BOOL)performAction;
- (BOOL)performUndoAction;
- (void)initActionLayer;
- (void)applyActionLayer;
- (UIImage *)getActionImageOnPart:(NSString *)part Sequence:(NSString *)sequence;
- (CALayer *)getActionLayerOnPart:(NSString *)part Sequence:(NSString *)sequence;
- (void)hiddenDefaultCrownLayer:(BOOL)hidden;
- (void)hiddenDefaultFacialLayer:(BOOL)hidden;
- (void)applySimpleFacialImageAction;
- (void)applySimpleFacialImageUndoAction;
- (void)applySimpleCrownImageUndoAction;
- (UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;
@end
