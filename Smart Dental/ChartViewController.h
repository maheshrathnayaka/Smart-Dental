//
//  ChartViewController.h
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "PlanViewController.h"
#import "Patient.h"
#import "ChartThumbView.h"
#import "ChartDetialViewController.h"
#import "ChartDelegateProtocol.h"
#import "ThumbBackground.h"

@interface ChartViewController : UIViewController <ChartDelegateProtocol ,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
//, ABPeoplePickerNavigationControllerDelegate>




@property (nonatomic, strong) PlanViewController *planViewController;
@property (nonatomic, assign) Patient *patient;
@property (nonatomic, assign) Tooth *currentTooth;
@property (nonatomic, strong) ChartThumbView *thumbView;
@property (nonatomic, strong) ChartDetialViewController *detialViewController;
@property (nonatomic, strong) NSArray *allToothNumberArray;

@property (weak, nonatomic) IBOutlet UIButton *contactsButton;
@property (weak, nonatomic) IBOutlet UIView *userInfoPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *textPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *thumbPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *detialPlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *topTitleView;
@property (weak, nonatomic) IBOutlet UITableView *chartTableView;
@property (weak, nonatomic) IBOutlet UITableView *planTableView;
//@property (weak, nonatomic) IBOutlet UIView *thumbBackgroundView;
@property (nonatomic,strong) ThumbBackground *thumbBackgroundViewController;

@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UITextField *examIDField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRightGesture;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerIndicatorView;



- (IBAction)contactsButtonClick:(id)sender;
- (IBAction)pushPlanViewController:(id)sender;
- (IBAction)pushInfoViewController:(id)sender;
- (void)thumbViewSelectToothValueChange:(id)sender;
- (IBAction)resetButtonClick:(id)sender;

//- (IBAction)testClick:(id)sender;

@end
