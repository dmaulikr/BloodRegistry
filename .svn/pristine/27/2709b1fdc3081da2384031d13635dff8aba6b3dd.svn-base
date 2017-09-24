//
//  BLDLineViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 01/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MSMenuView.h"
#import "BLDLineSearchNearbyViewController.h"
#import "BLDLineNotifyViewController.h"
#import "BLDLineMessagesViewController.h"
#import "BLDLineFeedBackViewController.h"
#import "BLDLineSearchNavigationController.h"
#import "BLDLineRegisterViewController.h"
#import "BLDLineMoreViewController.h"

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE

//@class BLDLineSearchNearbyViewController;
//@class BLDLineNotifyViewController;

@interface BLDLineViewController : UIViewController{
    
    MSMenuView * menu;
    BLDLineSearchNearbyViewController *searchNearbyVC;
    BLDLineNotifyViewController       *notifyVC;
    BLDLineMessagesViewController     *messageVC;
    BLDLineFeedBackViewController     *feedBackVC;
    BLDLineRegisterViewController     *registerVC;
    BLDLineMoreViewController         *moreVC;
    UIViewController      *currentViewController;
    UINavigationController *mainNavigationController;
    BLDLineSearchNavigationController *searchNavigationController;
}

@end
