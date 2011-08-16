//
//  RemoteConnectorTestsAppDelegate.h
//  RemoteConnectorTests
//
//  Created by João Caxaria on 8/11/11.
//  Copyright 2011 Imaginary Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemoteConnectorTestsViewController;

@interface RemoteConnectorTestsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RemoteConnectorTestsViewController *viewController;

@end
