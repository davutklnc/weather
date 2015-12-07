//
//  ForecastMain.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastMain.h"


NSString *const kForecastMainHumidity = @"humidity";
NSString *const kForecastMainTempMin = @"temp_min";
NSString *const kForecastMainTempKf = @"temp_kf";
NSString *const kForecastMainTempMax = @"temp_max";
NSString *const kForecastMainTemp = @"temp";
NSString *const kForecastMainPressure = @"pressure";
NSString *const kForecastMainSeaLevel = @"sea_level";
NSString *const kForecastMainGrndLevel = @"grnd_level";


@interface ForecastMain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastMain

@synthesize humidity = _humidity;
@synthesize tempMin = _tempMin;
@synthesize tempKf = _tempKf;
@synthesize tempMax = _tempMax;
@synthesize temp = _temp;
@synthesize pressure = _pressure;
@synthesize seaLevel = _seaLevel;
@synthesize grndLevel = _grndLevel;


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
            self.humidity = [[self objectOrNilForKey:kForecastMainHumidity fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kForecastMainTempMin fromDictionary:dict] doubleValue];
            self.tempKf = [[self objectOrNilForKey:kForecastMainTempKf fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kForecastMainTempMax fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kForecastMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kForecastMainPressure fromDictionary:dict] doubleValue];
            self.seaLevel = [[self objectOrNilForKey:kForecastMainSeaLevel fromDictionary:dict] doubleValue];
            self.grndLevel = [[self objectOrNilForKey:kForecastMainGrndLevel fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kForecastMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kForecastMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempKf] forKey:kForecastMainTempKf];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kForecastMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kForecastMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kForecastMainPressure];
    [mutableDict setValue:[NSNumber numberWithDouble:self.seaLevel] forKey:kForecastMainSeaLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grndLevel] forKey:kForecastMainGrndLevel];

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

    self.humidity = [aDecoder decodeDoubleForKey:kForecastMainHumidity];
    self.tempMin = [aDecoder decodeDoubleForKey:kForecastMainTempMin];
    self.tempKf = [aDecoder decodeDoubleForKey:kForecastMainTempKf];
    self.tempMax = [aDecoder decodeDoubleForKey:kForecastMainTempMax];
    self.temp = [aDecoder decodeDoubleForKey:kForecastMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kForecastMainPressure];
    self.seaLevel = [aDecoder decodeDoubleForKey:kForecastMainSeaLevel];
    self.grndLevel = [aDecoder decodeDoubleForKey:kForecastMainGrndLevel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kForecastMainHumidity];
    [aCoder encodeDouble:_tempMin forKey:kForecastMainTempMin];
    [aCoder encodeDouble:_tempKf forKey:kForecastMainTempKf];
    [aCoder encodeDouble:_tempMax forKey:kForecastMainTempMax];
    [aCoder encodeDouble:_temp forKey:kForecastMainTemp];
    [aCoder encodeDouble:_pressure forKey:kForecastMainPressure];
    [aCoder encodeDouble:_seaLevel forKey:kForecastMainSeaLevel];
    [aCoder encodeDouble:_grndLevel forKey:kForecastMainGrndLevel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastMain *copy = [[ForecastMain alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.tempMin = self.tempMin;
        copy.tempKf = self.tempKf;
        copy.tempMax = self.tempMax;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
        copy.seaLevel = self.seaLevel;
        copy.grndLevel = self.grndLevel;
    }
    
    return copy;
}


@end
