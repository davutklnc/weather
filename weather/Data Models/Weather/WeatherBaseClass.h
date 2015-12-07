//
//  WeatherBaseClass.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherWind, WeatherClouds, WeatherCoord, WeatherMain, WeatherSys;

@interface WeatherBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) WeatherWind *wind;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) WeatherClouds *clouds;
@property (nonatomic, strong) WeatherCoord *coord;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double cod;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) WeatherMain *main;
@property (nonatomic, strong) WeatherSys *sys;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
