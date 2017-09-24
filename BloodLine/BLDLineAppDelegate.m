//
//  BLDLineAppDelegate.m
//  BloodLine
//
//  Created by Avinash Kawade on 01/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "BLDLineUrlInvoker.h"
#import "RFRateMe.h"

@implementation BLDLineAppDelegate

@synthesize searchBloodType,currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    //Google Analytis
    // 1
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // 2
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    // 3
    [GAI sharedInstance].dispatchInterval = 20;
    
    // 4
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-49602822-1"];
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [tracker set:kGAIAppVersion value:version];
    [tracker set:kGAISampleRate value:@"50.0"];
    
    [self promotUserforGoogleAnalysticsMessage];
    
    
    // Override point for customization after application launch.
    
  //  [FBLoginView class];
    
    self.locations = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    //[self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringSignificantLocationChanges];
    
    NSDictionary *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(remoteNotif)
    {
        //Handle remote notification
        NSString *alert = [[remoteNotif objectForKey:@"aps"] objectForKey:@"alert"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BloodLine"
                                                          message:alert
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }
    NSLog(@"Registering for push notifications...");

    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
//    
//   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////  Me  [defaults setObject:@"53138c763ff4ea00001df765" forKey:@"UserID"];
//  //Vinay
//    [defaults setObject:@"53138bbf3ff4ea00001df763" forKey:@"UserID"];   
//   [defaults synchronize];
//
    
    return YES;
}


-(void)promotUserforGoogleAnalysticsMessage{


    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"firstLaunch"]) {
        //this key has never been set - this is the first launch
        [defaults setBool:YES forKey:@"firstLaunch"];
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Google Analytics" message:@"With your permission usage information will be collected to improve the application." delegate:self cancelButtonTitle:@"Opt Out" otherButtonTitles:@"Opt In", nil];
        [av show];
        
     
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[GAI sharedInstance] setOptOut:YES];
            break;
        case 1:
            [[GAI sharedInstance] setOptOut:NO];
            break;
            
        default:
            break;
    }
}
-(void)updateCordinate:(CLLocation *)newLocation{
    
    //    _bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:
    //               ^{
    //                   [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
    //               }];
    
    // UIBackgroundTaskIdentifier
    bgTask = UIBackgroundTaskInvalid;
    bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler:^{
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
              }];
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"UserID"];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", [newLocation coordinate].latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", [newLocation coordinate].longitude];
    NSString *url = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/donor?user_id=%@&lon=%@&lat=%@",userID,longitude,latitude];
    NSLog(@"Update URl-> %@",url);
    
    [[BLDLineUrlInvoker sharedInstance] initWithURL:url andProcessName:@selector(processUpdateLocation:)  requestMethod:@"PUT" withObject:self];
    
    
    
    
}

-(void)processUpdateLocation:(NSData*)responsedata{
    
    NSError *error;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responsedata options:kNilOptions error:&error];
    
    
    
    NSString* newStr = [[NSString alloc] initWithData:responsedata
                                             encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"Response - >%@",newStr);
    
    
    if (bgTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }
    
    
}

/*
 - (void)locationManager:(CLLocationManager *)manager
 didUpdateToLocation:(CLLocation *)newLocation
 fromLocation:(CLLocation *)oldLocation
 {
 currentLocation = newLocation;
 if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
 {
 //  [self.locationManager stopUpdatingLocation];
 }
 else
 {
 NSLog(@"App is backgrounded. New location is %@", newLocation);
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 NSString *userID = [defaults objectForKey:@"UserID"];
 if ([userID length]!=0) {
 [self updateCordinate:newLocation];
 
 }
 }
 // NSLog(@"App is backgrounded. New location is %@", newLocation);
 }
 */

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //
    //    cnt++;
    //    NSDate *alertTime = [NSDate dateWithTimeIntervalSinceNow:10];
    //    UIApplication* app = [UIApplication sharedApplication];
    //    UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
    //                                        init];
    //    if (notifyAlarm)
    //    {
    //        notifyAlarm.fireDate = alertTime;
    //        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    //        notifyAlarm.repeatInterval = 0;
    //        notifyAlarm.soundName = UILocalNotificationDefaultSoundName;
    //
    //        notifyAlarm.alertBody = [NSString
    //                                 stringWithFormat:@"Location changed to new now - %i",cnt];
    //        [app scheduleLocalNotification:notifyAlarm];
    //    }
    
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    } else {
        oldLocation = nil;
    }
    NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
    
    currentLocation = newLocation;
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userID = [defaults objectForKey:@"UserID"];
        if ([userID length]!=0) {
           // [self updateCordinate:newLocation];
            
        }
        
        [self.locationManager stopUpdatingLocation];
    }
    else
    {
        NSLog(@"App is backgrounded. New location is %@", newLocation);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userID = [defaults objectForKey:@"UserID"];
        if ([userID length]!=0) {
            [self updateCordinate:newLocation];
            
        }
    }
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];

}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [NSString
                       stringWithFormat:@"%@",deviceToken];
    NSLog(@"Device Token-->%@",token);
    
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"DeviceToken"];
    [defaults synchronize];
    // NSLog(@"Device Token ->%@",token);
    
    
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(str);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSString *phone = [[userInfo objectForKey:@"aps"] objectForKey:@"Phone"];
    
    
    NSString *alertMsg = [NSString
                          stringWithFormat:@"%@-- %@",alert,phone];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BloodLine"
                                                      message:alertMsg
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
#if !TARGET_IPHONE_SIMULATOR
    NSString *badge = [userInfo objectForKey:@"badge"];
    NSLog(@"Received Push Badge: %@", badge);
    
    // set it to Zero will clear it.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
#endif
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.locationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // set it to Zero will clear it.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //[self.locationManager stopMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
