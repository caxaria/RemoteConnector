//
//  RemoteConnectorTestsViewController.h
//  RemoteConnectorTests
//
//  Created by João Caxaria on 8/11/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemoteConnector;
@interface RemoteConnectorTestsViewController : UIViewController
{
    RemoteConnector* remoteConnector;
    IBOutlet UIWebView* webView;

}

-(IBAction) testGET:(id)sender;
-(IBAction) testPOST:(id)sender;

@end
