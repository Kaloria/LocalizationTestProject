//
//  LPHomeViewController.m
//  LocalizationProject
//
//  Created by Ewa Zebrowska on 18.07.2013.
//  Copyright (c) 2013 Ewa Żebrowska. All rights reserved.
//

#import "LPHomeViewController.h"
#import "LPHomeView.h"
#import "LPTestModelResult.h"
#import "LPTestModel.h"
#import "LPConfig.h"

@interface LPHomeViewController ()
@property (nonatomic, strong) LPHomeView *homeView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *imageUrlString;
@end

@implementation LPHomeViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"MAIN_VIEW", nil);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self setUpLocationManagerAndMapView];
        [self dropPinAtCurrentPosition];
        [self loadLocation];
        
        self.view.userInteractionEnabled = NO;
    }
    return self;
}

- (void)dealloc {
    self.homeView = nil;
    self.locationManager = nil;
    self.imageUrlString = nil;
}

#pragma mark - Location methods

- (void)setUpLocationManagerAndMapView {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
    CGRect mapRect = CGRectMake(0.0,
                                 0.0,
                                 [UIScreen mainScreen].bounds.size.width,
                                 [UIScreen mainScreen].bounds.size.height);
    self.homeView = [[LPHomeView alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                               longitude:self.locationManager.location.coordinate.longitude
                                                andFrame:mapRect];
    
    self.homeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.homeView.mapView.delegate = self;
    [self.view addSubview:self.homeView];
}

- (void)loadLocation {
    RKResponseDescriptor *responseDescriptor = [LPTestModel testModelMapping];
    
    NSURL *URL = [NSURL URLWithString:apiUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.view.userInteractionEnabled = YES;
        
        LPTestModelResult *testObject = [mappingResult.array objectAtIndex:0];
        LPLocationModel *locationObject = testObject.location;
        
        self.imageUrlString = [NSString stringWithString:testObject.image];
        
        [self drawPinFromObject:testObject];
        [self setRegionFromLocation:locationObject];
        [self drawRouteFromLocation:locationObject];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", nil)
                                                        message:NSLocalizedString(@"ERROR_MESSAGE", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
        self.view.userInteractionEnabled = YES;
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

#pragma mark - Draw pin and route methods

/*
 Drawing the route between two location
 */
- (void)drawRouteFromLocation:(LPLocationModel *)locationObject {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                                             longitude:self.locationManager.location.coordinate.longitude];
    
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:[locationObject.latitude doubleValue]
                                                         longitude:[locationObject.longitude doubleValue]];
    
    CLLocationDistance distance = [pinLocation distanceFromLocation:currentLocation];
    NSString *distanceString = [NSString stringWithFormat:@"%f", (distance / 1000)];
                                
    self.homeView.localizationLabel.text = [NSString stringWithFormat:NSLocalizedString(@"DATA_LOADED", nil), distanceString, nil];
    
    NSArray *locationArray = [NSArray arrayWithObjects:pinLocation, currentLocation, nil];
    
    NSInteger numberOfSteps = locationArray.count;
    CLLocationCoordinate2D coordinates[numberOfSteps];
    
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [locationArray objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        coordinates[index] = coordinate;
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [self.homeView.mapView addOverlay:polyLine];
}

/*
 Polyline setting properties
 */
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor yellowColor];
    polylineView.lineWidth = 2.0;
    
    return polylineView;
}

/*
 Drawing pin for the location from json
 */
- (void)drawPinFromObject:(LPTestModelResult *)testObject {
    CLLocationCoordinate2D coordinate;
    LPLocationModel *locationObject = testObject.location;
    coordinate.latitude = [locationObject.latitude doubleValue];
    coordinate.longitude = [locationObject.longitude doubleValue];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:testObject.text];
    [self.homeView.mapView addAnnotation:annotation];
}

/*
 Drawing pin for current location
 */
- (void)dropPinAtCurrentPosition {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.locationManager.location.coordinate.latitude;
    coordinate.longitude = self.locationManager.location.coordinate.longitude;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    
    [self.homeView.mapView addAnnotation:annotation];
}

/*
 Move view to location
 */
- (void)setRegionFromLocation:(LPLocationModel *)locationObject {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    CLLocationCoordinate2D pin;
    pin.latitude = [locationObject.latitude doubleValue];
    pin.longitude = [locationObject.longitude doubleValue];
    
    region.span = span;
    region.center = pin;
    [self.homeView.mapView setRegion:region animated:YES];

}

@end
