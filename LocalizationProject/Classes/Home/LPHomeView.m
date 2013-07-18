//
//  LPHomeView.m
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import "LPHomeView.h"

const static CGFloat kLabelHeight = 100.0;
const static CGFloat kLabelMargin = 20.0;

@interface LPHomeView()

@end

@implementation LPHomeView

- (id)initWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
        [self setUpMap];
        [self setUpLabel];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)setUpMap {
    self.mapView = [[MKMapView alloc] init];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.mapType = MKMapTypeHybrid;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);

    [self addSubview:self.mapView];
}

- (void)setUpLabel {
    self.localizationLabel = [[UILabel alloc] init];
    self.localizationLabel.text = NSLocalizedString(@"PLEASE_WAIT_UNTIL_LOCATION_IS_LOADING", nil);
    self.localizationLabel.numberOfLines = 3;
    self.localizationLabel.textColor = [UIColor darkGrayColor];
    self.localizationLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.localizationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.localizationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    [self.localizationLabel sizeToFit];
    [self addSubview:self.localizationLabel];
}

- (void)layoutSubviews {
    CGFloat screenWidth = self.bounds.size.width;
    CGFloat screenHeight = self.bounds.size.height;
    
    self.mapView.frame = CGRectMake(0.0, 0.0, screenWidth, screenHeight - kLabelHeight);
    
    self.localizationLabel.frame = CGRectMake(kLabelMargin,
                                              CGRectGetHeight(self.mapView.frame),
                                              screenWidth - 2 * kLabelMargin,
                                              kLabelHeight);
}

@end
