//
//  Residual_R.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Residual_R.h"

@implementation Residual_R
- (BOOL)performAction {
    if ([super performAction]) {
        [self hiddenDefaultFacialLayer:YES];
        [self applySimpleFacialImageAction];
    }
    return YES;
}



- (BOOL)performUndoAction {
    if ([super performUndoAction]) {
        [self hiddenDefaultFacialLayer:NO];
        [self applySimpleFacialImageUndoAction];
    }
    return YES;
}

@end
