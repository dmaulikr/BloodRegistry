//
//  BLDLineUrlInvoker.h
//  BloodLine
//
//  Created by Avinash Kawade on 25/01/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import <Foundation/Foundation.h>

//// Protocol definition starts here
//@protocol BLDLineUrlInvokerDelegate <NSObject>
//@required
//- (void) processCompleted;
//@end

@interface BLDLineUrlInvoker : NSObject{

  NSMutableData *_responseData;
  
    id _delegate; 
  //id <BLDLineUrlInvokerDelegate> _delegate;
    NSString *callbackfunction;
    NSHTTPURLResponse *httpResponse;
    NSString *httpMethod;
    
}


@property(nonatomic,strong) id delegate;
@property(nonatomic,strong) NSString *callbackfunction;
@property(nonatomic,strong) NSString *httpMethod;

+ (id)sharedInstance;
-(void)initWithURL:(NSString*)url andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj;
-(void)upldateCoridinatesToServer;
-(void)registerUserToServer;
-(void)postRegistrationRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj;
-(void)postNotificationRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj;

-(void)postFeedBackRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj;
@end
