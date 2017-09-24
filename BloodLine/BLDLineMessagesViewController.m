//
//  BLDLineMessagesViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineMessagesViewController.h"
#import "BLDLineUrlInvoker.h"
#import "GAIDictionaryBuilder.h"

#define kTitleTag 1000
#define kImageTag 1001
#define kPhoneCallTag 1002
#define kDateTag 1003


@interface BLDLineMessagesViewController ()

@end

@implementation BLDLineMessagesViewController

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
    self.screenName = @"Messages";
    
	// Do any additional setup after loading the view.
    //    self.notificationsListArray  = [[NSMutableArray alloc]initWithObjects:@"This is Avinash fancy message.xxxxxxxxxx knakfsaksfmaf ",@"This is Avinash fancy message.",@"This is Avinash fancy message.",@"This is Avinash fancy message.",@"This is Avinash fancy message.",@"This is Avinash fancy message.",
    //                                    @"This is Avinash fancy message.",@"This is Avinash fancy message.", nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Messages"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.notificationsList.frame = self.view.frame;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"UserID"];
    if ([userID length]!=0) {
        
        NSString *url = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/notifications?user_id=%@",userID];
        
        [[BLDLineUrlInvoker sharedInstance] initWithURL:url andProcessName:@selector(processgetnotifications:)  requestMethod:@"GET" withObject:self];
        
        
    }
    
    
}

-(void)processgetnotifications:(NSData*)responsedata{
    
    NSError *error;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responsedata options:kNilOptions error:&error];
    NSArray *array = [dictionary objectForKey:@"model"];
    self.notificationsListArray  = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:FALSE];
    [self.notificationsListArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [self.notificationsList reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.notificationsListArray.count ;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //"Blood group [A+] needed. Call (977556778) for further details.
    NSDictionary *tempDict = [self.notificationsListArray objectAtIndex:indexPath.row];
    NSString *str =  [tempDict objectForKey:@"message"];
    NSString *datestr =  [tempDict objectForKey:@"created_at"];
    NSRange searchFromRange = [str rangeOfString:@"["];
    NSRange searchToRange   = [str rangeOfString:@"]"];
    // NSString *shortString = [str substringWithRange:NSMakeRange(start.length, end.location)];
    NSString *shortString = [str substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    //
    NSString *trimmedText = [shortString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSRange start1 = [str rangeOfString:@"("];
    NSRange end1   = [str rangeOfString:@")"];

    NSString *shortString1 = [str substringWithRange:NSMakeRange(start1.location+start1.length, end1.location-start1.location-start1.length)];
    //
    NSString *trimmedText1 = [shortString1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        if (indexPath.row==3) {
//            return cell ;
//        }
      
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[self bloodgroupImage:trimmedText]];
        imgView.frame = CGRectMake(20, 10, 30, 30);
        imgView.tag = kImageTag;
        [cell.contentView addSubview:imgView];
        
        
        
        UILabel *title = [[UILabel alloc]init];
        title.frame = CGRectMake(60, 3, 200, 50);
        
        [title setFont:[UIFont boldSystemFontOfSize:15]];
        title.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:12];
        if ([tempDict objectForKey:@"read"]) {
        title.textColor = [UIColor colorWithRed:168.0/255.0f green:35./255.0f blue:47.0/255.0f alpha:0.5f];
        }else
        title.textColor = [UIColor colorWithRed:168.0/255.0f green:35./255.0f blue:47.0/255.0f alpha:1.0f];
        title.lineBreakMode = YES;
        title.text = str;
        
        title.backgroundColor = [UIColor clearColor];
        title.tag = kTitleTag;
        
        [cell.contentView addSubview:title];
        
        
        UILabel *dateLbl = [[UILabel alloc]init];
        dateLbl.frame = CGRectMake(195, 42, 200, 15);
        
        [dateLbl setFont:[UIFont boldSystemFontOfSize:15]];
        dateLbl.numberOfLines = 1;
        dateLbl.font = [UIFont systemFontOfSize:12];
        dateLbl.textColor = [UIColor lightGrayColor];
        dateLbl.lineBreakMode = YES;
        dateLbl.text = [self convert:datestr];
        
        dateLbl.backgroundColor = [UIColor clearColor];
        dateLbl.tag = kTitleTag;
        
        [cell.contentView addSubview:dateLbl];

        
        UIButton *PhnCall = [[UIButton alloc]init];
        PhnCall.frame = CGRectMake(280, 6, 32, 32);
        [PhnCall setBackgroundImage:[UIImage imageNamed:@"PhonCall.png"] forState:UIControlStateNormal];
        PhnCall.tag = kPhoneCallTag;
        
        
        PhnCall.titleLabel.text = trimmedText1;//[NSString stringWithFormat:trimmedText1];//[NSString stringWithFormat:@"%i",indexPath.row];
        [PhnCall addTarget:self
                    action:@selector(makephoneCall:)
          forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:PhnCall];
        
        
        
        
        
        
    }else
    {
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:kTitleTag];
        if ([tempDict objectForKey:@"read"]) {
            title.textColor = [UIColor colorWithRed:168.0/255.0f green:35./255.0f blue:47.0/255.0f alpha:0.5f];
        }else
            title.textColor = [UIColor colorWithRed:168.0/255.0f green:35./255.0f blue:47.0/255.0f alpha:1.0f];

        NSDictionary *tempDict = [self.notificationsListArray objectAtIndex:indexPath.row];
        NSString *str =  [tempDict objectForKey:@"message"];
        title.text = str;
        UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:kImageTag];
        imgView.image = [self bloodgroupImage:trimmedText];
        UIButton *phn = (UIButton *)[cell.contentView viewWithTag:kPhoneCallTag];
        phn.titleLabel.text = trimmedText1;
        UILabel *dateLbl = (UILabel *)[cell.contentView viewWithTag:kDateTag];
        dateLbl.text = [self convert:datestr];//date.text =
        

    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSString *)convert:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
     // NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ" options:0 locale:[NSLocale currentLocale]];
    //[dateFormatter setDateFormat:strdate];
//"2015-07-07T03:47:57.518Z",
     NSDate   *aDate = [dateFormatter dateFromString:strdate];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"EEEE, dd MMM HH:mm"];
    NSString * depResult = [df stringFromDate:aDate];
    
    NSLog(@"hours  %@ ", [df stringFromDate:depResult]);
    
    return depResult;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;


}

