//
//  ChartDetialViewController.h
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tooth.h"
#import "ChartDelegateProtocol.h"
#import "ChartAction.h"


@interface ChartDetialViewController : UIViewController 

@property (nonatomic,assign) id <ChartDelegateProtocol> chartDelegate;

@property (weak, nonatomic) IBOutlet UIView *activeView;
@property (nonatomic, strong) ChartAction *currentChartAction;
@property (nonatomic, strong) UIPopoverController *popMenuController;


- (void)enableAllButton:(BOOL)enable;
- (void)arrangeButton;
- (void)slideDetialView:(CGRect)frame;
- (void)unLoadActiveView;
- (void)swipeLeftGestureAction;
- (void)swipeRightGestureAction;

- (IBAction)chartButtonClick:(id)sender;



@end
