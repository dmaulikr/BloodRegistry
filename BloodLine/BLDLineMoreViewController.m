//
//  BLDLineMoreViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 02/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineMoreViewController.h"
#import "GAIDictionaryBuilder.h"

@interface BLDLineMoreViewController ()

@end

@implementation BLDLineMoreViewController

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
    self.screenName = @"More";

	// Do any additional setup after loading the view.
    //self.bloodTypeRecP.transform=CGAffineTransformMakeRotation(3.14 / 2);

}

-(void)viewDidAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"More"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
