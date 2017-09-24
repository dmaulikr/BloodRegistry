 //
//  BLDLineMapViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 18/01/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineMapViewController.h"
#import "Annotation.h"
#import "BLDLineUrlInvoker.h"
#import "BLDLineAppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface BLDLineMapViewController ()

@end

@implementation BLDLineMapViewController


@synthesize mapView,locationManager,nearbyBloodGpListl,selectedBloodType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        [self.mapView setDelegate:self];
//       
//        self.locationManager = [[CLLocationManager alloc] init];
//        	    [locationManager setDelegate:self];
//        
//        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
//        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//       
//       [self.mapView setShowsUserLocation:YES];
       //[self.mapView setMapType:MKMapTypeHybrid];
        
      
    }
    return self;
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
	{
//    	    MKAnnotationView *annotationView = [views objectAtIndex:0];
//    	    id<MKAnnotation> mp = [annotationView annotation];
//    	    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate] ,250,250);
//    
//    	    [mv setRegion:region animated:YES];
//        
      
    }

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
   // MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance([userLocation coordinate], 1000, 1000);
   // [self.mapView setRegion:region];
  
//   // nearbyBloodGpListl
//    CLLocationCoordinate2D userCoordinate = userLocation.location.coordinate;
//       for(int i = 1; i<=5;i++)
//        {
//                 CGFloat latDelta = rand()*.035/RAND_MAX -.02;
//                   CGFloat longDelta = rand()*.03/RAND_MAX -.015;
//           
//         	        CLLocationCoordinate2D newCoord = { userCoordinate.latitude + latDelta, userCoordinate.longitude + longDelta };
////                BLDLineMapPoint *mp = [[BLDLineMapPoint alloc] initWithCoordinate:newCoord title:[NSString stringWithFormat:@" Home %d",i] subTitle:@"Home Sweet Home"];
//            Annotation *ann = [[Annotation alloc]initWithLocation:newCoord];
//            ann.title = @"AB +";
//            ann.subtitle = @"";
//            ann.bloodGrp =  @"AB+";
//
//        	   [self.mapView addAnnotation:ann];
//      	       [self.mapView selectAnnotation:ann animated:YES];
//            	         
//        }
  	
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
//    if([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    //7
//    static NSString *identifier = @"myAnnotation";
//    MKAnnotationView * annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (!annotationView)
//    {
//        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        //10
//        annotationView.image = [UIImage imageNamed:@"dropdownArrow.png"];
//        annotationView.enabled = YES;
//    }else {
//        annotationView.annotation = annotation;
//    }
//    return annotationView;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation
	{
        if([annotation isKindOfClass:[MKUserLocation class]])
       	    return nil;
    
       NSString *annotationIdentifier = @"PinViewAnnotation";
   
   	    MKAnnotationView *pinView = (MKAnnotationView *) [self.mapView
                                                                   	                                                            dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
   
   	    if (!pinView)
            {
           	        pinView = [[MKAnnotationView alloc]
                                                       initWithAnnotation:annotation
                                                       reuseIdentifier:annotationIdentifier];
            
            	        //[pinView setPinColor:MKPinAnnotationColorGreen];
            	       // pinView.animatesDrop = YES;
                        pinView.canShowCallout = YES;
                Annotation *pin = (Annotation*)annotation;
                if ([pin.bloodGrp isEqualToString:@"AB"]) {
                       pinView.image = [UIImage imageNamed:@"blooddropAB+.png"];
                }else if ([pin.bloodGrp isEqualToString:@"AB-"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropAB-.png"];
                }else if ([pin.bloodGrp isEqualToString:@"AB-"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropAB-.png"];

                }else if ([pin.bloodGrp isEqualToString:@"A"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropA+.png"];

                }else if ([pin.bloodGrp isEqualToString:@"A-"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropA-.png"];

                }else if ([pin.bloodGrp isEqualToString:@"B-"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropB-.png"];

                }else if ([pin.bloodGrp isEqualToString:@"B"]) {
                    pinView.image = [UIImage imageNamed:@"blooddropB+.png"];
                }else if ([pin.bloodGrp isEqualToString:@"O"]) {
                        pinView.image = [UIImage imageNamed:@"blooddropO+.png"];

                }else if ([pin.bloodGrp isEqualToString:@"O-"]) {
                            pinView.image = [UIImage imageNamed:@"blooddropO-.png"];
                }

                 //   UIImageView *pinimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blooddropAB+.png"]];

                   // [pinView addSubview:pinimg];
               // }
                     
                
                UIImageView *IconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bloodbag.png"]];
                	        [IconView setFrame:CGRectMake(0, 0, 30, 30)];
                	        pinView.leftCalloutAccessoryView = IconView;
            	    }
    	    else
       	    {
            	        pinView.annotation = annotation;
            }
     
    	    return pinView;
   	 
   }

-(void)mapView:(MKMapView *)map annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    printf("yes tapped!");
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
//        CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"calloutView" owner:self options:nil] objectAtIndex:0];
//        CGRect calloutViewFrame = calloutView.frame;
//        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
//        calloutView.frame = calloutViewFrame;
//        [calloutView.calloutLabel setText:[(myAnnotation*)[view annotation] title]];
//        [view addSubview:calloutView];
    }
    
}


/*
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation
{
       if([annotation isKindOfClass:[MKUserLocation class]])
            return nil;
    
   	    NSString *annotationIdentifier = @"PinViewAnnotation";
    
   	    BLDLineMapPinBloodType *pinView = (BLDLineMapPinBloodType *) [self.mapView
                                                                 	                                                            dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
   
       if (!pinView)
        	    {
            	        pinView = [[BLDLineMapPinBloodType alloc]
                                   	                    initWithAnnotation:annotation
                                    	                    reuseIdentifier:annotationIdentifier];
           
            	//[pinView setPinColor:MKPinAnnotationColorGreen];
            	       // pinView.animatesDrop = YES;
            	        pinView.canShowCallout = YES;
            
            	        UIImageView *houseIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"house.png"]];
            	        [houseIconView setFrame:CGRectMake(0, 0, 30, 30)];
           	        pinView.leftCalloutAccessoryView = houseIconView;
           	             
            	    }
    	    else
        	    {
           	        pinView.annotation = annotation;
            	    }
   	 
    	    return pinView;
    	 
    	}
*/

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{


    currentLocation=newLocation;

}

-(void) viewDidLayoutSubviews
{
   }
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
#ifdef IS_OS_8_OR_LATER
    NSUInteger code = [CLLocationManager authorizationStatus];
    if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        // choose one request according to your business.
        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
            [self.locationManager requestAlwaysAuthorization];
        } else if([[NSBundle mainBundle]objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [self.locationManager  requestWhenInUseAuthorization];
        } else {
            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
        }
    }
#endif
    [self.locationManager startUpdatingLocation];

    NSString *version = [[UIDevice currentDevice] systemVersion];
    int ver = [version intValue];
    if (ver < 7){
        //iOS 6 work
    }
    else{
        //iOS 7 related work
        CGRect tmpFram = self.navigationController.navigationBar.frame;
       // tmpFram.origin.y +=10;
        self.navigationController.navigationBar.frame = CGRectMake(tmpFram.origin.x, 30, tmpFram.size.width, tmpFram.size.height);
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.translucent=NO;
    //self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, 400);

//    UIBarButtonItem *myItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
//    self.navigationItem.leftBarButtonItem = myItem;
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];//[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
    
}

- (void)viewWillAppear:(BOOL)animated{

    // Do any additional setup after loading the view.
    [self.mapView setDelegate:self];
    
    
    [self.mapView setShowsUserLocation:YES];
    //[self.locationManager startUpdatingLocation];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];

    [self.mapSegment setTintColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];//[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.locationManager stopUpdatingHeading];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    
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
    // -(void)initWithURL:(NSString*)url andProcessName:(SEL)process  withObject:(id)obj{
    //[[BLDLineUrlInvoker sharedInstance] initWithURL:@"http://qbs-instahack.rhcloud.com/donors?bg=A+&lon=51&lat=-114&limit=4" andProcessName:@selector(processgetnearbygroups:) withObject:self];
        
        [self performSelector:@selector(performSearch) withObject:nil afterDelay:1.0];
  
    }
}
-(void)performSearch{


    BLDLineAppDelegate *appDelegate = (BLDLineAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.selectedBloodType = appDelegate.searchBloodType;
    
    
    
    NSString* bldType = self.selectedBloodType;
    
    if ([bldType isEqualToString:@"AB+"]) {
        bldType=@"AB";
        
    }else if ([bldType isEqualToString:@"A+"]) {
        bldType=@"A";
        
    }else if ([bldType isEqualToString:@"B+"]) {
        bldType=@"B";
    }else if ([bldType isEqualToString:@"O+"]) {
        bldType=@"O";
        
    }
    

    //  NSString *url = @"http://qbs-instahack.rhcloud.com/donors?bg=A+&lon=51&lat=-114&limit=4";
    NSString *latitude = [NSString stringWithFormat:@"%f", [currentLocation coordinate].latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", [currentLocation coordinate].longitude];
    
    NSString *url = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/donors?bg=%@&lon=%@&lat=%@&limit=50",bldType,longitude,latitude];
    NSLog(@"Nearby Search  URl-> %@",url);
    
    [[BLDLineUrlInvoker sharedInstance] initWithURL:url andProcessName:@selector(processgetnearbygroups:)  requestMethod:@"GET" withObject:self];


}

-(void)processgetnearbygroups:(NSData*)responsedata{

    NSError *error;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responsedata options:kNilOptions error:&error];
    NSArray *array = [dictionary objectForKey:@"model"];
    
    if ([array count]==0) {
       
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Search Result.."
                                                          message:@"No match record found nearby."
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
        [message show];
       

    }else{
      self.nearbyBloodGpListl = [NSMutableArray arrayWithArray:array];

    [self addAnnotation];
    }

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"ok Pressed");
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        return;
    }
}

