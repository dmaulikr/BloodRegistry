//
//  BLDLineViewController.m
//  BloodLine
//
//  Created by Avinash Kawade on 01/03/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//
//

#import "BLDLineViewController.h"
#import "BLDLineAppDelegate.h"

@interface BLDLineViewController ()

@end

@implementation BLDLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
      // [menu setBackgroundColor:[UIColor whiteColor]];
    
    // searchNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchNavigationIdentifier"];
    [self.navigationController.navigationBar setHidden:YES];

    searchNearbyVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchNearbyIdentifier"];
    
 
    
    mainNavigationController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigationIdentifier"];

 
   // self.view.window.rootViewController = mainNavigationController;
   
    

    searchNavigationController = [[BLDLineSearchNavigationController alloc] initWithRootViewController:searchNearbyVC];
    
    
    notifyVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"NotifyViewIdentifier"];
    
    messageVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesIdentifier"];
    
    
    feedBackVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedBackIdentifier"];
    
    registerVC =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewIdentifier"];
    moreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreViewIdentifier"];
    
    
    currentViewController = searchNavigationController;
    [self resizeInitalViews];
    
    [menu setDelegate:self];

   // [self addChildViewController:searchNavigationController];

    [self.view addSubview:searchNavigationController.view];
    [self.view addSubview:menu];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"UserID"];
    
    
    if ([userID length]==0||userID == nil) {
        
        [self registerView];
    }

   
    
}

