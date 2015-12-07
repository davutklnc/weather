//
//  ForecastList.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForecastWind, ForecastClouds, ForecastRain, ForecastMain, ForecastSys;

@interface ForecastList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ForecastWind *wind;
@property (nonatomic, strong) NSString *dtTxt;
@property (nonatomic, strong) ForecastClouds *clouds;
@property (nonatomic, assign) double dt;
@property (nonatomic, strong) ForecastRain *rain;
@property (nonatomic, strong) ForecastMain *main;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) ForecastSys *sys;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
