//
//  BLDLineMapViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 18/01/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface BLDLineMapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate>{

    CLLocationManager *locationManager;
    IBOutlet MKMapView *mapView;
    NSMutableArray *nearbyBloodGpListl;
    NSString* selectedBloodType;
    CLLocation *currentLocation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *mapSegment;

@property (nonatomic,retain)  NSMutableArray *nearbyBloodGpListl;
@property(nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic,retain) NSString* selectedBloodType;


- (IBAction)mapTypeChanged:(id)sender;


@end
