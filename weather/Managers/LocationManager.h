//
//  LocationManager.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    BOOL hasAcceptableLocation ; // With some conditions location updates may repeat same value. once we have an acceptable one ignore the rest
}
@property (nonatomic, copy) void (^locationUpdated)(CLLocation *,NSError*);
-(void)askForCurrentLocation:(void (^)(CLLocation *location,NSError * error))block;
+ (instancetype)sharedInstance;
-(CLLocationManager *)getLocationManager;

@end
