//
//  BLDLineFeedBackViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineFeedBackViewController.h"
#import "BLDLineUrlInvoker.h"
#import <FacebookSDK/FacebookSDK.h>
#import "GAIDictionaryBuilder.h"
#import "RFRateMe.h"

@interface BLDLineFeedBackViewController ()

@end

@implementation BLDLineFeedBackViewController

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
    self.screenName = @"Feedback";
	// Do any additional setup after loading the view.
    
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    
    self.txtView.layer.borderWidth = 2;
    self.txtView.layer.cornerRadius = 4;

    self.txtView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.submitBtn.layer.borderWidth = 1;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
  
}
-(void)viewWillAppear:(BOOL)animated{

[RFRateMe showRateAlertAfterTimesOpened:5];

}

-(void)viewDidAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Feedback"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
}
- (void)viewDidUnload
{
    [self setRateView:nil];
    //[self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



    



-(void)logButtonPress:(UIButton *)button{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Notify"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}

- (BOOL)textFieldShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}



//------------------Sharing a link using the share dialog------------------

-(IBAction)shareBtnlicked:(id)sender{
    
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"http://bloodregistry.org/"];
    params.name = @"BloodRegistry";
    params.caption = @"Fastest way to find blood donors";
    params.picture = [NSURL URLWithString:@"http://qbs-instahack.rhcloud.com/images/blood-registry-logo.jpg"];

    params.linkDescription = @"Helps you find blood donor with required blood group around you";
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                         name:params.name
                                      caption:params.caption
                                  description:params.linkDescription
                                      picture:params.picture
                                  clientState:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"BloodRegistry", @"name",
                                       @"Fastest way to find blood donors", @"caption",
                                       @"Helps you find blood donors with required blood group around you.", @"linkDescription",
                                       @"http://bloodregistry.org/", @"link",
                                       @"http://qbs-instahack.rhcloud.com/images/blood-registry-logo.jpg", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}

//------------------------------------


//------------------------------------

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

-(IBAction)submitbtnClicked:(id)sender{

    
    [self logButtonPress:(UIButton *)sender];
    NSString *url = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/feedback"];
    NSLog(@"Feedbacl Url -> %@",url);
   
   
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = @"5308318bce9e880000b1efd1";//[defaults objectForKey:@"UserID"];
    NSString *msg =  self.txtView.text;// @"Awesome App!";
    NSString *rate = ratingSelected;// @"5";
    if([rate length]==0)
        rate=@"0";
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:url,@"url",
                                   userID,@"user_id",rate,@"rating",msg,@"message",nil];
    
    
  //  NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:urlString,@"url", phone,@"phone",bldType,@"bg",longitude,@"lon",latitude,@"lat",@"Sample",@"device_id", priority,@"priority",nil];
    
    [[BLDLineUrlInvoker sharedInstance] postFeedBackRequest:param andProcessName:@selector(processFeedBack:)  requestMethod:@"POST" withObject:self];
    
}

-(void)processFeedBack:(NSData*)responsedata{
    
    NSError *error;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responsedata options:kNilOptions error:&error];
    
    
    
    NSString* newStr = [[NSString alloc] initWithData:responsedata
                        
                                             encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"Response - >%@",dictionary);
    
    
    NSString*msgTitle;
    NSString *messsage;
    //    if ([[dictionary objectForKey:@"status"] isEqualToString:@"success"]) {
    //
    //
    //
    //
    //        msgTitle=@"Notification Sent !";
    //        messsage = [dictionary objectForKey:@"notification"];
    //
    //    }else   if ([[dictionary objectForKey:@"status"] isEqualToString:@"Not implemented."]) {
    //
    //
    //
    //
    //        msgTitle=@"Under development";
    //        messsage = @"Notification Not Implemented !";
    //
    //    }else  if ([[dictionary objectForKey:@"status"] isEqualToString:@"Not implemented."]) {
    //
    //
    //
    //
    //        msgTitle=@"Under development";
    //        messsage = @"Notification Not Implemented !";
    //
    //    }else {
    //
    //        msgTitle=@"Notification Error";
    //        messsage = @"Notification failed ...";
    //
    //
    //    }
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Feedback Sent.."
                                                      message:[dictionary objectForKey:@"status"]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    ratingSelected = [NSString stringWithFormat:@"%i",(int)rating];
    NSLog(@"Rate --> %@",ratingSelected);
    [RFRateMe showRateAlertAfterTimesOpened:5];
}

@end
