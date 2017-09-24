//
//  BLDLineRegisterViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 01/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GAITrackedViewController.h"


@interface BLDLineRegisterViewController : GAITrackedViewController<UITextFieldDelegate,CLLocationManagerDelegate>{
    
    NSMutableArray *bloodTypeListArray;
    CLLocation *currentLocation;
}
@property (strong, nonatomic)IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic)IBOutlet UIButton *registerButton;
@property (strong, nonatomic)IBOutlet UIButton *dropDownButton;
@property (strong, nonatomic)IBOutlet UIButton *skipButton;
@property (strong, nonatomic)IBOutlet UITextField *selectedBloodType;
@property(nonatomic,strong)NSMutableArray *bloodTypeListArray;
@property(nonatomic,retain)NSMutableDictionary *bloodTypeListDictionay;

@property (strong, nonatomic)IBOutlet UITableView *regBloodTypeList;
@property(nonatomic, strong)CLLocationManager *locationManager;


-(IBAction)dropDownClicked:(id)sender;
-(IBAction)closeBtnlicked:(id)sender;
@end


