//
//  BLDLineNotifyViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineNotifyViewController.h"
#import "BLDLineAppDelegate.h"
#import "BLDLineUrlInvoker.h"
#import  "QuartzCore/QuartzCore.h"
#import "GAIDictionaryBuilder.h"

#define kTitleTag 1000

@interface BLDLineNotifyViewController (){
    BOOL isAnimating;
}


@end

@implementation BLDLineNotifyViewController
@synthesize bloodTypeListArray;
@synthesize tapTextFieldView;

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
    self.screenName = @"Notify";
	// Do any additional setup after loading the view.
    self.bloodTypeListArray  = [[NSMutableArray alloc]initWithObjects:@"AB +ve",@"AB -ve",@"A +ve",@"A -ve",@"B +ve",@"B -ve",@"O +ve",@"O -ve", nil];
    
    
    self.bloodTypeListDictionay = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AB+",@"AB +ve",@"AB-",@"AB -ve",@"A+",@"A +ve",@"A-",@"A -ve",@"B+",@"B +ve",@"B-",@"B -ve",@"O+",@"O +ve",@"O-",@"O -ve",nil];
    [self.srchBloodTypeList setHidden:YES];
//    self.srchBloodTypeList.layer.borderWidth = 2;
//    self.srchBloodTypeList.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.dropDownBtn.layer.borderWidth = 1;
    self.dropDownBtn.layer.cornerRadius = 5;
    self.dropDownBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.srchBloodTypeList.layer.borderWidth = 1;
    self.srchBloodTypeList.layer.cornerRadius = 5;
    self.srchBloodTypeList.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.sendNotificationButton.layer.borderWidth = 1;
    self.sendNotificationButton.layer.cornerRadius = 5;
    self.sendNotificationButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    

    checkboxSelected = 0;
    UIBarButtonItem *myItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = myItem;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
    // 20 385 280 49
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.tapTextFieldView addGestureRecognizer:singleFingerTap];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Notify"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
-(void)viewWillAppear:(BOOL)animated{
    
   // self.selectedBloodType.titleLabel.text = @"Select Blood Group";
    self.selectedBloodType.placeholder = @"Select blood group";

    isAnimating = NO;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    [self dropDownClicked:self.dropDownBtn];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.phoneNumber resignFirstResponder];
    
}
- (IBAction)backAction:(id)sender {
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)dropDownClicked:(id)sender{
    
    
   // self.selectedBloodType.titleLabel.text = @"Select Blood Group";
    
    if (self.srchBloodTypeList.isHidden){
        if(!isAnimating){
            // CGRect basketBottomFrame =  self.regBloodTypeList.frame;
            CGRect basketBottomFrame =  CGRectMake(self.srchBloodTypeList.frame.origin.x, self.srchBloodTypeList.frame.origin.y, self.srchBloodTypeList.frame.size.width, 0);
            // basketBottomFrame.size.height;
            // basketBottomFrame.origin.y = 300;
            self.srchBloodTypeList.frame = basketBottomFrame;
            
            [self.srchBloodTypeList setHidden:NO];
            
            
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 // other animations here
                                 int ht   =  basketBottomFrame.size.height + 100;
                                 isAnimating =YES;
                                 
                                 CGRect basketBottomFrame =  CGRectMake(self.srchBloodTypeList.frame.origin.x, self.srchBloodTypeList.frame.origin.y, self.srchBloodTypeList.frame.size.width, ht);
                                 
                                 self.srchBloodTypeList.frame = basketBottomFrame;
                                 
                                 
                             }
                             completion:^(BOOL finished){
                                 // ... completion stuff
                                 // self.regBloodTypeList.frame = basketBottomFrame;
                                 //[self.regBloodTypeList setHidden:NO];
                                 isAnimating =NO;
                                 
                             }
             ];
            
        }else{}
        
    }
    else{
        
        if(!isAnimating){
            CGRect basketBottomFrame = self.srchBloodTypeList.frame;
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 // other animations here
                                 int ht   =  basketBottomFrame.size.height - 100;
                                 isAnimating =YES;
                                 
                                 CGRect basketBottomFrame =  CGRectMake(self.srchBloodTypeList.frame.origin.x, self.srchBloodTypeList.frame.origin.y, self.srchBloodTypeList.frame.size.width, ht);
                                 
                                 self.srchBloodTypeList.frame = basketBottomFrame;
                                 
                                 
                             }
                             completion:^(BOOL finished){
                                 // ... completion stuff
                                 [self.srchBloodTypeList setHidden:YES];
                               //  self.selectedBloodType.titleLabel.text = @"Select Blood Group";
                                 isAnimating =NO;
                                 
                                 
                             }
             ];
            
            
            
        }else{}
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.bloodTypeListArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *title = [[UILabel alloc]init];
        title.frame = CGRectMake(110, 3, 300, 30);
        
        [title setFont:[UIFont boldSystemFontOfSize:15]];
        title.numberOfLines = 0;
        
        title.lineBreakMode = YES;
        title.text = [self.bloodTypeListArray objectAtIndex:indexPath.row];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor blackColor];
        title.tag = kTitleTag;
        
        [cell.contentView addSubview:title];
    }else
    {
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:kTitleTag];
        title.text = [self.bloodTypeListArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
  //  [cell setBackgroundColor:[UIColor colorWithRed:209.0/255.0f green:80./255.0f blue:29.0/255.0f alpha:1.0f]];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectGrp = [NSString stringWithFormat:@"%@",[self.bloodTypeListArray objectAtIndex:indexPath.row]];
    
    
    self.selectedBloodType.text = selectGrp;
    
    if (self.srchBloodTypeList.isHidden)
        [self.srchBloodTypeList setHidden:NO];
    else
        [self.srchBloodTypeList setHidden:YES];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    
    NSCharacterSet *numSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int charCount = [newString length];
    
    
    if ([newString rangeOfCharacterFromSet:[numSet invertedSet]].location != NSNotFound||  charCount > 12) {
        return NO;
    }
    
    
    textField.text = newString;
    
    return NO;
    
    
}

