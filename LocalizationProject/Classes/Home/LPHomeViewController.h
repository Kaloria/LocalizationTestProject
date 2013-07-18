//
//  LPHomeViewController.h
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LPBaseViewController.h"

@interface LPHomeViewController : LPBaseViewController <
UIScrollViewDelegate,
CLLocationManagerDelegate,
MKMapViewDelegate
>

@end
