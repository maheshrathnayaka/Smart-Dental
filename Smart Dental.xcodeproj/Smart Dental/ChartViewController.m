//
//  ChartViewController.m
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ChartViewController.h"
#import "InfoViewController.h"
#import "Patient.h"
#import "UIView+Gradient.h"
#import "UIView+RoundedCorners.h"


@interface ChartViewController() {
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;   
}
@end

@implementation ChartViewController

@synthesize patient = _patient;
@synthesize currentTooth = _currentTooth;


//@synthesize thumbBackgroundView = _thumbBackgroundView;
@synthesize thumbBackgroundViewController;

@synthesize userInfoView = _userInfoView;
@synthesize examIDField = _examIDField;
@synthesize userNameField = _userNameField;
@synthesize swipeLeftGesture = _swipeLeftGesture;
@synthesize swipeRightGesture = _swipeRightGesture;
@synthesize spinnerIndicatorView = _spinnerIndicatorView;
@synthesize planViewController = _planViewController;
@synthesize thumbView = _thumbView;
@synthesize detialViewController=_detialViewController;
@synthesize contactsButton = _contactsButton;
@synthesize userInfoPlaceHolderView = _userInfoPlaceHolderView;
@synthesize textPlaceHolderView = _textPlaceHolderView;
@synthesize thumbPlaceHolderView = _thumbPlaceHolderView;
@synthesize detialPlaceHolderView = _detialPlaceHolderView;
@synthesize topTitleView = _topTitleView;

@synthesize chartTableView = _chartTableView;
@synthesize planTableView = _planTableView;


@synthesize allToothNumberArray = _allToothNumberArray;



#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取patient
    self.patient = [Patient sharedPatient];
    
    self.allToothNumberArray = [@"11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48" componentsSeparatedByString:@","] ;
    
    // Contacts按钮样式设置
    UIImage *templateImage = [UIImage imageNamed:@"contactsBg.png"];
    UIImage *stretchedImage = [templateImage stretchableImageWithLeftCapWidth:120 topCapHeight:32];
    [_contactsButton setBackgroundImage:stretchedImage forState:UIControlStateNormal];
    [_contactsButton setRoundedCorners:UIViewRoundedCornerAll radius:5];
    
    
    // 整体背景渲染成灰色过渡色
    [self.view setGrayGradient];
    
    
    // 头部导航栏
    self.topTitleView.backgroundColor = [UIColor clearColor];
    
    // thumbPlaceHold 蓝色渐变
    [self.thumbPlaceHolderView setChartBackgroundColorGradient];
    
    // thumbBackground
    self.thumbBackgroundViewController = [[ThumbBackground alloc] initWithNibName:@"ThumbBackground" bundle:nil];
    self.thumbBackgroundViewController.view.backgroundColor = [UIColor clearColor];
    [self.thumbPlaceHolderView addSubview:self.thumbBackgroundViewController.view];
//    [[NSBundle mainBundle] loadNibNamed:@"ThumbBackground" owner:self options:nil];
//    self.thumbBackgroundView.backgroundColor = [UIColor clearColor];
//    [self.thumbPlaceHolderView addSubview:self.thumbBackgroundView];
    
    // detialPlaceHold圆角
    [self.detialPlaceHolderView setRoundedCorners: UIViewRoundedCornerLowerLeft | UIViewRoundedCornerUpperLeft radius:15.0f];
    [self.detialPlaceHolderView.layer setMasksToBounds:YES];
    
    
    // txtPlaceHolder圆角，蓝色渐变  必须以下方式! 单纯View圆角后无法形成圆角深蓝border的效果
    [_textPlaceHolderView.layer setCornerRadius:12.0f];
    [_textPlaceHolderView.layer setMasksToBounds:YES];
    _textPlaceHolderView.layer.borderColor = RGBCOLOR(131, 150, 159).CGColor;
    _textPlaceHolderView.layer.borderWidth = 2.0f;
    _textPlaceHolderView.layer.backgroundColor = RGBCOLOR(131, 150, 159).CGColor;
    
    
    // 两个tableView设置
    UIEdgeInsets indicatorInset = UIEdgeInsetsMake(0, 0, 0, 5);
    [_chartTableView setScrollIndicatorInsets:indicatorInset];
    [_planTableView setScrollIndicatorInsets:indicatorInset];
    
    // thumbHoldPlace 圆角
    [_thumbPlaceHolderView setRoundedCorners:UIViewRoundedCornerLowerRight | UIViewRoundedCornerUpperRight radius:15.0f];
    [_thumbPlaceHolderView.layer setMasksToBounds:YES];
    
    // userInfoPlaceHolder圆角和背景
    [_userInfoPlaceHolderView setRoundedCorners:UIViewRoundedCornerUpperRight | UIViewRoundedCornerLowerRight radius:12.f];
    [_userInfoPlaceHolderView setBackgroundColor:RGBCOLOR(131, 150, 159)];
    
    // 创建并加载detialView
    _detialViewController = [[ChartDetialViewController alloc] initWithNibName:@"ChartDetialViewController" bundle:nil];
    _detialViewController.chartDelegate = self;
    _detialViewController.view.frame = CGRectMake(-2, -2, 573, 531);
    [_detialPlaceHolderView addSubview:_detialViewController.view];
    
    // 创建并加载thumbView
    _thumbView = [[ChartThumbView alloc] initWithFrame:CGRectMake(0, 0, 810, 530)];
