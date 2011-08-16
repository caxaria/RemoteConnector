//
//  RemoteConnector.m
//  RemoteConnector
//
//  Created by João Caxaria on 2/15/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//

#import "RemoteConnector.h"
#import "DataLoader.h"


@interface RemoteConnector (Private)

-(NSDictionary*) generateResult:(id) data :(NSString*) key;
-(NSString*) getRawRequest:(NSString*)url target:(id) target selector:(SEL)selector;
-(NSString*) postRawRequest:(NSString*)urlrequest variables:(NSDictionary*) variables target:(id) target selector:(SEL)selector;
-(NSString*) postJSONRequest:(NSString*)urlrequest variable:(NSString*) jsonString target:(id) target selector:(SEL)selector;

@end


@implementation RemoteConnector

-(id) init
{
	self = [super init];
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

-(NSDictionary*) generateResult:(id) data :(NSString*) key
{
	return [NSDictionary dictionaryWithObjectsAndKeys:data, @"data", key, @"key", nil]; 
}


#pragma mark GET
-(NSString*) getRequest:(NSString*)url
{
    return [self getRawRequest:url target:self selector:@selector(gotRawRequest:)];
}

-(NSString*) getRawRequest:(NSString*)url target:(id) target selector:(SEL)selector
{
    NSString* requestIdentifier = url;
    
	
	DataLoader* loader = [[DataLoader alloc] init];
	loader.tag = requestIdentifier;
	[[NSNotificationCenter defaultCenter] addObserver:target 
											 selector:selector 
												 name:Notifications_DataLoader 
											   object:loader];
	
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
													   timeoutInterval:timeout];
	
	[loader performRequest:request];
	
	return requestIdentifier;
}


#pragma mark POST

-(NSString*) postRequest:(NSString*)urlrequest variables:(NSDictionary*) variables
{
    return [self postRawRequest:urlrequest variables:variables target:self selector:@selector(gotRawRequest:)];
}

-(NSString*) postRawRequest:(NSString*)urlrequest variables:(NSDictionary*) variables target:(id) target selector:(SEL)selector
{
    NSString* requestIdentifier = urlrequest;
	
    NSString *post = @"";
    
    for (id key in [variables keyEnumerator]) {
        post = [post stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, [variables valueForKey:key]]];
    }        
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:urlrequest];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];	
    [request setTimeoutInterval:timeout];

    DataLoader* loader = [[DataLoader alloc] init];
	loader.tag = requestIdentifier;
	[[NSNotificationCenter defaultCenter] addObserver:target 
											 selector:selector 
												 name:Notifications_DataLoader 
											   object:loader];
	
	
	[loader performRequest:request];
    
	return requestIdentifier;
}


#pragma mark JSON

//ToDo: Refactor with POST method

-(NSString*) postJSONRequest:(NSString*)urlrequest variable:(NSString*) jsonString
{
    return [self postJSONRequest:urlrequest variable:jsonString target:self selector:@selector(gotRawRequest:)];
}

-(NSString*) postJSONRequest:(NSString*)urlrequest variable:(NSString*) jsonString target:(id) target selector:(SEL)selector
{
    NSString* requestIdentifier = urlrequest;
	
    NSString *post = jsonString;
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:urlrequest];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];	
    [request setTimeoutInterval:timeout];
    
    DataLoader* loader = [[DataLoader alloc] init];
	loader.tag = requestIdentifier;
	[[NSNotificationCenter defaultCenter] addObserver:target 
											 selector:selector 
												 name:Notifications_DataLoader 
											   object:loader];
	
	
	[loader performRequest:request];
    
	return requestIdentifier;
}

#pragma mark Events

-(void) gotRawRequest:(NSNotification*) sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notifications_DataLoader object:[sender object]];
	NSString* requestIdentifier = [(DataLoader*)[sender object] tag];
	NSData* remoteData = [[sender object] getData];
	
    [[sender object] autorelease];
    
	[[NSNotificationCenter defaultCenter] postNotificationName:requestIdentifier 
                                                        object:[self generateResult:remoteData :requestIdentifier]];
}



@end


