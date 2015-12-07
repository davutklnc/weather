//
//  WeatherWeather.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherWeather.h"


NSString *const kWeatherWeatherId = @"id";
NSString *const kWeatherWeatherMain = @"main";
NSString *const kWeatherWeatherIcon = @"icon";
NSString *const kWeatherWeatherDescription = @"description";


@interface WeatherWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherWeather

@synthesize weatherIdentifier = _weatherIdentifier;
@synthesize main = _main;
@synthesize icon = _icon;
@synthesize weatherDescription = _weatherDescription;


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
            self.weatherIdentifier = [[self objectOrNilForKey:kWeatherWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kWeatherWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kWeatherWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kWeatherWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kWeatherWeatherId];
    [mutableDict setValue:self.main forKey:kWeatherWeatherMain];
    [mutableDict setValue:self.icon forKey:kWeatherWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kWeatherWeatherDescription];

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

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kWeatherWeatherId];
    self.main = [aDecoder decodeObjectForKey:kWeatherWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kWeatherWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kWeatherWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kWeatherWeatherId];
    [aCoder encodeObject:_main forKey:kWeatherWeatherMain];
    [aCoder encodeObject:_icon forKey:kWeatherWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kWeatherWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherWeather *copy = [[WeatherWeather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
