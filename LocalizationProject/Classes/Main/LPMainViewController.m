//
//  LPMainViewController.m
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import "LPMainViewController.h"
#import "LPHomeViewController.h"

@implementation LPMainViewController

- (id)init {
    self = [super init];
    if (self) {
        [self setUpContentNavigationController];
    }
    return self;
}

- (void)setUpContentNavigationController {
    LPHomeViewController *homeViewController = [[LPHomeViewController alloc] init];
    homeViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentNavigationController = [[UINavigationController alloc]
                                        initWithRootViewController:homeViewController];
    [self addChildViewController:self.contentNavigationController];
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.contentNavigationController.view];
}

@end
