//
//  WeatherSys.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherSys.h"


NSString *const kWeatherSysMessage = @"message";
NSString *const kWeatherSysCountry = @"country";
NSString *const kWeatherSysSunset = @"sunset";
NSString *const kWeatherSysSunrise = @"sunrise";


@interface WeatherSys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherSys

@synthesize message = _message;
@synthesize country = _country;
@synthesize sunset = _sunset;
@synthesize sunrise = _sunrise;


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
            self.message = [[self objectOrNilForKey:kWeatherSysMessage fromDictionary:dict] doubleValue];
            self.country = [self objectOrNilForKey:kWeatherSysCountry fromDictionary:dict];
            self.sunset = [[self objectOrNilForKey:kWeatherSysSunset fromDictionary:dict] doubleValue];
            self.sunrise = [[self objectOrNilForKey:kWeatherSysSunrise fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kWeatherSysMessage];
    [mutableDict setValue:self.country forKey:kWeatherSysCountry];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunset] forKey:kWeatherSysSunset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunrise] forKey:kWeatherSysSunrise];

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

    self.message = [aDecoder decodeDoubleForKey:kWeatherSysMessage];
    self.country = [aDecoder decodeObjectForKey:kWeatherSysCountry];
    self.sunset = [aDecoder decodeDoubleForKey:kWeatherSysSunset];
    self.sunrise = [aDecoder decodeDoubleForKey:kWeatherSysSunrise];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kWeatherSysMessage];
    [aCoder encodeObject:_country forKey:kWeatherSysCountry];
    [aCoder encodeDouble:_sunset forKey:kWeatherSysSunset];
    [aCoder encodeDouble:_sunrise forKey:kWeatherSysSunrise];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherSys *copy = [[WeatherSys alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.country = [self.country copyWithZone:zone];
        copy.sunset = self.sunset;
        copy.sunrise = self.sunrise;
    }
    
    return copy;
}


@end
