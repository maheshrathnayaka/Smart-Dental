//
//  Primary.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-3.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Primary.h"

@interface Primary()
- (void)showAlert;
@end

@implementation Primary

- (BOOL)performAction {
    if ([super performAction]) {
        [self showAlert];
    }
    return YES;
}


- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Waiting for primary chart,please!" 
                                                    message:nil 
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil, nil];
    [alert show];        
}


@end