//    [_thumbView setChartDelegate:self];
    [_thumbPlaceHolderView addSubview:_thumbView];
    [_thumbView addTarget:self action:@selector(thumbViewSelectToothValueChange:) forControlEvents:UIControlEventValueChanged];    
    
    // Gesture
    [_swipeLeftGesture addTarget:_detialViewController action:@selector(swipeLeftGestureAction)];
    [_swipeRightGesture addTarget:_detialViewController action:@selector(swipeRightGestureAction)];
    [_detialPlaceHolderView addGestureRecognizer:_swipeLeftGesture];
    [_detialPlaceHolderView addGestureRecognizer:_swipeRightGesture];
    
    [_examIDField setDelegate:self];
    [_userNameField setDelegate:self];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewUpForKeyboard:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewDownAfterKeyboard)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_patient.teeth count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = (tableView == _chartTableView) ? @"Chart:" : @"Plan:";
	return title;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    cell.textLabel.font= [UIFont fontWithName:@"Helvetica" size:14]; 
    cell.textLabel.numberOfLines = 10;
    
    cell.selectionStyle =  (tableView == _chartTableView) ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone ;

    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = RGBCOLOR(255, 255, 111); //黄底色
    cell.backgroundView = bgColorView;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    //选中时背景色
//    UIView *selectColorView = [[UIView alloc] init];
//    selectColorView.backgroundColor = RGBCOLOR(83, 140, 112);
//    [cell setSelectedBackgroundView:selectColorView];
    
    NSString *toothNumber = [_allToothNumberArray objectAtIndex:indexPath.row];
    Tooth *tooth = [_patient.teeth objectForKey:toothNumber];
    
    NSArray *actionArray = (tableView == _chartTableView) ? tooth.chartArray : tooth.planArray ;
    NSString *toothCharts =[actionArray componentsJoinedByString:@";"];
    NSString *cellString = [NSString stringWithFormat:@"%@. %@",toothNumber,toothCharts];
    cell.textLabel.text = cellString;
	return cell ;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *toothNumber = [_allToothNumberArray objectAtIndex:indexPath.row];
    _currentTooth = [_patient.teeth objectForKey:toothNumber];
    [_thumbView updateCurrentSelectTooth:_currentTooth];
