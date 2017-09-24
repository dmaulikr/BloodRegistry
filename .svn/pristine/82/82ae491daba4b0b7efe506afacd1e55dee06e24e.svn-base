//
//  BLDLineFeedBackViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import  "QuartzCore/QuartzCore.h"
#import "GAITrackedViewController.h"

@interface BLDLineFeedBackViewController : GAITrackedViewController<RateViewDelegate>{

    NSString *ratingSelected;
}

@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (assign, nonatomic)IBOutlet UIButton *shareButton;


-(IBAction)submitbtnClicked:(id)sender;
-(IBAction)shareBtnlicked:(id)sender;

@end
