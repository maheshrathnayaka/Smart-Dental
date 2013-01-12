//
//  Patient.m
//  Dental
//
//  Created by emmafromsc@gmail.com on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"

#define kTEETH_PLIST_FILENAME @"teeth"

@implementation Patient

@synthesize examID;
@synthesize name;
@synthesize teeth;

// 单例
static Patient *instance = nil;
+ (Patient *) sharedPatient {
    @synchronized(self) {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    return instance;
}

// 初始化病人 和 病人的牙
- (void)initDefaultPatient {
    NSString *path = [[NSBundle mainBundle] pathForResource:kTEETH_PLIST_FILENAME ofType:@"plist"];
    NSDictionary *teethDict =[NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableDictionary *tmpTeeh = [NSMutableDictionary dictionary]; 
    
    for (NSString *number in [teethDict keyEnumerator]) {
        NSDictionary *toothPlistDict = [teethDict objectForKey:number];
        Tooth *tooth = [[Tooth alloc] initToothWithDictionary:toothPlistDict Number:number];
        NSDictionary *toothDict = [NSDictionary dictionaryWithObject:tooth forKey:number];
        [tmpTeeh addEntriesFromDictionary:toothDict];
//        NSLog(@"Tooth Number:%@",number);
    }
    
    self.teeth = [NSDictionary dictionaryWithDictionary:tmpTeeh];
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
}


- (id)init {
    if (self = [super init]) {
        [self initDefaultPatient];
    }
    return self;
}


@end

