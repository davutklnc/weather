//
//  LocationManager.m
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager


-(void)askForCurrentLocation:(void (^)(CLLocation *location,NSError * error))block
{
    [locationManager startUpdatingLocation];
    _locationUpdated = block;

}

- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self setUplocationManager];
    }
    return self;
}


+ (instancetype)sharedInstance
{
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
-(CLLocationManager *)getLocationManager
{
    return locationManager;
}
- (void) setUplocationManager
{
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager requestWhenInUseAuthorization];
        }
    }
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    if (_locationUpdated) {
        _locationUpdated(nil,error);
    }

}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [locationManager startUpdatingLocation];
        }
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    CLLocation *location;
    location =  [manager location];
    if (_locationUpdated) {
        if (!hasAcceptableLocation) {
            _locationUpdated(location,nil);
            hasAcceptableLocation = YES;
            // for future locations we need to set it NO
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                hasAcceptableLocation = NO;
            });
        }
    }
    [locationManager stopUpdatingLocation];

}



@end
