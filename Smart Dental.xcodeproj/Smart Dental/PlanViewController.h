//
//  PlanViewController.h
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanDetialViewController.h"
#import "ThumbBackground.h"

@interface PlanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topTitleView;
@property (weak, nonatomic) IBOutlet UIView *userInfoPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *textPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *thumbPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *detialPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIButton *contactsButton;

@property (nonatomic, strong) ThumbBackground *thumbBackgroundViewController;
@property (nonatomic, strong) PlanDetialViewController *detialViewController;

- (IBAction)popToChartViewController:(id)sender;
- (IBAction)pushInfoViewController:(id)sender;

@end
