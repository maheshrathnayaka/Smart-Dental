//
//  Missing.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Missing.h"
@implementation Missing

- (BOOL)performAction {
    if ([super performAction]) {
        [self hiddenDefaultCrownLayer:YES];
        [self hiddenDefaultFacialLayer:YES];
        [self.tooth updateThumbLayer];
    }
    return YES;
}



- (BOOL)performUndoAction {
    if ([super performUndoAction]) {
        [self hiddenDefaultCrownLayer:NO];
        [self hiddenDefaultFacialLayer:NO];
        [self.tooth updateThumbLayer];
    }
    return YES;
}

@end
