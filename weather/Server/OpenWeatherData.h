//
//  OepnWeatherData.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

@class AFHTTPRequestOperationManager;

@interface OpenWeatherData : NSObject
+ (NSURLSessionDataTask *)getcurrentWeatherDataWithLatitude:(double)lat
                                              andLongtitude:(double)longt
                                                       data:(void (^)(WeatherBaseClass *data, NSError *error))block;

+ (NSURLSessionDataTask *)getForecastDataWithLatitude:(double)lat
                                       andLongtitude:(double)longt
                                                data:(void (^)(ForecastBaseClass *data, NSError *error))block;

+ (NSURLSessionDataTask *)getForecastDataWithCity:(NSString *)city
                                             data:(void (^)(ForecastBaseClass *data, NSError *error))block ;

+ (NSURLSessionDataTask *)getcurrentWeatherDataWithCity:(NSString *)city
                                                   data:(void (^)(WeatherBaseClass *data, NSError *error))block ;


// Normally we would get city list data from server. But since I openweatherapi dont have such call I called them with local json file
// Still i will implement it here for future releases from openweatherapi
+ (void)getAllCities:(void (^)(NSDictionary *cities, NSError *error))block;

@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end
