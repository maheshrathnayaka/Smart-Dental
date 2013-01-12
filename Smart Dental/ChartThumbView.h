//
//  ChartThumbView.h
//  Dental
//
//  Created by xingzw@gmail.com on 2011-12-25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"


@interface ChartThumbView : UIControl 

- (Tooth *)getCurrentSelectTooth;
- (void)updateCurrentSelectTooth:(Tooth *)tooth;

@end
