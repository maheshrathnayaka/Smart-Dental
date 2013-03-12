//
//  Implant.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Implant.h"


@implementation Implant

- (BOOL)performAction {
    if ([super performAction]) {
        [self applySimpleFacialImageAction];
    }
    return YES;
}



- (BOOL)performUndoAction {
    if ([super performUndoAction]) {
        [self applySimpleFacialImageUndoAction];
    }
    return YES;
}


@end