- (void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES animated:YES];


}
-(void)resizeInitalViews{
    
    if(isiPhone5){
        
        searchNearbyVC.view.frame = CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 450);
        //searchNearbyVC.searchButton.frame = CGRectMake(searchNearbyVC.searchButton.frame.origin.x, searchNearbyVC.view.frame.size.height-250, searchNearbyVC.searchButton.frame.size.width, searchNearbyVC.searchButton.frame.size.height);
        searchNavigationController.view.frame =  CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 450);
        notifyVC.view.frame = CGRectMake(notifyVC.view.frame.origin.x, notifyVC.view.frame.origin.y-20, 320, 450);
        messageVC.view.frame = CGRectMake(messageVC.view.frame.origin.x, messageVC.view.frame.origin.y-20, 320, 450);
        feedBackVC.view.frame = CGRectMake(feedBackVC.view.frame.origin.x, feedBackVC.view.frame.origin.y-20, 320, 450);
        registerVC.view.frame = CGRectMake(registerVC.view.frame.origin.x, registerVC.view.frame.origin.y-20, 320, 450);
        moreVC.view.frame = CGRectMake(moreVC.view.frame.origin.x, moreVC.view.frame.origin.y-20, 320, 450);
        if (menu==nil)
            menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, 450, 320, 165)];
        else menu.frame = CGRectMake(0, 450, 320, 165);
        
    }else{
        
        searchNearbyVC.view.frame = CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 400);
        // searchNearbyVC.searchButton.frame = CGRectMake(searchNearbyVC.searchButton.frame.origin.x, searchNearbyVC.view.frame.size.height-100, searchNearbyVC.searchButton.frame.size.width, searchNearbyVC.searchButton.frame.size.height);
        searchNavigationController.view.frame =  CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y-10, 320, 400);
        notifyVC.view.frame = CGRectMake(notifyVC.view.frame.origin.x, notifyVC.view.frame.origin.y-20, 320, 400);
        messageVC.view.frame = CGRectMake(messageVC.view.frame.origin.x, messageVC.view.frame.origin.y-20, 320, 400);
        feedBackVC.view.frame = CGRectMake(feedBackVC.view.frame.origin.x, feedBackVC.view.frame.origin.y-20, 320, 400);
        registerVC.view.frame = CGRectMake(registerVC.view.frame.origin.x, registerVC.view.frame.origin.y-20, 320, 400);
        moreVC.view.frame = CGRectMake(moreVC.view.frame.origin.x, moreVC.view.frame.origin.y-20, 320, 400);

        
        if (menu==nil)
            menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, 400, 320, 165)];
        else
            menu.frame = CGRectMake(0, 400, 320, 165);
        
        
    }


}
-(void)resizeAllSubView{
    

if(isiPhone5){
    
    searchNearbyVC.view.frame = CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 450);
   // searchNearbyVC.searchButton.frame = CGRectMake(searchNearbyVC.searchButton.frame.origin.x, searchNearbyVC.view.frame.size.height-250, searchNearbyVC.searchButton.frame.size.width, searchNearbyVC.searchButton.frame.size.height);

    searchNavigationController.view.frame =  CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 450);
    notifyVC.view.frame = CGRectMake(notifyVC.view.frame.origin.x, notifyVC.view.frame.origin.y, 320, 450);
    messageVC.view.frame = CGRectMake(messageVC.view.frame.origin.x, messageVC.view.frame.origin.y, 320, 450);
    feedBackVC.view.frame = CGRectMake(feedBackVC.view.frame.origin.x, feedBackVC.view.frame.origin.y, 320, 450);
    registerVC.view.frame = CGRectMake(registerVC.view.frame.origin.x, registerVC.view.frame.origin.y, 320, 450);
    moreVC.view.frame = CGRectMake(moreVC.view.frame.origin.x, moreVC.view.frame.origin.y, 320, 450);
    
    if (menu==nil)
        menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, 450, 320, 165)];
    else menu.frame = CGRectMake(0, 450, 320, 165);
    
}else{
    
    searchNearbyVC.view.frame = CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 400);
   // searchNearbyVC.searchButton.frame = CGRectMake(searchNearbyVC.searchButton.frame.origin.x, searchNearbyVC.view.frame.size.height-100, searchNearbyVC.searchButton.frame.size.width, searchNearbyVC.searchButton.frame.size.height);
    searchNavigationController.view.frame =  CGRectMake(searchNearbyVC.view.frame.origin.x, searchNearbyVC.view.frame.origin.y, 320, 400);
    notifyVC.view.frame = CGRectMake(notifyVC.view.frame.origin.x, notifyVC.view.frame.origin.y, 320, 400);
    messageVC.view.frame = CGRectMake(messageVC.view.frame.origin.x, messageVC.view.frame.origin.y, 320, 400);
    feedBackVC.view.frame = CGRectMake(feedBackVC.view.frame.origin.x, feedBackVC.view.frame.origin.y, 320, 400);
    registerVC.view.frame = CGRectMake(registerVC.view.frame.origin.x, registerVC.view.frame.origin.y, 320, 400);
    moreVC.view.frame = CGRectMake(moreVC.view.frame.origin.x, moreVC.view.frame.origin.y, 320, 400);

    if (menu==nil)
        menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, 400, 320, 165)];
    else
        menu.frame = CGRectMake(0, 400, 320, 165);
    
    
}
}
- (void)viewDidAppear:(BOOL)animated{

    // Get the stored data before the view loads
    


}
-(void)registerView{
    //do something
    
//    BLDLineRegisterViewController *registerVC = (BLDLineRegisterViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"BLDLineRegistercontoller"];
//   [self.parentViewController presentViewController:registerVC animated:YES completion:nil];
//    BLDLineAppDelegate *appDelegate = (BLDLineAppDelegate *) [[UIApplication sharedApplication] delegate];
//
   [self presentViewController:registerVC animated:YES completion:nil];
    //[[[UIApplication sharedApplication] keyWindow] addSubview:registerVC];
    //[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:registerVC animated:YES completion:nil];
    //[[UIApplication sharedApplication] keyWindow] addSubview:registerVC.view];
 
}

-(void)SearchBtnClick{
    
    [self removepreviousViewAddNew:searchNavigationController];
}
-(void)NotifyBtnClick{
    [self removepreviousViewAddNew:notifyVC];
    
}
-(void)MessageBtnClick{
    
    [self removepreviousViewAddNew:messageVC];
    
}
-(void)FeedBackBtnClick{
    
    
    [self removepreviousViewAddNew:feedBackVC];
    
}
-(void)MoreBtnClick{
    
    [self removepreviousViewAddNew:moreVC];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removepreviousViewAddNew:(UIViewController*)newView{
   // NSLog(@"Removing .. %@",currentViewController.view);
    [currentViewController.view removeFromSuperview];
    currentViewController = newView;
    [self.view addSubview:currentViewController.view];
    // NSLog(@"Adding  .. %@",newView.view);
    //NSLog(@"On   .. %@",self.view);
    [self resizeAllSubView];

}
@end
