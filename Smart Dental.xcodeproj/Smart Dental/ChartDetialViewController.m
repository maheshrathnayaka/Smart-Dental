//
//  ChartDetialViewController.m
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChartDetialViewController.h"
#import "DentalButton.h"
#import "UIView+Gradient.h"
#import "ChartAction.h"
#import "Patient.h"

@implementation ChartDetialViewController


@synthesize chartDelegate = _chartDelegate;
@synthesize activeView = _activeView;
@synthesize currentChartAction = _currentChartAction;
@synthesize popMenuController = _popMenuController;



const CGRect kSlideToLeftFrame   = {{-2  , -2},{575, 534}};
const CGRect kSlideToMiddleFrame = {{-149, -2},{575, 534}};
const CGRect kSlideToRightFrame  = {{-361, -2},{575, 534}};


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         
    }
    return self;
}



// Button的启用和禁用
- (void)enableAllButton:(BOOL)enable{
    for (UIButton *button in self.view.subviews) button.enabled = enable;
}

/* 设置Button显示
   chart里只判断选了牙都enable，没选都disable
   plan里要根据chart情况动态选择哪些enable
*/ 
- (void)arrangeButton{
    if ([_chartDelegate getCurrentTooth]) {
        [self enableAllButton:YES];
        [_chartDelegate getCurrentTooth].chartArray.count > 0 ? [self slideDetialView:kSlideToMiddleFrame] : [self slideDetialView:kSlideToLeftFrame];
    } else {
        [self enableAllButton:NO]; 
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setChartBackgroundColorGradient];    
    [self arrangeButton];

}



- (void)slideDetialView:(CGRect)frame {
    [UIView beginAnimations:@"slide" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2]; //  seconds
    self.view.frame = frame;
    [UIView commitAnimations];
}



- (void)loadPopMenuOnButton:(UIButton *)button {
    [self slideDetialView:kSlideToMiddleFrame];
    _popMenuController = [[UIPopoverController alloc] initWithContentViewController:_currentChartAction];
    CGRect frm = button.frame;
    frm.origin = CGPointMake(CGRectGetMidX(frm), CGRectGetMidY(frm));
    frm.size  = CGSizeMake(1,1);
    _popMenuController.popoverContentSize = _currentChartAction.view.frame.size;

    [_popMenuController presentPopoverFromRect:frm inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
}

- (void)loadTableMenu {
    // Chart里面没有TableMenu，Plan里有
}

- (void)loadActiveView {
    [_activeView addSubview:_currentChartAction.view];
    [self slideDetialView:kSlideToRightFrame];
}

- (void)unLoadActiveView {
    if (_currentChartAction) [_currentChartAction.view removeFromSuperview];
    _currentChartAction = NULL;
}

// 点击button
- (IBAction)chartButtonClick:(id)sender {
    [self unLoadActiveView];
    
    DentalButton *chartButton = (DentalButton *)sender;
    
    NSString *title =  [ChartAction titleToActionName:chartButton.currentTitle];

    _currentChartAction = (ChartAction *)[[NSClassFromString(title) alloc]initWithDelegate:_chartDelegate];  
    
    switch (_currentChartAction.viewType) {
        case kPopMenu:
            [self loadPopMenuOnButton:chartButton] ;
            break;
        case kTableMenu:
            [self loadTableMenu];
            break;
        case kActiveView:
            [self loadActiveView];
            break;
        case kAcion:
            [_currentChartAction performAction];
            _currentChartAction = nil;
    }
    
}


// 单指左扫
- (void)swipeLeftGestureAction {
    if (_currentChartAction) {
        NSLog(@"currentChartAction:%@",_currentChartAction.actionName);
    }
    Tooth *tooth = [_chartDelegate getCurrentTooth];
    NSString *chartName = [ChartAction titleToActionName:[tooth.chartArray lastObject]];
    id chartClass = [[NSClassFromString(chartName)alloc] initWithDelegate:_chartDelegate];
    [chartClass performSelector:@selector(performUndoAction)];
    [self arrangeButton];
    NSLog(@"SwipeLeft");
}


// 单指右扫
- (void)swipeRightGestureAction {
    [self arrangeButton];
    NSLog(@"SwipeRight");

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setActiveView:nil];
    [super viewDidUnload];
}

@end
