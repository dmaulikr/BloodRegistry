//
//  BLDLineUrlInvoker.m
//  BloodLine
//
//  Created by Avinash Kawade on 25/01/14.
//  Copyright (c) 2014 Avinash Kawade. All rights reserved.
//

#import "BLDLineUrlInvoker.h"

@implementation BLDLineUrlInvoker

@synthesize delegate,callbackfunction,httpMethod;


static BLDLineUrlInvoker *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (BLDLineUrlInvoker *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];//[[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}
#pragma mark NSURLConnection Delegate Methods

-(void)initWithURL:(NSString*)url andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj{
    
    NSLog(@"Sending request - %@",url);
// Create the request.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.delegate = obj;
    self.callbackfunction = NSStringFromSelector(process) ;
    self.httpMethod = method;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                    cachePolicy:NSURLCacheStorageNotAllowed
                                                timeoutInterval:60.0];
    [request setHTTPMethod:self.httpMethod];
//  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

//     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url  stringByAddingPercentEscapesUsingEncoding:
//                                                                            NSUTF8StringEncoding]]
//                                                        cachePolicy:NSURLCacheStorageNotAllowed
//                                                  timeoutInterval:20.0];
    
    // [request setURL:[NSURL URLWithString:urlString]];
// Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
 [conn start];


}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    httpResponse = (NSHTTPURLResponse *)response;
    int statusCode = [httpResponse statusCode];
    NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
    NSLog(@"HTTP Status code: %d", statusCode);
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *returnString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
  

     NSLog(@"returnString %@",returnString);
   [delegate performSelector:NSSelectorFromString(self.callbackfunction) withObject:_responseData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
     NSLog(@"Error  %@",[error description]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


-(void)postRegistrationRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj

{
       [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.delegate = obj;
    self.callbackfunction = NSStringFromSelector(process) ;
    self.httpMethod = method;
    //Server Address URL

    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[param objectForKey:@"url"]]
                                                           cachePolicy:NSURLCacheStorageNotAllowed
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:self.httpMethod];

    
    NSMutableData *body = [NSMutableData data];
    
  
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"phone"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"phone"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"bg\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"bg"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   //  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //parameter second
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_second" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lon\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterSecond )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"lon"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   //  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter third
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_third" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lat\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterThird )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"lat"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //parameter third
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_third" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterThird )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"device_id"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //parameter third
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_third" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterThird )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"device_type"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   //  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Request  = %@",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    //setting the body of the post to the reqeust
    [request setHTTPBody:body];
//    
    //now lets make the connection to the web
     NSURLResponse *response = nil;
    NSHTTPURLResponse *httpResponse = nil;
  //  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];


    }



 -(void)postNotificationRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj
 
 {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 self.delegate = obj;
 self.callbackfunction = NSStringFromSelector(process) ;
 self.httpMethod = method;
 //Server Address URL
 
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[param objectForKey:@"url"]]
 cachePolicy:NSURLCacheStorageNotAllowed
 timeoutInterval:60.0];
 [request setHTTPMethod:self.httpMethod];
 
 
 NSMutableData *body = [NSMutableData data];
 
 
 //    NSString *boundary = @"---------------------------14737809831466499882746641449";
 //    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 //    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 //    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 //
 //    //parameter first
 //    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //    //Attaching the key name @"parameter_first" to the post body
 //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //    //Attaching the content to be posted ( ParameterFirst )
 //    [body appendData:[[NSString stringWithFormat:@"%@",@"1234567"] dataUsingEncoding:NSUTF8StringEncoding]];
 //    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 //
 
 
 NSString *boundary = @"---------------------------14737809831466499882746641449";
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 
 
 //parameter first
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_first" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterFirst )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"phone"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 //parameter first
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_first" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterFirst )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"phone"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 //parameter second
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_first" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"bg\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterFirst )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"bg"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 //parameter third
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_second" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lon\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterSecond )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"lon"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 //parameter fourth
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_third" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lat\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterThird )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"lat"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 //parameter fifth
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_third" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterThird )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"device_id"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 //parameter sixth
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the key name @"parameter_third" to the post body
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"priority\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //Attaching the content to be posted ( ParameterThird )
 [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"priority"]] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 //close form
 [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSLog(@"Request  = %@",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
 
 //setting the body of the post to the reqeust
 [request setHTTPBody:body];
 //
 //now lets make the connection to the web
 NSURLResponse *response = nil;
 NSHTTPURLResponse *httpResponse = nil;
 //  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
 
 // Create url connection and fire request
 NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
 
 [conn start];
 
 
 }

 

-(void)postFeedBackRequest:(NSDictionary*)param  andProcessName:(SEL)process requestMethod:(NSString*)method withObject:(id)obj

{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.delegate = obj;
    self.callbackfunction = NSStringFromSelector(process) ;
    self.httpMethod = method;
    //Server Address URL
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[param objectForKey:@"url"]]
                                                           cachePolicy:NSURLCacheStorageNotAllowed
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:self.httpMethod];
    
    
    NSMutableData *body = [NSMutableData data];
    
    

    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
     

    
    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"phone"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"user_id"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter first
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"rating\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"rating"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter second
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_first" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"message\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterFirst )
    [body appendData:[[NSString stringWithFormat:@"%@",[param objectForKey:@"message"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Request  = %@",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    //setting the body of the post to the reqeust
    [request setHTTPBody:body];
    //
    //now lets make the connection to the web
    NSURLResponse *response = nil;
    NSHTTPURLResponse *httpResponse = nil;
    //  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
    
    
}




/*
-(void)registerUserToServer
{
    //Server Address URL
//http://qbs-instahack.rhcloud.com/donor?bg=O-&phone=9494397926

    NSString *urlString = [NSString stringWithFormat:@"http://qbs-instahack.rhcloud.com/donor?"];
 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
 
    //// NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[urlString  stringByAddingPercentEscapesUsingEncoding:
    //                                                                        NSUTF8StringEncoding]]
    //                                                    cachePolicy:NSURLCacheStorageNotAllowed
    //                                              timeoutInterval:20.0];
    
    // [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    //parameter second
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_second" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"bg\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterSecond )
    [body appendData:[[NSString stringWithFormat:@"%@",@"O-"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //parameter third
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the key name @"parameter_third" to the post body
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //Attaching the content to be posted ( ParameterThird )
    [body appendData:[[NSString stringWithFormat:@"%@",@"9890365596"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Request  = %@",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    //setting the body of the post to the reqeust
    [request setHTTPBody:body];
    //
    //now lets make the connection to the web
    NSURLResponse *response = nil;
    NSHTTPURLResponse *httpResponse = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    httpResponse = (NSHTTPURLResponse *)response;
    int statusCode = [httpResponse statusCode];
    NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
    NSLog(@"HTTP Status code: %d", statusCode);
    
    // Create url connection and fire request
    
    //
    //    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //
    //    [conn start];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString %@",returnString);
}*/

@end
