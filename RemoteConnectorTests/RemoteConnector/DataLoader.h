//
//  DataLoader.h
//  RemoteConnector
//
//  Created by João Caxaria on 8/11/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Notifications_DataLoader @"Notifications_DataLoader"

@interface DataLoader : NSObject {
	NSMutableData* data;
	NSString* tag;
}

-(void) performRequest:(NSURLRequest*) urlRequest;
-(NSData*) getData;

@property (retain) NSString* tag;

@end