-(void)addAnnotation2{
    
    // self.nearbyBloodGpListl = [NSMutableArray alloc]initWithObjects:-122.477989;, nil
    CLLocationCoordinate2D userCR = { 18.520510 , 73.856733};

   MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(userCR , 2000, 2000);
    [self.mapView setRegion:region];
         for (int i=0; i < 5; i++) {
                     CGFloat latDelta = rand()*.035/RAND_MAX -.02;
                       CGFloat longDelta = rand()*.03/RAND_MAX -.015;
   
             	        CLLocationCoordinate2D newCoord = { 18.520510 + latDelta, 73.856733 + longDelta };
    ////                BLDLineMapPoint *mp = [[BLDLineMapPoint alloc] initWithCoordinate:newCoord title:[NSString stringWithFormat:@" Home %d",i] subTitle:@"Home Sweet Home"];
                Annotation *ann = [[Annotation alloc]initWithLocation:newCoord];
               ann.title = @"AB +";
               ann.subtitle = @"";
               ann.bloodGrp =  @"AB+";
    
          	   [self.mapView addAnnotation:ann];
       	       [self.mapView selectAnnotation:ann animated:YES];
    //            	         
           }

}
-(void)addAnnotation{

   // CLLocationCoordinate2D userCR = { 18.520510 , 73.856733};
    
    
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance([currentLocation coordinate] , 7000, 7000);
    [self.mapView setRegion:region];
    
    for (int i=0; i < [ self.nearbyBloodGpListl count]; i++) {
        
        NSDictionary *dic = [self.nearbyBloodGpListl objectAtIndex:i];
        NSString *bg = [dic objectForKey:@"bg"];
        NSArray *cordintates = [dic objectForKey:@"loc"];
        
        
      //  newCoord.latitude =  CLLocationDegrees lat = [coordinates[1] doubleValue];[cordintates objectForKey:@"lat"];
        double lat = [[cordintates objectAtIndex:1] doubleValue];
        double longitude =  [[cordintates  objectAtIndex:0] doubleValue];
       // CLLocationCoordinate2D newCoord  = CLLocationCoordinate2DMake(CLLocationDegrees latitude, CLLocationDegrees longitude)
    //    CLLocationCoordinate2D newCoord = {lat,longitude};
//
        
//        CGFloat latDelta = rand()*.035/RAND_MAX -.02;
//        CGFloat longDelta = rand()*.03/RAND_MAX -.015;
//
//        if (i!=0) {
//            return ;
//        }
       CLLocationCoordinate2D newCoord = {lat,longitude};
        Annotation *ann = [[Annotation alloc]initWithLocation:newCoord];
        ann.title = bg;
        ann.subtitle = @"";
        ann.bloodGrp = bg;
        
        [self.mapView addAnnotation:ann];
       // [self.mapView selectAnnotation:ann animated:YES];

     
        
    }
   

}

- (IBAction)backAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)mapTypeChanged:(id)sender {
    switch (self.mapSegment.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
