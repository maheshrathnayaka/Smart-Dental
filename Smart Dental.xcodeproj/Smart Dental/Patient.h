//
//  Patient.h
//  Dental
//
//  Created by emmafromsc@gmail.com on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tooth.h"


@interface Patient : NSObject 

@property (nonatomic, strong) NSString *examID; 
@property (nonatomic, strong) NSString *name;  
@property (nonatomic, strong) NSDictionary *teeth;  

+ (Patient *) sharedPatient;       

@end   
     