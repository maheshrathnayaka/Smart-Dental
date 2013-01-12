//
//  Decay.h
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartAction.h"

@interface Fractured : ChartAction
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
- (IBAction)bt1Click:(id)sender;
- (IBAction)bt2Click:(id)sender;
- (IBAction)bt3Click:(id)sender;

@end
