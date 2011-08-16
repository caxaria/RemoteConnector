//
//  DataLoader.m
//  RemoteConnector
//
//  Created by João Caxaria on 8/11/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import "DataLoader.h"


@implementation DataLoader

@synthesize tag;

-(id) init
{
	self = [super init];
	
	return self;
}

-(void) dealloc
{
	[data release];
	data = nil;
	[super dealloc];
}

-(void) performRequest:(NSURLRequest*) urlRequest
{
	[data release];
	data = [[NSMutableData data] retain];
	[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}

-(NSData*) getData
{
	return data;
}

#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)remoteData
{
	[data appendData:remoteData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[connection release];
	[[NSNotificationCenter defaultCenter] postNotificationName:Notifications_DataLoader object:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[data release];
	data = nil;
	[[NSNotificationCenter defaultCenter] postNotificationName:Notifications_DataLoader object:self];
	
}
@end
