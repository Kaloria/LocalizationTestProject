//
//  LPAppDelegate.m
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "LPAppDelegate.h"
#import "LPMainViewController.h"

@implementation LPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    
    LPMainViewController *mainViewController = [[LPMainViewController alloc] init];
    [self.window setRootViewController:mainViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
