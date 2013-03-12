//
//  ChartDelegateProtocol.h
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-3.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tooth.h"
@protocol ChartDelegateProtocol <NSObject>

- (Tooth *)getCurrentTooth;
- (void)updateTableView;
- (void)arrangeDetialViewButton;

@end
