//
//  WeatherCoord.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherCoord.h"


NSString *const kWeatherCoordLon = @"lon";
NSString *const kWeatherCoordLat = @"lat";


@interface WeatherCoord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherCoord

@synthesize lon = _lon;
@synthesize lat = _lat;


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
            self.lon = [[self objectOrNilForKey:kWeatherCoordLon fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kWeatherCoordLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kWeatherCoordLon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kWeatherCoordLat];

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

    self.lon = [aDecoder decodeDoubleForKey:kWeatherCoordLon];
    self.lat = [aDecoder decodeDoubleForKey:kWeatherCoordLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lon forKey:kWeatherCoordLon];
    [aCoder encodeDouble:_lat forKey:kWeatherCoordLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherCoord *copy = [[WeatherCoord alloc] init];
    
    if (copy) {

        copy.lon = self.lon;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