//
//- (IBAction)checkboxButton:(id)sender{
//	if (checkboxSelected == 0){
//		[self.checkboxButton setSelected:YES];
//		checkboxSelected = 1;
//        
//      //  [self.checkboxButton setImage:[UIImage imageNamed:                        @"checkbox.png"] forState:UIControlStateNormal];
//        
//	} else {
//		[self.checkboxButton setSelected:NO];
//		checkboxSelected = 0;
//       // self.checkboxButton = 0;
//        //[self.checkboxButton setImage:[UIImage imageNamed:                        @"checkbox-checked.png"] forState:UIControlStateNormal];
//	}
//}

//-(IBAction)checkboxButton:(id)sender{
//    if(self.isChecked ==NO){
//        self.isChecked =YES;
//        [self.checkboxButton setImage:[UIImage imageNamed:                        @"checkbox.png"] forState:UIControlStateNormal];
//    }else{
//        self.isChecked =NO;
//       [self.checkboxButton setImage:[UIImage imageNamed:                        @"checkbox-checked.png"] forState:UIControlStateNormal];
//    }
//}
//

-(IBAction)sendNotification:(id)sender {
    
    [self logButtonPress:(UIButton *)sender];
    UIAlertView *alert;
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"Location Services Enabled");
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                               message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
    }else{
    NSString *msg = [NSString stringWithFormat:@"Do you want to send notification around you ?"];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: @"Notify .."
                              message:msg
                              delegate: self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Yes",nil];
    [alertView show];
    }
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Pressed");
    }
    else  if (buttonIndex==1){
        
        
       // NSString *bldType = [self.selectedBloodType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *bldType = self.selectedBloodType.text;
        NSString *bloodTyp = [self.bloodTypeListDictionay objectForKey:bldType];

        if ([self.phoneNumber.text length]!=0 && [bloodTyp length]!=0) {
            
            // NSString* bldType = self.selectedBloodType.titleLabel.text;
            
            if ([bloodTyp isEqualToString:@"AB+"]) {
                bloodTyp=@"AB";
                
            }else if ([bloodTyp isEqualToString:@"A+"]) {
                bloodTyp=@"A";
                
            }else if ([bloodTyp isEqualToString:@"B+"]) {
                bloodTyp=@"B";
            }else if ([bloodTyp isEqualToString:@"O+"]) {
                bloodTyp=@"O";
                
            }
            
            BLDLineAppDelegate *appDelegate = (BLDLineAppDelegate*)[[UIApplication sharedApplication] delegate];
            
            // Get the stored data before the view loads
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *device_ID = [defaults objectForKey:@"DeviceToken"];
            NSString *latitude = [NSString stringWithFormat:@"%f", [appDelegate.currentLocation coordinate].latitude];
            NSString *longitude = [NSString stringWithFormat:@"%f", [appDelegate.currentLocation coordinate].longitude];
            NSString *urlString = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/notification"];
            NSString *phone = self.phoneNumber.text;
            NSString *priority =  @"1";//[self.prioritySwitch isOn] ? @"1" : @"3";
            // priority = if()prioritySwitch
              // [self.prioritySwitch isOn] ? @"YES" : @"NO"
            
            
            NSLog(@"Notification  URl-> %@",urlString);
            
            
            NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:urlString,@"url", phone,@"phone",bloodTyp,@"bg",longitude,@"lon",latitude,@"lat",device_ID,@"device_id", priority,@"priority",nil];
            [[BLDLineUrlInvoker sharedInstance] postNotificationRequest:param andProcessName:@selector(processNotification:)  requestMethod:@"POST" withObject:self];
            
            
        }
        
        
    }
}




-(void)processNotification:(NSData*)responsedata{
    
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
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Notification.."
                                                      message:[dictionary objectForKey:@"status"]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
    
    
}

@end

