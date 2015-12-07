//
//  ConnectionManager.m
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "OpenWeatherClient.h"

#define OPENWEATHERBASEURL @"http://api.openweathermap.org/data/2.5"
@implementation OpenWeatherClient

// shared client and base url setted here

+ (instancetype)sharedClient {
    static OpenWeatherClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[OpenWeatherClient alloc] initWithBaseURL:[NSURL URLWithString:OPENWEATHERBASEURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}





@end
