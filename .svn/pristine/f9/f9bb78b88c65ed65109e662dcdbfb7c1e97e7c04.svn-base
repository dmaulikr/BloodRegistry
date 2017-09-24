//
//  BLDLineSearchNearbyViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//
#import "GAIDictionaryBuilder.h"
#import "BLDLineSearchNearbyViewController.h"
//#import "BLDLineMapViewController.h"
#import  "QuartzCore/QuartzCore.h"
#import "BLDLineAppDelegate.h"

#define kTitleTag 1000
@interface BLDLineSearchNearbyViewController (){
BOOL isAnimating;
}
@end

@implementation BLDLineSearchNearbyViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setHidden:YES];
    self.screenName = @"SearchNearby";
    
   // 20 385 280 49
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.tapTextFieldView addGestureRecognizer:singleFingerTap];
    
    self.searchButton =  [UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc]initWithFrame:CGRectMake(20, 385, 280, 49)];
    
    if(isiPhone5)
    self.searchButton.frame = CGRectMake(20, 353, 280, 49);
    else if (IS_IPHONE4) {
        self.searchButton.frame = CGRectMake(20, 303, 280, 49);
    }
    else
    self.searchButton.frame = CGRectMake(20, 320, 280, 49);

    [self.searchButton setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
    //self.searchButton.titleLabel.text = @"Search Nearby..";
    self.searchButton.titleLabel.font = [UIFont fontWithName:@"system" size:15.0];
    [self.searchButton setTitle:@"Search nearby ..."
             forState:(UIControlState)UIControlStateNormal];
    self.searchButton.titleLabel.textColor = [UIColor whiteColor];
    [self.searchButton addTarget:self
                action:@selector(searchBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchButton];

    

    // [self.navigationController.navigationBar setHidden:YES];
    self.bloodTypeListArray  = [[NSMutableArray alloc]initWithObjects:@"AB +ve",@"AB -ve",@"A +ve",@"A -ve",@"B +ve",@"B -ve",@"O +ve",@"O -ve",nil];
    
    
    self.bloodTypeListDictionay = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AB+",@"AB +ve",@"AB-",@"AB -ve",@"A+",@"A +ve",@"A-",@"A -ve",@"B+",@"B +ve",@"B-",@"B -ve",@"O+",@"O +ve",@"O-",@"O -ve",nil];

    [self.srchBloodTypeList setHidden:YES];
    self.srchBloodTypeList.layer.borderWidth = 1;
    self.srchBloodTypeList.layer.cornerRadius = 5;
    self.srchBloodTypeList.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
  
    self.dropDownBtn.layer.borderWidth = 1;
    self.dropDownBtn.layer.cornerRadius = 5;
    self.dropDownBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    
    
    self.searchButton.layer.borderWidth = 1;
    self.searchButton.layer.cornerRadius = 5;
    self.searchButton.layer.borderColor = [[UIColor whiteColor] CGColor];

    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"UserID"];
    
      if ([userID length]==0||userID == nil) {
        
        [self returnAfterLogin];
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SearchNearby"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    isAnimating = NO;
    self.selectedBloodType.placeholder = @"Select blood group";
//    if (!self.isChartVisible)
//        self.isChartVisible=NO;
   // self.selectedBloodType.titleLabel.text = @"Select Blood Group";
    [self.navigationController.navigationBar setHidden:YES];
    //    self.CharView.layer.shadowOffset = CGSizeMake(15, 10);
    //    self.CharView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    
//    if(!isiPhone5){
//        
//        //  self.registerButton.frame = CGRectMake(self.registerButton.frame.origin.x, self.view.frame.size.height-100, self.registerButton.frame.size.width, self.registerButton.frame.size.height);
//        self.searchButton.frame = CGRectMake(232, self.view.frame.size.height-100,68, 23);
//    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
        [self dropDownClicked:self.dropDownBtn];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}
-(void)logButtonPress:(UIButton *)button{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"SearchNearby"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}
-(void)returnAfterLogin{
    //do something
    
//    
//    BLDLineRegisterViewController *registerVC = (BLDLineRegisterViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"BLDLineRegistercontoller"];
//    [self presentViewController:registerVC animated:YES completion:nil];
//    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"returnAfterLogin" object:nil];
}


-(IBAction)dropDownClicked:(id)sender{
    
    
    if (self.srchBloodTypeList.isHidden){
        [self.view bringSubviewToFront:self.srchBloodTypeList];
        if(!isAnimating){
            CGRect basketBottomFrame =  CGRectMake(self.srchBloodTypeList.frame.origin.x, self.srchBloodTypeList.frame.origin.y, self.srchBloodTypeList.frame.size.width, 0);
            
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
                                 isAnimating = NO;
                                 
                                 
                             }
             ];
            
        }else{
        }
        
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
                                 
                                 CGRect basketBottomFrame =  CGRectMake(self.srchBloodTypeList.frame.origin.x, self.srchBloodTypeList.frame.origin.y, self.srchBloodTypeList.frame.size.width, ht);
                                 isAnimating = YES;
                                 self.srchBloodTypeList.frame = basketBottomFrame;
                                 
                                 
                             }
                             completion:^(BOOL finished){
                                 // ... completion stuff
                                 [self.srchBloodTypeList setHidden:YES];
                                // self.selectedBloodType.titleLabel.text = @"Select Blood Group";
                                 isAnimating = NO;
                                 
                             }
             ];
            
        }else{
            
        }
    }
    
    
}



//------------------------------------

-(IBAction)searchBtnClicked:(id)sender{
    
    [self logButtonPress:(UIButton *)sender];

    
    BLDLineAppDelegate *appDelegate = (BLDLineAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //NSString *blTyp = [self.selectedBloodType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *blTyp = self.selectedBloodType.text;
    NSString *bloodTyp = [self.bloodTypeListDictionay objectForKey:blTyp];

    if ([self.bloodTypeListDictionay objectForKey:blTyp]) {
        
        appDelegate.searchBloodType  = bloodTyp;
        
        UIViewController*mapVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
        [self.navigationController pushViewController:mapVC animated:YES];

        
    }else{
        
        appDelegate.searchBloodType  = nil;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@"Please select blood group."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
      
        
    }

  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MapViewControllerSegue"]){
        UIViewController *navController = (UIViewController *)segue.destinationViewController;
//        BLDLineMapViewController *controller = (BLDLineMapViewController *)navController.selectedViewController;
//        controller.selectedBloodType = self.selectedBloodType.text;
        navController.view.frame =  CGRectMake(navController.view.frame.origin.x, navController.view.frame.origin.y, 320, 400);

    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    BLDLineAppDelegate *appDelegate = (BLDLineAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *blTyp = [self.selectedBloodType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *bloodTyp = [self.bloodTypeListDictionay objectForKey:blTyp];

    
    if ([self.bloodTypeListArray containsObject:bloodTyp]) {
        
        appDelegate.searchBloodType  = bloodTyp;
        
        return YES;
        
    }else{
        
        appDelegate.searchBloodType  = nil;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@"Please Select blood group.."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
        return NO;
        
    }
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
        title.textColor = [UIColor blackColor];
        title.lineBreakMode = YES;
        title.text = [self.bloodTypeListArray objectAtIndex:indexPath.row];
        title.backgroundColor = [UIColor clearColor];
        title.tag = kTitleTag;
        
        [cell.contentView addSubview:title];
    }else
    {
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:kTitleTag];
        title.text = [self.bloodTypeListArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
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

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    
    //[cell setBackgroundColor:[UIColor colorWithRed:209.0/255.0f green:80./255.0f blue:29.0/255.0f alpha:1.0f]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}
@end
