//
//  ForecastWeather.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastWeather.h"


NSString *const kForecastWeatherId = @"id";
NSString *const kForecastWeatherMain = @"main";
NSString *const kForecastWeatherIcon = @"icon";
NSString *const kForecastWeatherDescription = @"description";


@interface ForecastWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastWeather

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
            self.weatherIdentifier = [[self objectOrNilForKey:kForecastWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kForecastWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kForecastWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kForecastWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kForecastWeatherId];
    [mutableDict setValue:self.main forKey:kForecastWeatherMain];
    [mutableDict setValue:self.icon forKey:kForecastWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kForecastWeatherDescription];

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

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kForecastWeatherId];
    self.main = [aDecoder decodeObjectForKey:kForecastWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kForecastWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kForecastWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kForecastWeatherId];
    [aCoder encodeObject:_main forKey:kForecastWeatherMain];
    [aCoder encodeObject:_icon forKey:kForecastWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kForecastWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastWeather *copy = [[ForecastWeather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
