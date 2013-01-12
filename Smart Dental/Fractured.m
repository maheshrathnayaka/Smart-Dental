//
//  Decay.m
//  Smart Dental
//
//  Created by xingzw@gmail.com on 2012-01-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Fractured.h"

@implementation Fractured
@synthesize bt3;
@synthesize bt2;
@synthesize bt1;


- (void)initActiveView {
    [super initActiveView];
    self.viewType = kPopMenu;
    [[NSBundle mainBundle] loadNibNamed:@"Fractured" owner:self options:nil];
    bt1.backgroundColor = bt2.backgroundColor = bt3.backgroundColor = [UIColor yellowColor];
    

}


- (IBAction)bt1Click:(id)sender {
    NSLog(@"Tooth Number:%@",self.tooth.number);
}

- (IBAction)bt2Click:(id)sender {
    NSLog(@"Tooth Charts:%@",self.tooth.chartArray);
}

- (IBAction)bt3Click:(id)sender {
    
}



//#pragma mark -
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc that aren't in use.
//}
//
//#pragma mark - View lifecycle
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

- (void)viewDidUnload {
    [self setBt1:nil];
    [self setBt2:nil];
    [self setBt3:nil];
    [super viewDidUnload];
}
@end
