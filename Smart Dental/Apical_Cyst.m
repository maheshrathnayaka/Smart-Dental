//
//  Apical_Cyst.m
//  Smart Dental
//
//  Created by emmafromsc@gmail.com on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Apical_Cyst.h"

@implementation Apical_Cyst

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
