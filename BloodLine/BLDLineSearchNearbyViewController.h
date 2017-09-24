//
//  BLDLineSearchNearbyViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDLineRegisterViewController.h"
#import "GAITrackedViewController.h"

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height < 568.0) && ([[UIScreen mainScreen] bounds].size.height >= 480.0))?TRUE:FALSE


@interface BLDLineSearchNearbyViewController : GAITrackedViewController<UITextFieldDelegate>{

NSMutableArray *bloodTypeListArray;
BLDLineRegisterViewController     *registerVC;

}
@property(nonatomic,retain)NSMutableArray *bloodTypeListArray;
@property(nonatomic,retain)NSMutableDictionary *bloodTypeListDictionay;

@property (strong, nonatomic)IBOutlet UIViewController  *registerView;
@property (strong, nonatomic)IBOutlet UITableView *srchBloodTypeList;
@property (strong, nonatomic)IBOutlet UIButton *dropDownBtn;
//@property (strong, nonatomic)IBOutlet UIButton *searchButton;
@property (strong, nonatomic) UIButton *searchButton;

@property (strong, nonatomic)IBOutlet UITextField *selectedBloodType;
@property (strong, nonatomic)IBOutlet UIView *tapTextFieldView;

-(IBAction)dropDownClicked:(id)sender;
-(IBAction)searchBtnClicked:(id)sender;
@end