-(UIImage*)bloodgroupImage:(NSString *)bloodGrp{
    
    UIImage *image;
    if ([bloodGrp isEqualToString:@"AB+"]) {
        image= [UIImage imageNamed:@"blooddropAB+.png"];
    }else if ([bloodGrp isEqualToString:@"AB-"]) {
        image = [UIImage imageNamed:@"blooddropAB-.png"];
    }else if ([bloodGrp isEqualToString:@"AB-"]) {
        image = [UIImage imageNamed:@"blooddropAB-.png"];
        
    }else if ([bloodGrp isEqualToString:@"A+"]) {
        image = [UIImage imageNamed:@"blooddropA+.png"];
        
    }else if ([bloodGrp isEqualToString:@"A-"]) {
        image = [UIImage imageNamed:@"blooddropA-.png"];
        
    }else if ([bloodGrp isEqualToString:@"B-"]) {
        image = [UIImage imageNamed:@"blooddropB-.png"];
        
    }else if ([bloodGrp isEqualToString:@"B+"]) {
        image = [UIImage imageNamed:@"blooddropB+.png"];
    }else if ([bloodGrp isEqualToString:@"O+"]) {
        image = [UIImage imageNamed:@"blooddropO+.png"];
        
    }else if ([bloodGrp isEqualToString:@"O-"]) {
        image = [UIImage imageNamed:@"blooddropO-.png"];
    }
    
    return image;
    
}
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//    return YES;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(void)makephoneCall:(id)sender{
    
    UIButton*btn = (UIButton*)sender;
    
    NSString *trimmedText = [btn.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSString *phoneNumber = [NSString stringWithFormat:@"telprompt://%@",trimmedText];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    //    NSString *msg = [NSString stringWithFormat:@"Do you want to make a phone call to provided number # %@",btn.titleLabel.text];
    //    UIAlertView *alertView = [[UIAlertView alloc]
    //                              initWithTitle: @"Call.."
    //                              message:msg
    //                              delegate: self
    //                              cancelButtonTitle:@"Cancel"
    //                              otherButtonTitles:@"Call",nil];
    //    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Pressed");
    }
    else  if (buttonIndex==1){
        NSLog(@"Call Pressed");
        NSArray*temp = [alertView.message componentsSeparatedByString:@"#"];
        NSString*num = [temp objectAtIndex:1];
        NSString *trimmedText = [num stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        NSString *phoneNumber = [NSString stringWithFormat:@"telprompt://%@",trimmedText]; //[@"telprompt://" stringByAppendingString:[temp objectAtIndex:1]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
