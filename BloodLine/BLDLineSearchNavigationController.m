//
//  BLDLineSearchNavigationController.m
//  BloodLine
//
//  Created by Avinash Kawade on 28/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineSearchNavigationController.h"

@interface BLDLineSearchNavigationController ()

@end

@implementation BLDLineSearchNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];
  
     }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
