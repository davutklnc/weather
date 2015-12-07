//
//  CityCoord.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "CityCoord.h"


NSString *const kCityCoordLon = @"lon";
NSString *const kCityCoordLat = @"lat";


@interface CityCoord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityCoord

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
            self.lon = [[self objectOrNilForKey:kCityCoordLon fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kCityCoordLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kCityCoordLon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kCityCoordLat];

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

    self.lon = [aDecoder decodeDoubleForKey:kCityCoordLon];
    self.lat = [aDecoder decodeDoubleForKey:kCityCoordLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lon forKey:kCityCoordLon];
    [aCoder encodeDouble:_lat forKey:kCityCoordLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityCoord *copy = [[CityCoord alloc] init];
    
    if (copy) {

        copy.lon = self.lon;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
