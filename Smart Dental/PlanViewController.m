//
//  PlanViewController.m
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlanViewController.h"
#import "InfoViewController.h"
#import "Patient.h"
#import "UIView+Gradient.h"
#import "UIView+RoundedCorners.h"

@implementation PlanViewController

@synthesize topTitleView = _topTitleView;
@synthesize userInfoPlaceHolderView = _userInfoPlaceHolderView;
@synthesize textPlaceHolderView = _textPlaceHolderView;
@synthesize thumbPlaceHolderView = _thumbPlaceHolderView;
@synthesize detialPlaceHolderView = _detialPlaceHolderView;
@synthesize contactsButton = _contactsButton;

@synthesize thumbBackgroundViewController;
@synthesize detialViewController = _detialViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {


    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 整体背景渲染成灰色过渡色
    [self.view setGrayGradient];
    
    
    // 头部导航栏
    self.topTitleView.backgroundColor = [UIColor clearColor];
    
    
    
    // thumbPlaceHold 蓝色渐变
    [self.thumbPlaceHolderView setPlanBackgroundColorGradient];
    
    // thumbBackground
    self.thumbBackgroundViewController = [[ThumbBackground alloc] initWithNibName:@"ThumbBackground" bundle:nil];
    self.thumbBackgroundViewController.view.backgroundColor = [UIColor clearColor];
    [self.thumbPlaceHolderView addSubview:self.thumbBackgroundViewController.view];
    
    // detialPlaceHold圆角
    [self.detialPlaceHolderView setRoundedCorners: UIViewRoundedCornerLowerLeft | UIViewRoundedCornerUpperLeft radius:15.0f];
    [self.detialPlaceHolderView.layer setMasksToBounds:YES];
    
    
    // txtPlaceHolder圆角，蓝色渐变  必须以下方式! 单纯View圆角后无法形成圆角深蓝border的效果
    [_textPlaceHolderView.layer setCornerRadius:12.0f];
    [_textPlaceHolderView.layer setMasksToBounds:YES];
    _textPlaceHolderView.layer.borderColor = RGBCOLOR(131, 150, 159).CGColor;
    _textPlaceHolderView.layer.borderWidth = 2.0f;
    _textPlaceHolderView.layer.backgroundColor = RGBCOLOR(131, 150, 159).CGColor;
    
    // thumbHoldPlace 圆角
    [_thumbPlaceHolderView setRoundedCorners:UIViewRoundedCornerLowerRight | UIViewRoundedCornerUpperRight radius:15.0f];
    [_thumbPlaceHolderView.layer setMasksToBounds:YES];
    
    // userInfoPlaceHolder圆角和背景
    [_userInfoPlaceHolderView setRoundedCorners:UIViewRoundedCornerUpperRight | UIViewRoundedCornerLowerRight radius:12.f];
    [_userInfoPlaceHolderView setBackgroundColor:RGBCOLOR(131, 150, 159)];
    
    // Contacts按钮样式设置
    UIImage *templateImage = [UIImage imageNamed:@"contactsBg.png"];
    UIImage *stretchedImage = [templateImage stretchableImageWithLeftCapWidth:120 topCapHeight:32];
    [_contactsButton setBackgroundImage:stretchedImage forState:UIControlStateNormal];
    [_contactsButton setRoundedCorners:UIViewRoundedCornerAll radius:5];

    
    
    // 创建并加载detialView
    _detialViewController = [[PlanDetialViewController alloc] initWithNibName:@"PlanDetialViewController" bundle:nil];
  // TODO:  _detialViewController.detialDelegate = self;
    _detialViewController.view.frame = CGRectMake(0, -1, 573, 531);
    [_detialPlaceHolderView addSubview:_detialViewController.view];
    
    // 创建并加载thumbView
//    _thumbView = [[ChartThumbView alloc] initWithFrame:CGRectMake(0, 0, 810, 530)];
//    [_thumbPlaceHolderView addSubview:_thumbView];
//    [_thumbView addTarget:self action:@selector(changeSelectedToothOnNumber:) forControlEvents:UIControlEventValueChanged];    
//
}

- (void)viewDidUnload
{

    [self setTopTitleView:nil];
    [self setContactsButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)popToChartViewController:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushInfoViewController:(id)sender {
    InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:infoViewController animated:YES];
}
@end
