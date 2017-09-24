//
//  BLDLineMessagesViewController.h
//  BloodLine
//
//  Created by Avinash Kawade on 27/02/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface BLDLineMessagesViewController : GAITrackedViewController

@property(nonatomic,retain)NSMutableArray *notificationsListArray;
@property (strong, nonatomic)IBOutlet UITableView *notificationsList;

- (void)viewWillAppear:(BOOL)animated;

@end
