//
//  LPHomeView.h
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LPHomeView : UIView

/* Map */
@property (nonatomic, strong) MKMapView *mapView;

/* Property keeps information about distance from pin */
@property (nonatomic, strong) UILabel *localizationLabel;

/* Current position latitude */
@property (nonatomic) CGFloat latitude;
/* Current position longtidue */
@property (nonatomic) CGFloat longitude;

- (id)initWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude andFrame:(CGRect)frame;

@end
