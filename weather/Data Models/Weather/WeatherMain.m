//
//  WeatherMain.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherMain.h"


NSString *const kWeatherMainHumidity = @"humidity";
NSString *const kWeatherMainTempMin = @"temp_min";
NSString *const kWeatherMainTempMax = @"temp_max";
NSString *const kWeatherMainTemp = @"temp";
NSString *const kWeatherMainPressure = @"pressure";
NSString *const kWeatherMainGrndLevel = @"grnd_level";
NSString *const kWeatherMainSeaLevel = @"sea_level";


@interface WeatherMain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherMain

@synthesize humidity = _humidity;
@synthesize tempMin = _tempMin;
@synthesize tempMax = _tempMax;
@synthesize temp = _temp;
@synthesize pressure = _pressure;
@synthesize grndLevel = _grndLevel;
@synthesize seaLevel = _seaLevel;


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
            self.humidity = [[self objectOrNilForKey:kWeatherMainHumidity fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kWeatherMainTempMin fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kWeatherMainTempMax fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kWeatherMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kWeatherMainPressure fromDictionary:dict] doubleValue];
            self.grndLevel = [[self objectOrNilForKey:kWeatherMainGrndLevel fromDictionary:dict] doubleValue];
            self.seaLevel = [[self objectOrNilForKey:kWeatherMainSeaLevel fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kWeatherMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kWeatherMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kWeatherMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kWeatherMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kWeatherMainPressure];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grndLevel] forKey:kWeatherMainGrndLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.seaLevel] forKey:kWeatherMainSeaLevel];

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

    self.humidity = [aDecoder decodeDoubleForKey:kWeatherMainHumidity];
    self.tempMin = [aDecoder decodeDoubleForKey:kWeatherMainTempMin];
    self.tempMax = [aDecoder decodeDoubleForKey:kWeatherMainTempMax];
    self.temp = [aDecoder decodeDoubleForKey:kWeatherMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kWeatherMainPressure];
    self.grndLevel = [aDecoder decodeDoubleForKey:kWeatherMainGrndLevel];
    self.seaLevel = [aDecoder decodeDoubleForKey:kWeatherMainSeaLevel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kWeatherMainHumidity];
    [aCoder encodeDouble:_tempMin forKey:kWeatherMainTempMin];
    [aCoder encodeDouble:_tempMax forKey:kWeatherMainTempMax];
    [aCoder encodeDouble:_temp forKey:kWeatherMainTemp];
    [aCoder encodeDouble:_pressure forKey:kWeatherMainPressure];
    [aCoder encodeDouble:_grndLevel forKey:kWeatherMainGrndLevel];
    [aCoder encodeDouble:_seaLevel forKey:kWeatherMainSeaLevel];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherMain *copy = [[WeatherMain alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.tempMin = self.tempMin;
        copy.tempMax = self.tempMax;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
        copy.grndLevel = self.grndLevel;
        copy.seaLevel = self.seaLevel;
    }
    
    return copy;
}


@end
