//
//  ForecastList.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastList.h"
#import "ForecastWind.h"
#import "ForecastClouds.h"
#import "ForecastRain.h"
#import "ForecastMain.h"
#import "ForecastWeather.h"
#import "ForecastSys.h"


NSString *const kForecastListWind = @"wind";
NSString *const kForecastListDtTxt = @"dt_txt";
NSString *const kForecastListClouds = @"clouds";
NSString *const kForecastListDt = @"dt";
NSString *const kForecastListRain = @"rain";
NSString *const kForecastListMain = @"main";
NSString *const kForecastListWeather = @"weather";
NSString *const kForecastListSys = @"sys";


@interface ForecastList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastList

@synthesize wind = _wind;
@synthesize dtTxt = _dtTxt;
@synthesize clouds = _clouds;
@synthesize dt = _dt;
@synthesize rain = _rain;
@synthesize main = _main;
@synthesize weather = _weather;
@synthesize sys = _sys;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.wind = [ForecastWind modelObjectWithDictionary:[dict objectForKey:kForecastListWind]];
            self.dtTxt = [self objectOrNilForKey:kForecastListDtTxt fromDictionary:dict];
            self.clouds = [ForecastClouds modelObjectWithDictionary:[dict objectForKey:kForecastListClouds]];
            self.dt = [[self objectOrNilForKey:kForecastListDt fromDictionary:dict] doubleValue];
            self.rain = [ForecastRain modelObjectWithDictionary:[dict objectForKey:kForecastListRain]];
            self.main = [ForecastMain modelObjectWithDictionary:[dict objectForKey:kForecastListMain]];
    NSObject *receivedForecastWeather = [dict objectForKey:kForecastListWeather];
    NSMutableArray *parsedForecastWeather = [NSMutableArray array];
    if ([receivedForecastWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedForecastWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedForecastWeather addObject:[ForecastWeather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedForecastWeather isKindOfClass:[NSDictionary class]]) {
       [parsedForecastWeather addObject:[ForecastWeather modelObjectWithDictionary:(NSDictionary *)receivedForecastWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedForecastWeather];
            self.sys = [ForecastSys modelObjectWithDictionary:[dict objectForKey:kForecastListSys]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kForecastListWind];
    [mutableDict setValue:self.dtTxt forKey:kForecastListDtTxt];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kForecastListClouds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kForecastListDt];
    [mutableDict setValue:[self.rain dictionaryRepresentation] forKey:kForecastListRain];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kForecastListMain];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kForecastListWeather];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kForecastListSys];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.wind = [aDecoder decodeObjectForKey:kForecastListWind];
    self.dtTxt = [aDecoder decodeObjectForKey:kForecastListDtTxt];
    self.clouds = [aDecoder decodeObjectForKey:kForecastListClouds];
    self.dt = [aDecoder decodeDoubleForKey:kForecastListDt];
    self.rain = [aDecoder decodeObjectForKey:kForecastListRain];
    self.main = [aDecoder decodeObjectForKey:kForecastListMain];
    self.weather = [aDecoder decodeObjectForKey:kForecastListWeather];
    self.sys = [aDecoder decodeObjectForKey:kForecastListSys];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kForecastListWind];
    [aCoder encodeObject:_dtTxt forKey:kForecastListDtTxt];
    [aCoder encodeObject:_clouds forKey:kForecastListClouds];
    [aCoder encodeDouble:_dt forKey:kForecastListDt];
    [aCoder encodeObject:_rain forKey:kForecastListRain];
    [aCoder encodeObject:_main forKey:kForecastListMain];
    [aCoder encodeObject:_weather forKey:kForecastListWeather];
    [aCoder encodeObject:_sys forKey:kForecastListSys];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastList *copy = [[ForecastList alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.dtTxt = [self.dtTxt copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.dt = self.dt;
        copy.rain = [self.rain copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
    }
    
    return copy;
}


@end