//    UITableView *anotherTable = (tableView == _chartTableView) ? _planTableView : _chartTableView ;
    [_chartTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [_planTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    


    [_detialViewController arrangeButton];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  //  (indexPath.row % 2) ? [cell setBackgroundColor:RGBCOLOR(190, 190 , 190)] : [cell setBackgroundColor:RGBCOLOR(215, 215, 215)];
}




#pragma mark - SEL

- (void)thumbViewSelectToothValueChange:(id)sender {
    _currentTooth = [_thumbView getCurrentSelectTooth];
    NSLog(@"Current Select Tooth Number:%@",_currentTooth.number);
    [_detialViewController arrangeButton];
    [self arrangeDetialViewButton];
    [self updateTableView];
}



#pragma mark - Delegate Protocol

- (void)arrangeDetialViewButton {
 [_detialViewController arrangeButton];
}

- (void)updateTableView {
    [_chartTableView reloadData];  // 必须先reloadData再做其他处理!
    
    NSInteger row = [_allToothNumberArray indexOfObject:_currentTooth.number ];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [_chartTableView selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [_planTableView selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (Tooth *)getCurrentTooth {
    return _currentTooth;
}




#pragma mark - keyboard

- (void) shiftViewUpForKeyboard: (NSNotification*) notification {
    CGRect keyboardFrame;
    NSDictionary* infoDict = notification.userInfo;
    keyboardSlideDuration = [[infoDict objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[infoDict objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if UIInterfaceOrientationIsLandscape(theStatusBarOrientation)
        keyboardShiftAmount = keyboardFrame.size.width;
    else 
        keyboardShiftAmount = keyboardFrame.size.height;
    
    [UIView beginAnimations: @"ShiftUp" context: nil];
    [UIView setAnimationDuration: keyboardSlideDuration];
    self.view.center = CGPointMake( self.view.center.x, self.view.center.y - keyboardShiftAmount);
    [UIView commitAnimations];
    viewShiftedForKeyboard = TRUE;
}


- (void) shiftViewDownAfterKeyboard; {
    if (viewShiftedForKeyboard) {
        [UIView beginAnimations: @"ShiftUp" context: nil];
        [UIView setAnimationDuration: keyboardSlideDuration];
        self.view.center = CGPointMake( self.view.center.x, self.view.center.y + keyboardShiftAmount);
        [UIView commitAnimations];
        viewShiftedForKeyboard = FALSE;
    }
}


#pragma mark - ViewDidUnload


- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
    [super viewWillDisappear:YES];
}

- (void)viewDidUnload
{
    [self setThumbPlaceHolderView:nil];
    [self setDetialPlaceHolderView:nil];
    [self setTopTitleView:nil];
    [self setTextPlaceHolderView:nil];
    [self setContactsButton:nil];
    [self setUserInfoPlaceHolderView:nil];
    [self setSwipeLeftGesture:nil];
    [self setSwipeRightGesture:nil];
    [self setChartTableView:nil];
    [self setPlanTableView:nil];
    [self setExamIDField:nil];
    [self setUserNameField:nil];
    [self setUserInfoView:nil];
    [self setSpinnerIndicatorView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


#pragma mark - IBAction
// Patient重置  
- (IBAction)resetButtonClick:(id)sender {
    for (Tooth *tooth in _patient.teeth.allValues) {
        tooth.chartCrownLayer.sublayers = nil;
        tooth.chartFacialLayer.sublayers = nil;
        [tooth addDefaultToothImageLayer];
        tooth.statusColor = kNormalColor;
        tooth.chartNumberLayer.foregroundColor = tooth.statusColor;
        tooth.planNumberLayer.foregroundColor = tooth.statusColor;
        [tooth.chartArray removeAllObjects];
        [tooth.planArray removeAllObjects];
        [tooth.pChartArray removeAllObjects];
        [tooth updateThumbLayer];
        [_chartTableView reloadData];
        [_planTableView reloadData];
    }
    _examIDField.text = _patient.examID = nil ;
    _userNameField.text = _patient.name = nil ;
    _currentTooth = nil;
    [_detialViewController arrangeButton];
}


//- (IBAction)testClick:(id)sender {
//   CGRect kSlideToLeftFrame   = {{-2  , -2},{575, 534}};
//    [_detialViewController slideDetialView:kSlideToLeftFrame];
//}


- (IBAction)contactsButtonClick:(id)sender {
//    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self;
//	[self presentModalViewController:picker animated:YES];
}

- (IBAction)pushPlanViewController:(id)sender {
    if (!self.planViewController) {
        self.planViewController = [[PlanViewController alloc] initWithNibName:@"PlanViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.planViewController animated:YES];
}

// 跳转开发者信息页面
- (IBAction)pushInfoViewController:(id)sender {
    [_spinnerIndicatorView startAnimating]; 
    [self performSelector: @selector(copyChartLayersToPChart) 
               withObject: nil 
               afterDelay: 0];
    
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.5f;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    transition.type = kCATransitionMoveIn; // 可以有更多效果，字符串指定
    //    transition.subtype = kCATransitionFromRight;
    //    transition.delegate = self;
    //    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:infoViewController animated:YES];
    
    
}


- (void)copyChartLayersToPChart {
    // 
    [_spinnerIndicatorView stopAnimating];
}


#pragma mark - AddressBook
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	self.userNameField.text = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}

@end
