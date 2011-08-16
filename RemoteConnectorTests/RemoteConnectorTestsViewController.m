//
//  RemoteConnectorTestsViewController.m
//  RemoteConnectorTests
//
//  Created by João Caxaria on 8/11/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//

#import "RemoteConnectorTestsViewController.h"
#import "RemoteConnector.h"

@implementation RemoteConnectorTestsViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    remoteConnector = [[RemoteConnector alloc] init];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark IBAction

-(IBAction) testGET:(id)sender
{
    //Start GET Request and get notification key
    NSString* requestNotificationKey = [remoteConnector getRequest:@"http://caxaria.wordpress.com"];
    
    //Register in notification center with the notification key
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotResult:) name:requestNotificationKey object:nil];
}


-(IBAction) testPOST:(id)sender
{
    //Create post request variables. This request will be ?s=objc&
    NSDictionary* variables = [NSDictionary dictionaryWithObjectsAndKeys:@"objc", @"s", nil];
    
    //Start POST Request and get notification key
    NSString* requestNotificationKey = [remoteConnector postRequest:@"http://caxaria.wordpress.com" variables:variables];
    
    //Register in notification center with the notification key
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotResult:) name:requestNotificationKey object:nil];
}

#pragma mark events

-(void) gotResult:(NSNotification*) notification
{
    //Get result
    NSDictionary* getResult = (NSDictionary*)[notification object];
    
    //Get request key
    NSString* requestNotificationKey = [getResult objectForKey:@"key"];
    
    //Unregister for notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:requestNotificationKey object:nil];
	
    //Get request data
    NSData* data = [getResult objectForKey:@"data"];
    
    [webView loadData:data MIMEType:nil textEncodingName:nil baseURL:nil];
}






@end
