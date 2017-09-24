//
//  BLDLineAppDelegate.h
//  BloodLine
//
//  Created by Avinash Kawade on 01/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface BLDLineAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{

UIBackgroundTaskIdentifier bgTask ;
NSString *searchBloodType;
CLLocation *currentLocation;
}@property (nonatomic, strong) CLLocationManager *locationManager;



@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, retain) NSString *searchBloodType;
@property (nonatomic, retain) CLLocation *currentLocation;

-(void)updateCordinate:(CLLocation *)newLocation;



@end
