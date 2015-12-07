//
//  WeatherBaseClass.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherBaseClass.h"
#import "WeatherWind.h"
#import "WeatherClouds.h"
#import "WeatherCoord.h"
#import "WeatherWeather.h"
#import "WeatherMain.h"
#import "WeatherSys.h"


NSString *const kWeatherBaseClassWind = @"wind";
NSString *const kWeatherBaseClassBase = @"base";
NSString *const kWeatherBaseClassClouds = @"clouds";
NSString *const kWeatherBaseClassCoord = @"coord";
NSString *const kWeatherBaseClassId = @"id";
NSString *const kWeatherBaseClassDt = @"dt";
NSString *const kWeatherBaseClassCod = @"cod";
NSString *const kWeatherBaseClassWeather = @"weather";
NSString *const kWeatherBaseClassMain = @"main";
NSString *const kWeatherBaseClassSys = @"sys";
NSString *const kWeatherBaseClassName = @"name";


@interface WeatherBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherBaseClass

@synthesize wind = _wind;
@synthesize base = _base;
@synthesize clouds = _clouds;
@synthesize coord = _coord;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dt = _dt;
@synthesize cod = _cod;
@synthesize weather = _weather;
@synthesize main = _main;
@synthesize sys = _sys;
@synthesize name = _name;


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
            self.wind = [WeatherWind modelObjectWithDictionary:[dict objectForKey:kWeatherBaseClassWind]];
            self.base = [self objectOrNilForKey:kWeatherBaseClassBase fromDictionary:dict];
            self.clouds = [WeatherClouds modelObjectWithDictionary:[dict objectForKey:kWeatherBaseClassClouds]];
            self.coord = [WeatherCoord modelObjectWithDictionary:[dict objectForKey:kWeatherBaseClassCoord]];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kWeatherBaseClassId fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kWeatherBaseClassDt fromDictionary:dict] doubleValue];
            self.cod = [[self objectOrNilForKey:kWeatherBaseClassCod fromDictionary:dict] doubleValue];
    NSObject *receivedWeatherWeather = [dict objectForKey:kWeatherBaseClassWeather];
    NSMutableArray *parsedWeatherWeather = [NSMutableArray array];
    if ([receivedWeatherWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWeatherWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWeatherWeather addObject:[WeatherWeather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWeatherWeather isKindOfClass:[NSDictionary class]]) {
       [parsedWeatherWeather addObject:[WeatherWeather modelObjectWithDictionary:(NSDictionary *)receivedWeatherWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedWeatherWeather];
            self.main = [WeatherMain modelObjectWithDictionary:[dict objectForKey:kWeatherBaseClassMain]];
            self.sys = [WeatherSys modelObjectWithDictionary:[dict objectForKey:kWeatherBaseClassSys]];
            self.name = [self objectOrNilForKey:kWeatherBaseClassName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kWeatherBaseClassWind];
    [mutableDict setValue:self.base forKey:kWeatherBaseClassBase];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kWeatherBaseClassClouds];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kWeatherBaseClassCoord];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kWeatherBaseClassId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kWeatherBaseClassDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cod] forKey:kWeatherBaseClassCod];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kWeatherBaseClassWeather];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kWeatherBaseClassMain];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kWeatherBaseClassSys];
    [mutableDict setValue:self.name forKey:kWeatherBaseClassName];

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

    self.wind = [aDecoder decodeObjectForKey:kWeatherBaseClassWind];
    self.base = [aDecoder decodeObjectForKey:kWeatherBaseClassBase];
    self.clouds = [aDecoder decodeObjectForKey:kWeatherBaseClassClouds];
    self.coord = [aDecoder decodeObjectForKey:kWeatherBaseClassCoord];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kWeatherBaseClassId];
    self.dt = [aDecoder decodeDoubleForKey:kWeatherBaseClassDt];
    self.cod = [aDecoder decodeDoubleForKey:kWeatherBaseClassCod];
    self.weather = [aDecoder decodeObjectForKey:kWeatherBaseClassWeather];
    self.main = [aDecoder decodeObjectForKey:kWeatherBaseClassMain];
    self.sys = [aDecoder decodeObjectForKey:kWeatherBaseClassSys];
    self.name = [aDecoder decodeObjectForKey:kWeatherBaseClassName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kWeatherBaseClassWind];
    [aCoder encodeObject:_base forKey:kWeatherBaseClassBase];
    [aCoder encodeObject:_clouds forKey:kWeatherBaseClassClouds];
    [aCoder encodeObject:_coord forKey:kWeatherBaseClassCoord];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kWeatherBaseClassId];
    [aCoder encodeDouble:_dt forKey:kWeatherBaseClassDt];
    [aCoder encodeDouble:_cod forKey:kWeatherBaseClassCod];
    [aCoder encodeObject:_weather forKey:kWeatherBaseClassWeather];
    [aCoder encodeObject:_main forKey:kWeatherBaseClassMain];
    [aCoder encodeObject:_sys forKey:kWeatherBaseClassSys];
    [aCoder encodeObject:_name forKey:kWeatherBaseClassName];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherBaseClass *copy = [[WeatherBaseClass alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.base = [self.base copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.coord = [self.coord copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.dt = self.dt;
        copy.cod = self.cod;
        copy.weather = [self.weather copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
