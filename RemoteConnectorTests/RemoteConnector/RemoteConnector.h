//
//  RemoteConnector.h
//  RemoteConnector
//
//  Created by João Caxaria on 2/15/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

#define timeout 20.0

@interface RemoteConnector : NSObject {
}

/*
 Performs a GET to the specified URL.
 Returns a notification key that will be called with the GET result.
 The result will be a dictionary with 2 entries:
 Key - notification key to allow the RemoteConnector client to unregister.
 Data - NSData* with the GET result.
 */
-(NSString*) getRequest:(NSString*)url;

/*
 Performs a POST to the specified URL with the given variables.
 Returns a notification key that will be called with the POST result.
 The result will be a dictionary with 2 entries:
 Key - notification key to allow the RemoteConnector client to unregister.
 Data - NSData* with the POST result.
 */
-(NSString*) postRequest:(NSString*)urlrequest variables:(NSDictionary*) variables;

/*
 Performs a POST to the specified URL with the given JSON variable.
 Returns a notification key that will be called with the POST result.
 The result will be a dictionary with 2 entries:
 Key - notification key to allow the RemoteConnector client to unregister.
 Data - NSData* with the POST result.
 */
-(NSString*) postJSONRequest:(NSString*)urlrequest variable:(NSString*) jsonString;
@end


